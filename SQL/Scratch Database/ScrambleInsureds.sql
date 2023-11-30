use LibertyV5
Print 'Before'
Select * from wnInsureds

Update wnInsureds 
Set
--FirstName = 'First ' + Convert(varchar, ID),
--LastName = 'Last ' + Convert(varchar, ID),
EmailAddress = 'wip@wild.net'

Print 'After'
Select * from wnInsureds

use tempdb