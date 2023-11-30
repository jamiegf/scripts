use LibertyV5
Print 'Before'
Select * from wnBrokerCompanies

Update wnBrokerCompanies
Set
[Name] = 'Broker Company ' + Convert(varchar, ID)

Print 'After'
Select * from wnBrokerCompanies
