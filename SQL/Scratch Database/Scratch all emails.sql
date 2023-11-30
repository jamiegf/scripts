use LibertyV5

/*
Select * from syscolumns c
inner join sysobjects o on o.id=c.id
where c.name like '%email%'
*/

Select * from wnCommunications Where SenderEmailAddress <> 'wip@wild.net' 
Update wnCommunications SET SenderEmailAddress = 'wip@wild.net' Where SenderEmailAddress <> 'wip@wild.net' 
Select * from wnCommunications Where SenderEmailAddress <> 'wip@wild.net' 

Select * from wnInsureds Where EmailAddress <> 'wip@wild.net' 
Update wnInsureds SET EmailAddress = 'wip@wild.net' Where EmailAddress <> 'wip@wild.net' 
Select * from wnInsureds Where EmailAddress <> 'wip@wild.net' 

Select * from wnCommunicationRecipients Where EmailAddress <> 'wip@wild.net' 
Update wnCommunicationRecipients SET EmailAddress = 'wip@wild.net' Where EmailAddress <> 'wip@wild.net' 
Select * from wnCommunicationRecipients Where EmailAddress <> 'wip@wild.net' 

Select * from wnRisks Where InsuredPrimaryContactEmailAddress <> 'wip@wild.net' 
Update wnRisks SET InsuredPrimaryContactEmailAddress = 'wip@wild.net' Where InsuredPrimaryContactEmailAddress <> 'wip@wild.net' 
Select * from wnRisks Where InsuredPrimaryContactEmailAddress <> 'wip@wild.net' 

Select * from wnUsers Where Email <> 'wip@wild.net' 
Update wnUsers SET Email = 'wip@wild.net' Where Email <> 'wip@wild.net' 
Select * from wnUsers Where Email <> 'wip@wild.net' 

Select * from vwInsuredLastVersions Where EmailAddress <> 'wip@wild.net' 
Update vwInsuredLastVersions SET EmailAddress = 'wip@wild.net' Where EmailAddress <> 'wip@wild.net' 
Select * from vwInsuredLastVersions Where EmailAddress <> 'wip@wild.net' 

Select * from wnBrokerLocations Where BillingAddressEmail <> 'wip@wild.net' 
Update wnBrokerLocations SET BillingAddressEmail = 'wip@wild.net' Where BillingAddressEmail <> 'wip@wild.net' 
Select * from wnBrokerLocations Where BillingAddressEmail <> 'wip@wild.net' 
