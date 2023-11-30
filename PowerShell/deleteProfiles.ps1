$computerslist = get-content c:\computers.txt
$profilenames = Get-Content c:\profilenames.txt
foreach ($comp in $computerslist) 
    {foreach ($prof in $profilenames)
        {Remove-Item \\$comp\c$\Users\$prof -force -recurse}
        }
        