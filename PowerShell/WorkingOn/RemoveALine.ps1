

Get-Content c:\groupmembership.txt | Where-Object {$_ -notmatch 'Name'} | Where-Object {$_ -notmatch '---'} |out-file c:\out2.txt
