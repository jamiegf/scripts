

$vmName = "vega"
$newname = "vega1"
$sourceFolder = "c:\VM\Vega"
$xmlpath = ls "$sourceFolder\virtual machines\*.xml"
$destImportFolder = "C:\VM\Imported"
 

import-vm -Path $xmlpath `
-copy -VhdDestinationPath $destImportFolder -VirtualMachinePath $destImportFolder -GenerateNewId

Start-VM $vmname


get-vm $vmname | rename-vm -newname $newname
get-vm $newname | Restart-VM -Force
sleep 30


$Msvm_VirtualSystemManagementService = Get-WmiObject -Namespace root\virtualization\v2 `
    -Class Msvm_VirtualSystemManagementService 

$Msvm_ComputerSystem = Get-WmiObject -Namespace root\virtualization\v2 `
    -Class Msvm_ComputerSystem -Filter "ElementName='$newName'" 

$Msvm_VirtualSystemSettingData = ($Msvm_ComputerSystem.GetRelated("Msvm_VirtualSystemSettingData", `
    "Msvm_SettingsDefineState", $null, $null, "SettingData", "ManagedElement", $false, $null) | % {$_})

$Msvm_SyntheticEthernetPortSettingData = $Msvm_VirtualSystemSettingData.GetRelated("Msvm_SyntheticEthernetPortSettingData")

$Msvm_GuestNetworkAdapterConfiguration = ($Msvm_SyntheticEthernetPortSettingData.GetRelated( `
    "Msvm_GuestNetworkAdapterConfiguration", "Msvm_SettingDataComponent", `
    $null, $null, "PartComponent", "GroupComponent", $false, $null) | % {$_})

$Msvm_GuestNetworkAdapterConfiguration.DHCPEnabled = $false
$Msvm_GuestNetworkAdapterConfiguration.IPAddresses = @("192.168.130.101")
$Msvm_GuestNetworkAdapterConfiguration.Subnets = @("255.255.255.0")
#$Msvm_GuestNetworkAdapterConfiguration.DefaultGateways = @("192.168.130.107")
#$Msvm_GuestNetworkAdapterConfiguration.DNSServers = @("192.168.1.0", "192.168.1.11")

$Msvm_VirtualSystemManagementService.SetGuestNetworkAdapterConfiguration( `
$Msvm_ComputerSystem.Path, $Msvm_GuestNetworkAdapterConfiguration.GetText(1))