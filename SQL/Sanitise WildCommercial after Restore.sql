--Sanitise SQL - to prevent test systems from accidentally emailing customers
--It should be run against a Wild Commercial database after a restore from a production backup
--Note that this script does not scramble or otherwise anonymise any personal data

--unlock admin1
UPDATE wnUsers SET isValid=1,LoginTry=0 WHERE username='admin1'

--Email Addresses - set to wip@wild.net where populated
UPDATE wnUsers 
SET Email = CASE WHEN ISNULL(Email, '') = '' THEN '' ELSE 'wip@wild.net' END,
AdditionalEmail = CASE WHEN isnull(AdditionalEmail,'') = '' THEN '' ELSE 'wip@wild.net' END,
[Password] = 0x6BB982345D7DF105D453CD3393FA4DCE


UPDATE wnInsureds 
SET EmailAddress =	 'wip@wild.net' WHERE ISNULL(EmailAddress, '') <> ''

UPDATE wnCommunicationRecipients
SET EmailAddress =	 'wip@wild.net' WHERE ISNULL(EmailAddress, '') <> ''

UPDATE wnCommunicationTemplateUsers
SET EmailAddress =	 'wip@wild.net' WHERE ISNULL(EmailAddress, '') <> ''

UPDATE wnCommunications
SET SenderEmailAddress = 'wip@wild.net' WHERE ISNULL(SenderEmailAddress, '') <> ''

UPDATE wnRisks
SET InsuredPrimaryContactEmailAddress =	 'wip@wild.net' WHERE ISNULL(InsuredPrimaryContactEmailAddress, '') <> ''

UPDATE dbo.wnCommunicationTemplates
SET OtherEmail =	 'wip@wild.net' WHERE ISNULL(OtherEmail, '') <> ''
GO

--
--The following two update statements will fail for Beazley as the tables don't exist under WildCommercial 5.3
--
UPDATE wnBusinessEntities
SET EmailAddress =	 'wip@wild.net' WHERE ISNULL(EmailAddress, '') <> ''

UPDATE wnBrokerLocations
SET AccountsContactEmail =	 'wip@wild.net' WHERE ISNULL(AccountsContactEmail, '') <> ''

GO