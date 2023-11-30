#Run this to create a V Switch and set the virtual NIC - run as admin or Hyper V admin
Import-Module Hyper-V
New-VMSwitch -Name "Virtual Machine Switch (VLAN ID:1)" -SwitchType Internal 
$nic = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'" | where {$_.Description -like "*Hyper-V*"}
$nic.enablestatic("192.168.130.199", "255.255.255.0")