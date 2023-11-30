 $comps = Get-Content "c:\scripts\computers.txt"
 foreach($comp in $comps)
 {
Get-WmiObject Win32_Service  |
Where-Object { $_.StartMode -eq 'Auto' -and $_.State -ne 'Running' } | 
# process them; in this example we just show them:
Format-Table -AutoSize @(
    'Name'
   'DisplayName'
    @{ Expression = 'State'; Width = 9 }
    @{ Expression = 'StartMode'; Width = 9 }
    'StartName'
out-file c:\temp\logggg.txt
)

}