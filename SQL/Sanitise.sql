
Update wnUsers 
Set
Email = 'wip@wild.net',
AdditionalEmail = CASE WHEN isnull(AdditionalEmail,'') <> '' THEN 'wip@wild.net' ELSE AdditionalEmail END,
[Password] = 0x6BB982345D7DF105D453CD3393FA4DCE

Update wnInsureds 
Set
EmailAddress = 'wip@wild.net'

Update wnCommunicationRecipients
Set
EmailAddress = 'wip@wild.net'

update wnusers set isValid=1,LoginTry=0 where username='admin1'
