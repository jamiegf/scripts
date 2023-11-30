
$vmName = (Get-ItemProperty –path "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").VirtualMachineName

if ($env:computername -ne $vmName) {
        $nic = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
        $nic.enablestatic("192.168.130.101", "255.255.255.0")
        (gwmi win32_computersystem).Rename($vmName); shutdown -r -t 0}

