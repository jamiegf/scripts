

$sam = Read-Host "Enter sam account name"
$homedir = New-Item \\btgukdat03\home\$sam -type directory
$acl = Get-Acl $homedir
if ($acl.AreAccessRulesProtected) { $acl.Access | % {$acl.purgeaccessrules($_.IdentityReference)} }
else {
$isProtected = $true 
$preserveInheritance = $false
$acl.SetAccessRuleProtection($isProtected, $preserveInheritance) 
}
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("bytesnet\$sam","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
$acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule("bytesnet\domain admins","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
Set-Acl -aclobject $ACL -Path $homedir

