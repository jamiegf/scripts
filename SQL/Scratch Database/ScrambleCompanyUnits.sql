use LibertyV5
Print 'Before'
Select * from doCompanyUnits

Update doCompanyUnits
Set
[CompanyName] = 'Company Unit ' + Convert(varchar, ID)

Print 'After'
Select * from doCompanyUnits
