#Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

$a = "<style>BODY{}"
$a = $a + "TH{border-width: 1px;margin:0px;border-style: solid;border-color: black;font-family:arial;padding:5px;background-color:#E6F5F9}"
$a = $a + "TABLE{border:1px solid #dedede;color:black;padding:0px;margin:0px;border-collapse:collapse;}"
$a = $a + "TD{padding:5px;margin:0px;border:1px solid black;}"
$a = $a + "</style>"

#get-mailbox jgarrow-fisher | get-mailboxstatistics | select-object Displayname, {$_.TotalItemSize.value.toMB()}




$mailboxes = get-mailbox jgarrow-fisher | get-mailboxstatistics |Select-Object DisplayName, @{label="TotalItemSize(MB)";expression={$_.TotalItemSize.Value.ToMB()}},ItemCount


$cc = "<H2>Mailboxes</H2>"


$mailboxes | ConvertTo-Html -head $a -body $cc | Out-File c:\jgf_mailbox.htm
$mailboxes | out-file c:\jgf_mailbox.txt