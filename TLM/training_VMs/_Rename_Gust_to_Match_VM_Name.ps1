
$vmName = (Get-ItemProperty –path "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").VirtualMachineName

if ($env:computername -ne $vmName) {(gwmi win32_computersystem).Rename($vmName); shutdown -r -t 0}

