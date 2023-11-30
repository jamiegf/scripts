DECLARE
	@UserName SYSNAME,
	@DeploymentTime CHAR(18),
	@DeploymentDB sysname,
	@ServerDetails NVARCHAR(512),
	@CRLF CHAR(2)

Select @DeploymentDB = DB_NAME()

SET	@CRLF = CHAR(13)+CHAR(10)
SET @UserName = SUSER_SNAME()+@CRLF
SET @DeploymentTime = CONVERT(CHAR(16),CURRENT_TIMESTAMP,120)+@CRLF
SET @ServerDetails=RTRIM(@@ServerName) + ' (' + RTRIM(CONVERT(nvarchar(20), SERVERPROPERTY('productversion'))) + ')'
PRINT '***************************************'
RAISERROR('DEPLOYMENT SERVER: %s%sDEPLOYMENT DB: %s%sDEPLOYMENT TIME:%sDEPLOYER: %s',10,1,@ServerDetails,@CRLF,@DeploymentDB,@CRLF,@DeploymentTime,@UserName)
PRINT '***************************************'

DECLARE @RCount INT, @MaxRecords INT;

SET NOCOUNT ON;

PRINT '----------------------------------------------- Prepare Temp Storage -----------------------------------------------'
/*
CREATE FUNCTION #CompositeAddressKey(
	AddressLine1 nvarchar(255)
,	AddressLine2 nvarchar(255)
,	City nvarchar(255)
,	PostCode nvarchar(100)
)
RETURNS NVARCHAR(865)
AS
BEGIN
	RETURN RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode))
END */
;
DECLARE @ScrambleStats TABLE (
	ScrambleCategory nvarchar(255) NOT NULL
,	ScrambleKey nvarchar(255) NOT NULL
,	RecordCount INT NOT NULL
,	MaxRecords INT NOT NULL
	);
	
CREATE TABLE #EmailMapping (
	ID INT NOT NULL IDENTITY(1,1) 
,	EmailAddress nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	MappedEmailAddress nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT $(ScrambledEmailAddress)
	);
	
CREATE TABLE #NameMapping (
	ID INT NOT NULL IDENTITY(1,1) 
,	[Name] nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	FirstName nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NULL
,	LastName nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NULL
,	MappedName nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	MappedFirstName nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	MappedLastName nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	AddressID INT NULL
	);
	
CREATE TABLE #AddressMapping (
	ID INT NOT NULL IDENTITY(1,1) 
,	CompositeAddressKey NVARCHAR(870) COLLATE SQL_Latin1_General_Cp1_CI_AS
,	AddressLine1 nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	AddressLine2 nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	City nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	PostCode nvarchar(100) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL
,	MappedAddressLine1 nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	MappedAddressLine2 nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	MappedCity nvarchar(255) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
,	MappedPostCode nvarchar(100) COLLATE SQL_Latin1_General_Cp1_CI_AS NOT NULL DEFAULT ''
	);

BEGIN TRY

	BEGIN TRANSACTION ScrambleTran

	PRINT '----------------------------------------------- PREP -----------------------------------------------'
	/***************************************************************************
	***
	*** Email Mapping
	***
	***************************************************************************/
	Print '----------------------------------------------- Prepare Email mapping''s -----------------------------------------------';
	PRINT 'Mapping Email: dbo.wnUsers.Email, dbo.wnUsers.AdditionalEmail';
	WITH EmailAddresses (Email) AS (
		SELECT [U].[Email] FROM [dbo].wnUsers [U]  WHERE ISNULL([U].[Email],'@wild.net') NOT LIKE '%@wild.net' AND DATALENGTH(ISNULL([U].[Email],''))>0
		UNION ALL
		SELECT [U].[AdditionalEmail] FROM [dbo].wnUsers [U]  WHERE [U].[AdditionalEmail] NOT LIKE '%@wild.net' AND DATALENGTH(ISNULL([U].[AdditionalEmail],''))>0
	)
	INSERT INTO #EmailMapping
			([EmailAddress]
			)
	SELECT DISTINCT EA.[Email] FROM [EmailAddresses] EA

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCommunications' AND [C].[COLUMN_NAME] = 'SenderEmailAddress')
	BEGIN
		PRINT 'Mapping Email: dbo.wnCommunications.SenderEmailAddress'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT C.SenderEmailAddress 
		FROM [dbo].wnCommunications C 
		WHERE [C].SenderEmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL([C].SenderEmailAddress,''''))>0
		AND [C].[SenderEmailAddress] COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'
	END

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCommunicationRecipients' AND [C].[COLUMN_NAME] = 'EmailAddress')
	BEGIN
		PRINT 'Mapping Email: dbo.wnCommunicationRecipients.EmailAddress'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT CR.EmailAddress 
		FROM [dbo].wnCommunicationRecipients CR
		WHERE CR.EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL(CR.EmailAddress,''''))>0
		AND CR.[EmailAddress] COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'

	END

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnInsureds' AND [C].[COLUMN_NAME] = 'EmailAddress')
	BEGIN
		PRINT 'Mapping Email: dbo.wnInsureds.EmailAddress'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT EmailAddress 
		FROM [dbo].wnInsureds
		WHERE EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL(EmailAddress,''''))>0
		AND [EmailAddress] COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'
	END

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnRisks' AND [C].[COLUMN_NAME] = 'InsuredPrimaryContactEmailAddress')
	BEGIN
		PRINT 'Mapping Email: dbo.wnRisks.InsuredPrimaryContactEmailAddress'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT InsuredPrimaryContactEmailAddress 
		FROM [dbo].wnRisks R 
		WHERE [R].InsuredPrimaryContactEmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL(InsuredPrimaryContactEmailAddress,''''))>0
		AND [InsuredPrimaryContactEmailAddress] COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'
	END

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBrokerLocations' AND [C].[COLUMN_NAME] = 'BillingAddressEmail')
	BEGIN
		PRINT 'Mapping Email: dbo.wnBrokerLocations.BillingAddressEmail'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT BL.BillingAddressEmail 
		FROM [dbo].wnBrokerLocations BL
		WHERE BL.BillingAddressEmail COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL(BL.BillingAddressEmail,''''))>0
		AND BL.[BillingAddressEmail] COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'
	END

	IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBrokerLocations' AND [C].[COLUMN_NAME] = 'AccountsContactEmail')
	BEGIN
		PRINT 'Mapping Email: dbo.wnBrokerLocations.AccountsContactEmail'
		EXEC sp_executeSQL @statement=N'INSERT INTO #EmailMapping ([EmailAddress])
		SELECT DISTINCT BL.AccountsContactEmail 
		FROM [dbo].wnBrokerLocations BL
		WHERE BL.AccountsContactEmail COLLATE SQL_Latin1_General_Cp1_CI_AS NOT LIKE ''%@wild.net'' AND DATALENGTH(ISNULL(BL.AccountsContactEmail,''''))>0
		AND BL.AccountsContactEmail COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT [EM].[EmailAddress] FROM #EmailMapping EM)'
	END

	/***************************************************************************
	***
	*** Address Mapping
	***
	***************************************************************************/
	Print '----------------------------------------------- Prepare Address mapping''s -----------------------------------------------';

	PRINT 'Preparing Address: dbo.wnInsureds'
	EXEC sp_executeSQL @statement=N'INSERT INTO #AddressMapping (CompositeAddressKey,	AddressLine1,	AddressLine2,	City,	PostCode)
	SELECT DISTINCT ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']''
	, AddressLine1,	AddressLine2,	City,	PostCode
	FROM [dbo].wnInsureds I
	WHERE ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT CompositeAddressKey FROM #AddressMapping AM)'

	PRINT 'Preparing Address: dbo.wnBrokerLocations'
	EXEC sp_executeSQL @statement=N'INSERT INTO #AddressMapping (CompositeAddressKey,	AddressLine1,	AddressLine2,	City,	PostCode)
	SELECT DISTINCT ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']''
	, AddressLine1,	AddressLine2,	City,	PostCode
	FROM [dbo].wnBrokerLocations BL
	WHERE ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT CompositeAddressKey FROM #AddressMapping AM)'

	PRINT 'Preparing Address: dbo.wnBranches'
	EXEC sp_executeSQL @statement=N'INSERT INTO #AddressMapping (CompositeAddressKey,	AddressLine1,	AddressLine2,	City,	PostCode)
	SELECT DISTINCT ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']''
	, AddressLine1,	AddressLine2,	City,	PostCode
	FROM [dbo].wnBranches B
	WHERE ''['' + RTRIM(LTRIM(AddressLine1)) + RTRIM(LTRIM(AddressLine2)) + RTRIM(LTRIM(City)) + RTRIM(LTRIM(PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT CompositeAddressKey FROM #AddressMapping AM)'

	/***************************************************************************
	***
	*** Name Mapping
	***
	***************************************************************************/
	Print '----------------------------------------------- Prepare Name mapping''s -----------------------------------------------';

	PRINT 'Mapping Names: dbo.wnUsers'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	FirstName,	LastName,	MappedName,	MappedFirstName,	MappedLastName)
	SELECT UserName,	RTRIM(LTRIM(ISNULL(FirstName,''''))) FirstName, RTRIM(LTRIM(ISNULL(LastName,''''))) LastName
	,	''U'' + Convert(nvarchar(245),GeneratedID), ''First '' + Convert(nvarchar(245),GeneratedID), ''Last '' + Convert(nvarchar(245),GeneratedID)
	FROM [dbo].wnUsers U
	WHERE UserName COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT Name FROM #NameMapping NM)'


	PRINT 'Mapping Names: dbo.wnCommunicationRecipients'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName)
	SELECT Name, ''CR'' + Convert(nvarchar(245),MIN(ID))
	FROM [dbo].wnCommunicationRecipients CR
	WHERE Name  COLLATE SQL_Latin1_General_Cp1_CI_AS NOT IN (SELECT Name FROM #NameMapping NM UNION ALL Select FirstName + '' '' + LastName FROM #NameMapping NM) 
	GROUP BY Name'

	PRINT 'Mapping Names: dbo.wnInsureds'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	FirstName,	LastName,	MappedName,	MappedFirstName,	MappedLastName, AddressID)
	SELECT 
		''['' + RTRIM(LTRIM(ISNULL(FirstName,''''))) + RTRIM(LTRIM(ISNULL(LastName,''''))) + '']''    Name
	,	RTRIM(LTRIM(ISNULL(FirstName,'''')))	FirstName
	,	RTRIM(LTRIM(ISNULL(LastName,'''')))		LastName
	,	''I'' + Convert(nvarchar(245),GeneratedID)
	,	''First '' + Convert(nvarchar(245),GeneratedID)
	,	''Last '' + Convert(nvarchar(245),GeneratedID)
	,	[AM].ID
	FROM [dbo].wnInsureds I
	LEFT JOIN #AddressMapping AM ON [AM].CompositeAddressKey = ''['' + RTRIM(LTRIM(I.AddressLine1)) + RTRIM(LTRIM(I.AddressLine2)) + RTRIM(LTRIM(I.City)) + RTRIM(LTRIM(I.PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
	WHERE ''['' + RTRIM(LTRIM(ISNULL(FirstName,''''))) + RTRIM(LTRIM(ISNULL(LastName,''''))) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT Name FROM #NameMapping NM)'

	PRINT 'Mapping Names: dbo.wnBinders'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName)
	SELECT Name, ''Bin'' + Convert(nvarchar(245),MIN(ID))
	FROM [dbo].wnBinders B
	WHERE Name COLLATE SQL_Latin1_General_Cp1_CI_AS  NOT IN (SELECT Name FROM #NameMapping NM) 
	GROUP BY Name'

	PRINT 'Mapping Names: dbo.wnCarriers'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName)
	SELECT Name, ''Car'' + Convert(nvarchar(245),MIN(ID))
	FROM [dbo].wnCarriers C
	WHERE Name COLLATE SQL_Latin1_General_Cp1_CI_AS  NOT IN (SELECT Name FROM #NameMapping NM) 
	GROUP BY Name'

	PRINT 'Mapping Names: dbo.wnBrokerCompanies'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName)
	SELECT Name, ''BC'' + Convert(nvarchar(245),MIN(ID))
	FROM [dbo].wnBrokerCompanies BC
	WHERE Name COLLATE SQL_Latin1_General_Cp1_CI_AS  NOT IN (SELECT Name FROM #NameMapping NM) 
	GROUP BY Name'

	PRINT 'Mapping Names: dbo.wnBrokerLocations.Name'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName, AddressID)
	SELECT 
		Name
	,	''BL.N'' + Convert(nvarchar(245),MIN([BL].[ID]))
	,	ISNULL([AM].ID,0) AddressID
	FROM [dbo].wnBrokerLocations BL
	LEFT JOIN #AddressMapping AM ON [AM].CompositeAddressKey = ''['' + RTRIM(LTRIM(BL.AddressLine1)) + RTRIM(LTRIM(BL.AddressLine2)) + RTRIM(LTRIM(BL.City)) + RTRIM(LTRIM(BL.PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
	WHERE [BL].Name COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT Name FROM #NameMapping NM)
	GROUP BY [BL].Name
	,	ISNULL([AM].ID,0)'

	PRINT 'Mapping Names: dbo.wnBrokerLocations.AccountsContactName'
	EXEC sp_executeSQL @statement=N'INSERT INTO #NameMapping (Name,	MappedName, AddressID)
	SELECT 
		AccountsContactName
	,	''BL.A'' + Convert(nvarchar(245),MIN([BL].[ID]))
	,	ISNULL([AM].ID,0) AddressID
	FROM [dbo].wnBrokerLocations BL
	LEFT JOIN #AddressMapping AM ON [AM].CompositeAddressKey = ''['' + RTRIM(LTRIM(BL.AddressLine1)) + RTRIM(LTRIM(BL.AddressLine2)) + RTRIM(LTRIM(BL.City)) + RTRIM(LTRIM(BL.PostCode)) + '']'' COLLATE SQL_Latin1_General_Cp1_CI_AS 
	WHERE [BL].AccountsContactName COLLATE SQL_Latin1_General_Cp1_CI_AS 
		 NOT IN (SELECT Name FROM #NameMapping NM)
	GROUP BY [BL].AccountsContactName
	,	ISNULL([AM].ID,0)'

	PRINT 'Mapping Addresses'
	UPDATE AM
	SET AM.[MappedAddressLine1] = '1.Line ' + CONVERT(Varchar,[AM].[ID])
	,	AM.[MappedAddressLine2] = '2.Line ' + CONVERT(Varchar,[AM].[ID])
	,	AM.[MappedCity] = 'City ' + CONVERT(Varchar,[AM].[ID])
	,	AM.[MappedPostCode] = 'PostCode ' + CONVERT(Varchar,[AM].[ID])
	FROM #AddressMapping AM



	/***************************************************************************
	***
	*** Scramble the Data
	***
	***************************************************************************/
	PRINT '----------------------------------------------- Crack some eggs and scramble the data -----------------------------------------------'
	IF $(ScrambleEmail) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleEmailScript)"'
--		:r $(ScriptPath)$(ScrambleEmailScript)

		PRINT 'Make email omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCommunications' AND [C].[COLUMN_NAME] = 'SenderEmailAddress')
		BEGIN
			PRINT '----- Scramble: [dbo].wnCommunications.SenderEmailAddress -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnCommunications] WC
			Update C
			SET [C].SenderEmailAddress = EM.MappedEmailAddress
			FROM [dbo].wnCommunications C
			INNER JOIN #EmailMapping EM ON 
				[C].[SenderEmailAddress] = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnCommunications.SenderEmailAddress', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnUsers' AND [C].[COLUMN_NAME] = 'Email')
		BEGIN
			PRINT '----- Scramble: [dbo].wnUsers.Email -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers] U
			Update U
			SET [U].Email = EM.MappedEmailAddress
			FROM [dbo].wnUsers U 
			INNER JOIN #EmailMapping EM ON 
				[U].[Email] = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnUsers.Email', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnUsers' AND [C].[COLUMN_NAME] = 'AdditionalEmail')
		BEGIN
			PRINT '----- Scramble: [dbo].wnUsers.AdditionalEmail -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers] U
			Update U
			SET [U].AdditionalEmail = EM.MappedEmailAddress
			FROM [dbo].wnUsers U 
			INNER JOIN #EmailMapping EM ON 
				[U].[AdditionalEmail] = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnUsers.AdditionalEmail', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCommunicationRecipients' AND [C].[COLUMN_NAME] = 'EmailAddress')
		BEGIN
			PRINT '----- Scramble: [dbo].wnCommunicationRecipients.EmailAddress -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnCommunicationRecipients]
			Update CR
			SET [CR].EmailAddress = EM.MappedEmailAddress
			FROM [dbo].[wnCommunicationRecipients] CR
			INNER JOIN #EmailMapping EM ON 
				[CR].EmailAddress = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnCommunicationRecipients.EmailAddress', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnInsureds' AND [C].[COLUMN_NAME] = 'EmailAddress')
		BEGIN
			PRINT '----- Scramble: [dbo].wnInsureds.EmailAddress -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnInsureds]
			Update I
			SET [I].EmailAddress = EM.MappedEmailAddress
			FROM [dbo].[wnInsureds] I
			INNER JOIN #EmailMapping EM ON 
				[I].EmailAddress = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnInsureds.EmailAddress', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnRisks' AND [C].[COLUMN_NAME] = 'InsuredPrimaryContactEmailAddress')
		BEGIN
			PRINT '----- Scramble: [dbo].wnRisks.InsuredPrimaryContactEmailAddress -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnRisks] 
			Update R
			SET [R].InsuredPrimaryContactEmailAddress = EM.MappedEmailAddress
			FROM [dbo].[wnRisks] R
			INNER JOIN #EmailMapping EM ON 
				[R].InsuredPrimaryContactEmailAddress = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnRisks.InsuredPrimaryContactEmailAddress', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBrokerLocations' AND [C].[COLUMN_NAME] = 'BillingAddressEmail')
		BEGIN
			PRINT '----- Scramble: [dbo].wnRisks.BillingAddressEmail -----';
			EXEC sp_executeSQL @statement=N'DECALER @RCount INT, @MaxRecords INT;
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBrokerLocations]
			Update BL
			SET [BL].BillingAddressEmail = EM.MappedEmailAddress
			FROM [dbo].[wnBrokerLocations] BL
			INNER JOIN #EmailMapping EM ON 
				[BL].BillingAddressEmail = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES (''Email Address'',''[dbo].wnBrokerLocations.BillingAddressEmail'', @RCount, @MaxRecords)
			PRINT ''----- Processed: '' + CONVERT(VARCHAR,@RCount) + ''/'' + CONVERT(VARCHAR,@MaxRecords) + ''('' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + ''%) -----'';
			'
		END
		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBrokerLocations' AND [C].[COLUMN_NAME] = 'AccountsContactEmail')
		BEGIN
			PRINT '----- Scramble: [dbo].wnBrokerLocations.AccountsContactEmail -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBrokerLocations]
			Update BL
			SET [BL].AccountsContactEmail = EM.MappedEmailAddress
			FROM [dbo].[wnBrokerLocations] BL
			INNER JOIN #EmailMapping EM ON 
				[BL].AccountsContactEmail = [EM].EmailAddress COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Email Address','[dbo].wnBrokerLocations.AccountsContactEmail', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
	END

	IF $(ScrambleUserNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleUserDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleUserDetailsScript)

		PRINT 'Make User Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnUsers' AND [C].[COLUMN_NAME] = 'FirstName')
		BEGIN
			PRINT '----- Scramble: [dbo].wnUsers.FirstName -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers]
			Update X
			SET [X].FirstName = EM.MappedFirstName
			FROM [dbo].[wnUsers] X
			INNER JOIN #NameMapping EM ON 
				[X].UserName = [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('User Details','[dbo].wnUsers.FirstName', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnUsers' AND [C].[COLUMN_NAME] = 'LastName')
		BEGIN
			PRINT '----- Scramble: [dbo].wnUsers.LastName -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers]
			Update X
			SET [X].LastName = EM.MappedLastName
			FROM [dbo].[wnUsers] X
			INNER JOIN #NameMapping EM ON 
				[X].UserName = [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('User Details','[dbo].wnUsers.LastName', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnUsers' AND [C].[COLUMN_NAME] = 'UserName')
		BEGIN
			PRINT '----- Scramble: [dbo].wnUsers.UserName -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers]
			Update X
			SET [X].UserName = EM.MappedName
			FROM [dbo].[wnUsers] X
			INNER JOIN #NameMapping EM ON 
				[X].UserName = [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('User Details','[dbo].wnUsers.UserName', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
	END
	
	IF $(ScrambleCommunicationRecipientNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleCommunicationRecipientDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleCommunicationRecipientDetailsScript)

		PRINT 'Make CommunicationRecipient Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCommunicationRecipients' AND [C].[COLUMN_NAME] = 'Name')
		BEGIN
			PRINT '----- Scramble: [dbo].wnCommunicationRecipients.Name -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnCommunicationRecipients]
			Update X
			SET [X].Name = EM.MappedName
			FROM [dbo].[wnCommunicationRecipients] X
			INNER JOIN #NameMapping EM ON 
				[X].Name = RTRIM(LTRIM([EM].FirstName + ' ' + [EM].LastName)) COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('User Details','[dbo].wnCommunicationRecipients.Name', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
	END
	
	IF $(ScrambleInsuredNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleInsuredDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleInsuredDetailsScript)

		PRINT 'Make Insured Details omlette';

			PRINT '----- Scramble: [dbo].wnInsureds.FirstName, [dbo].wnInsureds.LastName -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnInsureds]
			Update X
			SET [X].FirstName = EM.MappedFirstName
			,	[X].LastName = EM.MappedLastName
			FROM [dbo].[wnInsureds] X
			INNER JOIN #NameMapping EM ON 
				'[' + RTRIM(LTRIM(ISNULL([X].FirstName,''))) + RTRIM(LTRIM(ISNULL([X].LastName,''))) + ']' = [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Insured Details','[dbo].wnInsureds.FirstName, [dbo].wnInsureds.LastName', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';

	END	

	IF $(ScrambleBrokerLocationsNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleBrokerLocationsDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleBrokerLocationsDetailsScript)

		PRINT 'Make BrokerLocations Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBrokerLocations' AND [C].[COLUMN_NAME] = 'AccountsContactName')
		BEGIN
			PRINT '----- Scramble: [dbo].BrokerLocations.AccountsContactName -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBrokerLocations]
			Update X
			SET [X].AccountsContactName = EM.MappedFirstName + ' ' + [EM].MappedLastName
			FROM [dbo].[wnBrokerLocations] X
			INNER JOIN #NameMapping EM ON 
				[X].AccountsContactName =  [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Insured Details','[dbo].wnBrokerLocations.AccountsContactName', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
	END
	
	IF $(ScrambleMGANames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleMGADetailsScript)"'
--		:r $(ScriptPath)$(ScrambleMGADetailsScript)

		PRINT 'Make MGA Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnMGAs' AND [C].[COLUMN_NAME] = 'Name')
		BEGIN
			PRINT '----- Scramble: [dbo].wnMGAs.Name -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnMGAs]
			IF @MaxRecords > 0
			BEGIN
				Update X
				SET [X].Name = EM.MappedFirstName
				FROM [dbo].[wnMGAs] X
				INNER JOIN #NameMapping EM ON 
					[X].Name =  [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
				SELECT @RCount = @@ROWCOUNT

				INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
				VALUES ('Other Details','[dbo].wnMGAs.Name', @RCount, @MaxRecords)
				PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
			END
			ELSE
			BEGIN
					PRINT '----- Skipped: MGA''s not used -----';
			END
		END
	END

	IF $(ScrambleBinderNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleBinderDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleBinderDetailsScript)

		PRINT 'Make Binder Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnBinders' AND [C].[COLUMN_NAME] = 'Name')
		BEGIN
			PRINT '----- Scramble: [dbo].wnBinders.Name -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBinders]
			IF @MaxRecords > 0
			BEGIN
				Update X
				SET [X].Name = EM.MappedFirstName
				FROM [dbo].[wnBinders] X
				INNER JOIN #NameMapping EM ON 
					[X].Name =  [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
				SELECT @RCount = @@ROWCOUNT

				INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
				VALUES ('Other Details','[dbo].wnBinders.Name', @RCount, @MaxRecords)
				PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
			END
			ELSE
			BEGIN
					PRINT '----- Skipped: Binder''s not used -----';
			END
		END
	END

	IF $(ScrambleCarrierNames) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleCarrierDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleCarrierDetailsScript)

		PRINT 'Make Carrier Details omlette';

		IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[COLUMNS] C WHERE [C].[TABLE_SCHEMA] = 'dbo' AND [C].[TABLE_NAME] = 'wnCarriers' AND [C].[COLUMN_NAME] = 'Name')
		BEGIN
			PRINT '----- Scramble: [dbo].wnCarriers.Name -----';
			SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnCarriers]
			IF @MaxRecords > 0
			BEGIN
				Update X
				SET [X].Name = EM.MappedFirstName
				FROM [dbo].[wnCarriers] X
				INNER JOIN #NameMapping EM ON 
					[X].Name =  [EM].Name COLLATE SQL_Latin1_General_Cp1_CI_AS
				SELECT @RCount = @@ROWCOUNT

				INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
				VALUES ('Other Details','[dbo].wnCarriers.Name', @RCount, @MaxRecords)
				PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
			END
			ELSE
			BEGIN
					PRINT '----- Skipped: Carriers''s not used -----';
			END
		END
	END


	/***************************************************************************
	***
	*** Output Mapping Table Values
	***
	***************************************************************************/

	IF $(ScrambleAddresses) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScrambleAddressDetailsScript)"'
--		:r $(ScriptPath)$(ScrambleAddressDetailsScript)

		PRINT 'Make Address Details omlette';

		PRINT '----- Scramble: [dbo].wnInsureds:Address Fields -----';
		SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnInsureds]
		IF @MaxRecords > 0
		BEGIN
			Update X
			SET [X].AddressLine1 = AM.MappedAddressLine1
			,	[X].AddressLine2 = AM.MappedAddressLine2
			,	[X].City = AM.MappedCity
			,	[X].PostCode = AM.MappedPostCode
			FROM [dbo].[wnInsureds] X
			INNER JOIN #AddressMapping AM ON 
				'[' + RTRIM(LTRIM([X].AddressLine1)) + RTRIM(LTRIM([X].AddressLine2)) + RTRIM(LTRIM([X].City)) + RTRIM(LTRIM([X].PostCode)) + ']' =  [AM].CompositeAddressKey COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Other Details','[dbo].wnInsureds:Address Fields', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
		ELSE
		BEGIN
				PRINT '----- Skipped: Insured''s not used -----';
		END

		PRINT '----- Scramble: [dbo].BrokerLocations:Address Fields -----';
		SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBrokerLocations]
		IF @MaxRecords > 0
		BEGIN
			Update X
			SET [X].AddressLine1 = AM.MappedAddressLine1
			,	[X].AddressLine2 = AM.MappedAddressLine2
			,	[X].City = AM.MappedCity
			,	[X].PostCode = AM.MappedPostCode
			FROM [dbo].[wnBrokerLocations] X
			INNER JOIN #AddressMapping AM ON 
				'[' + RTRIM(LTRIM([X].AddressLine1)) + RTRIM(LTRIM([X].AddressLine2)) + RTRIM(LTRIM([X].City)) + RTRIM(LTRIM([X].PostCode)) + ']' =  [AM].CompositeAddressKey COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Other Details','[dbo].wnBrokerLocations:Address Fields', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
		ELSE
		BEGIN
				PRINT '----- Skipped: BrokerLocations''s not used -----';
		END

		PRINT '----- Scramble: [dbo].wnBranches:Address Fields -----';
		SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnBranches]
		IF @MaxRecords > 0
		BEGIN
			Update X
			SET [X].AddressLine1 = AM.MappedAddressLine1
			,	[X].AddressLine2 = AM.MappedAddressLine2
			,	[X].City = AM.MappedCity
			,	[X].PostCode = AM.MappedPostCode
			FROM [dbo].[wnBranches] X
			INNER JOIN #AddressMapping AM ON 
				'[' + RTRIM(LTRIM([X].AddressLine1)) + RTRIM(LTRIM([X].AddressLine2)) + RTRIM(LTRIM([X].City)) + RTRIM(LTRIM([X].PostCode)) + ']' =  [AM].CompositeAddressKey COLLATE SQL_Latin1_General_Cp1_CI_AS
			SELECT @RCount = @@ROWCOUNT

			INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
			VALUES ('Other Details','[dbo].wnBranches:Address Fields', @RCount, @MaxRecords)
			PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
		END
		ELSE
		BEGIN
				PRINT '----- Skipped: wnBranch''s not used -----';
		END
	END

	IF $(ScramblePasswords) = 'True'
	Begin
--		PRINT 'Executing scramble script: "$(ScriptPath)$(ScramblePasswordScript)"'
--		:r $(ScriptPath)$(ScramblePasswordScript)

		PRINT 'Make Password omlette';

		PRINT '----- Scramble: [dbo].wnUsers.Password -----';
		SELECT @MaxRecords = COUNT(1) FROM [dbo].[wnUsers] WC
		Update X
		SET [X].Password = $(ScrambledPasswordKeycode)
		FROM [dbo].wnUsers X
		SELECT @RCount = @@ROWCOUNT

		INSERT INTO @ScrambleStats (ScrambleCategory,	ScrambleKey,	RecordCount,	MaxRecords)
		VALUES ('Password','[dbo].wnUsers.Password', @RCount, @MaxRecords)
		PRINT '----- Processed: ' + CONVERT(VARCHAR,@RCount) + '/' + CONVERT(VARCHAR,@MaxRecords) + '(' + CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),@RCount)/CONVERT(DECIMAL(25,2),@MaxRecords))*100.00)) + '%) -----';
	END




	/***************************************************************************
	***
	*** Output Mapping Table Values
	***
	***************************************************************************/
	PRINT '----------------------------------------------- Mapping Tables -----------------------------------------------'
	PRINT 'Mapping EMail:'
-- :Out $(ScriptPath)MappingEmail.txt
	SELECT * FROM #EmailMapping EM
-- :Out STDOUT	
	PRINT 'Mapping Entity Names:'
-- :Out $(ScriptPath)MappingName.txt
	SELECT * FROM #NameMapping NM
-- :Out STDOUT	
	PRINT 'Mapping Entity Locations/Addresses:'
-- :Out $(ScriptPath)MappingAddress.txt
	SELECT * FROM #AddressMapping AM
-- :Out STDOUT	

	/***************************************************************************
	***
	*** Mapping Stats
	***
	***************************************************************************/
	PRINT '----------------------------------------------- Mapping Statistics -----------------------------------------------'
	PRINT 'Mapping Stats:'
-- :Out $(ScriptPath)MappingStatistics.txt
	SELECT *, CONVERT(VARCHAR,CONVERT(DECIMAL(5,2),(CONVERT(DECIMAL(25,2),RecordCount)/CONVERT(DECIMAL(25,2),MaxRecords))*100.00)) + '%' [ScrambleStats]
	FROM @ScrambleStats SS
	ORDER BY ScrambleCategory,	ScrambleKey
-- :Out STDOUT	

	COMMIT TRANSACTION ScrambleTran

END TRY

BEGIN CATCH

    PRINT 'AN UNEXPECTED ERROR OCCURRED!'

    SELECT ERROR_MESSAGE()   AS ErrorMessage,
           ERROR_NUMBER()    AS ErrorNumber,
           ERROR_SEVERITY()  AS ErrorSeverity,
           ERROR_STATE()     AS ErrorState,
           ERROR_PROCEDURE() AS ErrorProcedure,
           ERROR_LINE()      AS ErrorLine               

    ROLLBACK TRANSACTION ScrambleTran

END CATCH

/***************************************************************************
***
*** Cleanup
***
***************************************************************************/
PRINT '----------------------------------------------- Cleanup -----------------------------------------------'
PRINT 'Cleanup EMail:'
DROP TABLE #EmailMapping
PRINT 'Cleanup Entity Names:'
DROP TABLE #NameMapping
PRINT 'Cleanup Entity Locations/Addresses:'
DROP TABLE #AddressMapping
--PRINT 'Statistics:'
--DROP TABLE @ScrambleStats


