use LibertyV5
Print 'Before'
Select * from wnCommunicationRecipients

Update wnCommunicationRecipients
Set
EmailAddress = 'wip@wild.net'


Print 'After'
Select * from wnCommunicationRecipients

use tempdb