--:setvar BackupDatabasesLocation d:\Install\Opus\DatabaseBackups\
--:setvar SourceServer WN-TORUS
go
use tempdb
go

DECLARE @Sql varchar(4000)
DECLARE @CRLF CHAR(2)
--Declare @BackupDateString varchar(14)
--Declare @BackupDate datetime
Declare @dbname varchar(128)
Declare @Path varchar(2048)
Declare @BackupFile varchar(2048)
Declare @BackupFileName varchar(2048)
Declare @Description varchar(2048)
Declare @DataPath varchar(2048)
Declare @IdxPath varchar(2048)
Declare @DataSegmentName varchar(2048)
Declare @DataSegmentFile varchar(2048)
Declare @LogSegmentName varchar(2048)
Declare @LogSegmentFile varchar(2048)
Declare @SourceServer varchar(128)
Declare @IdxFile varchar(2048)
Declare @IdxSegment varchar(2048)
DECLARE @SQLIndexSegment bit
DECLARE @SegmentName varchar(2048)

Select @Path = "$(BackupDatabasesLocation)"
Select @SourceServer = "$(SourceServer)"
--Select @BackupDateString = "$(BackupDateString)" 
Select @DataPath = N'D:\MSSQL\Data\'
Select @IdxPath =  N'D:\MSSQL\FTData\'

declare @RC int, @Skip bit

SET	@CRLF = CHAR(13)+CHAR(10)

Create table #t (
      DBName   sysname,
      SegmentName   sysname,
      Restored bit,
	  SQLIndexSegment bit
)

INSERT INTO #t (DBName,SegmentName,Restored,SQLIndexSegment)
SELECT
      'Categories','Categories',0,0
UNION
SELECT
      'Dependencies','Dependencies',0,0
UNION
SELECT
      'EnvironmentSettings','EnvironmentSettings',0,0
UNION
SELECT
      'EventBus','EventBus',0,0
UNION
SELECT
      'EventBusScheduler','EventBusScheduler',0,0
UNION
SELECT
      'HostServer','HostServer',0,0
UNION
SELECT
      'K2Server','K2Server',0,0
UNION
SELECT
      'K2ServerLog','K2ServerLog',0,0
UNION
SELECT
      'K2SQLUM','K2SQLUM',0,0
UNION
SELECT
      'Opus2','Opus',0,0
UNION
SELECT
      'SmartBox','SmartBox',0,0
UNION
SELECT
      'SmartBroker','SmartBroker',0,0
UNION
SELECT
      'SmartFunctions','SmartFunctions',0,0
UNION
SELECT
      'WebWorkflow','WebWorkflow',0,0
UNION
SELECT
      'Workspace','Workspace',0,0

DECLARE AllDatabases CURSOR FOR
SELECT DBName AS Name, SegmentName, SQLIndexSegment
FROM #t
--WHERE DBName NOT IN (SELECT name AS Name
--                              FROM MASTER.DBO.SYSDATABASES
--                            WHERE [NAME] NOT IN('model', 'tempdb', 'master', 'msdb','MessageInterface_Test', 'RoutingConfig_Test')
--                        )
Order by [DBName]

OPEN AllDatabases

FETCH NEXT FROM AllDatabases INTO @DBName, @SegmentName, @SQLIndexSegment

WHILE @@FETCH_STATUS = 0
BEGIN
      SET @RC = 0

      Select @BackupFileName = @SourceServer + '_' + @DBName + '.bak'
      Select @BackupFile = @Path + @BackupFileName
      Select @Description = @SourceServer + ' ' + @DBName -- + ' Backup ' + convert(varchar,@BackupDate)

		IF EXISTS (Select 1 From sys.sysdatabases where name = @DBName)
		BEGIN
			Print 'Clearing database backup history ' + @DBName + ' using :[' + @BackupFile + ']'

			EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = @DBName

			Print 'Kill connections ' + @DBName

			EXEC ('ALTER DATABASE ' + @DBName + ' SET  SINGLE_USER WITH ROLLBACK IMMEDIATE');
			EXEC ('ALTER DATABASE ' + @DBName + ' SET  SINGLE_USER');

			EXEC ('DROP DATABASE ' + @DBName);
		END
		
		USE tempdb

      BEGIN try

            --Exec sp_addumpdevice 'disk', @BackupFileName, @BackupFile
            --Select * from sysfiles
            SET @DataSegmentName = @SegmentName
            SET @DataSegmentFile = @DataPath + @DBName + '.mdf'
            --SELECT @DataSegmentName = name from sysfiles Where filename = @DataSegmentFile

            SET @LogSegmentName = @SegmentName + '_Log' 
            SET @LogSegmentFile = @DataPath + @DBName + '.LDF'
            --SELECT @LogSegmentName = name from sysfiles Where filename = @LogSegmentFile

			SET @IdxSegment = N'sysft_ix_' + @SegmentName
			SET @IdxFile = @IdxPath + N'ix_' + @DBName

			IF @SQLIndexSegment = 0
			BEGIN
				Select @Sql = 'RESTORE DATABASE ' + @DBName + @CRLF
				Select @Sql = @Sql + 'FROM DISK = ''' + @BackupFile + '''' + @CRLF
				Select @Sql = @Sql + 'WITH FILE = 1, UNLOAD, REPLACE, RECOVERY, STATS = 25, ' + @CRLF
				Select @Sql = @Sql + 'MOVE ''' + @DataSegmentName + ''' TO ''' + @DataSegmentFile + ''', ' + @CRLF
				Select @Sql = @Sql + 'MOVE ''' + @LogSegmentName + ''' TO ''' + @LogSegmentFile + '''' + @CRLF
			END						
			ELSE
			BEGIN
				Select @Sql = 'RESTORE DATABASE ' + @DBName + @CRLF
				Select @Sql = @Sql + 'FROM DISK = ''' + @BackupFile + '''' + @CRLF
				Select @Sql = @Sql + 'WITH FILE = 1, UNLOAD, REPLACE, RECOVERY, STATS = 25, ' + @CRLF
				Select @Sql = @Sql + 'MOVE ''' + @DataSegmentName + ''' TO ''' + @DataSegmentFile + ''', ' + @CRLF
				Select @Sql = @Sql + 'MOVE ''' + @LogSegmentName + ''' TO ''' + @LogSegmentFile+ ''', ' + @CRLF
				Select @Sql = @Sql + 'MOVE ''' + @IdxSegment + ''' TO ''' + @IdxFile + '''' + @CRLF
			END
		    Print 'Restoring ' + @DBName + ' backup' --from ' + Convert(varchar,@BackupDate,113)
			EXEC (@Sql);
--            Exec sp_dropdevice @BackupFileName

			--Select @Sql = 'USE [' + @DBName + ']'+ @CRLF
			--Select @Sql = @Sql + 'GO' + @CRLF
			--Select @Sql = @Sql + 'EXEC sp_addrolemember N''db_owner'', N''WN\spadmin-torus''' + @CRLF
			--Select @Sql = @Sql + 'GO' + @CRLF
			--EXEC (@Sql);

      END TRY
      BEGIN catch
			--Print @Sql
            SET @RC = 1
      END CATCH
  
      IF @RC = 0
      BEGIN
            BEGIN try
                  Update #t Set Restored = 1 Where DBName = @DBName
            END TRY
            BEGIN catch
                  SET @RC = 1
            END CATCH
      END

FETCH NEXT FROM AllDatabases INTO @DBName,@SegmentName,@SQLIndexSegment
END

CLOSE AllDatabases
DEALLOCATE AllDatabases

Select * FROM #t

DROP TABLE #t
