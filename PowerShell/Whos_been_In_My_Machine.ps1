$yesterday = (Get-Date).adddays(-1)
#$a = Get-EventLog Security| where {$_.timegenerated -gt $yesterday} | where {$_.message -notlike "*jgarrowfisher*" -or $_.message -notlike "*NT AUTHORITY\LOCAL SERVICE*" } | fl  Entrytype, Message, Source, TimeGenerated > c:\orrrr.txt
#$a = Get-EventLog Security| where {$_.timegenerated -gt $yesterday} | where {$_.message -notlike "*jgarrowfisher*"}  | fl  Entrytype, Message, Source, TimeGenerated > c:\solo.txt

$a = Get-EventLog Security| where {$_.timegenerated -gt $yesterday} |?{$_.EntryType -eq "SuccessAudit"} | ? {$_.message -notlike "*jamiegf*"} |?{ $_.message -notlike "*NT AUTHORITY\LOCAL SERVICE*" } |?{ $_.message -notlike "*newey$*" } | fl  Entrytype, Message, Source, TimeGenerateord > c:\orrrr22.txt