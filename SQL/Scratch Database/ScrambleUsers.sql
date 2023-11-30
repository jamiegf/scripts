use LibertyV5
Print 'Before'
Select * from wnUsers

Update wnUsers 
Set
--UserName = CASE WHEN UserName <> 'admin1' THEN 'User '  + Convert(varchar, GeneratedID) ELSE UserName END,
--FirstName = 'First ' + Convert(varchar, GeneratedID),
--LastName = 'Last ' + Convert(varchar, GeneratedID),
Email = 'wip@wild.net',
AdditionalEmail = CASE WHEN isnull(AdditionalEmail,'') <> '' THEN 'wip@wild.net' ELSE AdditionalEmail END,
[Password] = 0x6BB982345D7DF105D453CD3393FA4DCE

--Update wnUsers set IsValid = 1 where username = 'admin1' and id = 8

Print 'After'
Select * from wnUsers

use tempdb