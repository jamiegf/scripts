$strComputer = "."

$colItems = get-wmiobject -class "Win32_NetworkAdapterConfiguration" -namespace "root\CIMV2" `
-computername $strComputer -filter "IPEnabled = true"

foreach ($objItem in $colItems) {
      write-host "MACAddress: " $objItem.MACAddress
      write-host "IPAddress: " $objItem.IPAddress
      write-host
}