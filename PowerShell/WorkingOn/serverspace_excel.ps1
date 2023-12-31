


Add-PSSnapin quest.activeroles.admanagement

Get-QADComputer -osname *server* | Where-Object {$_.name -notlike '*BDS*'} | %{$_.name} | Sort-Object | out-file c:\servers.txt


$erroractionpreference = "SilentlyContinue"
$a = New-Object -comobject Excel.Application
$a.visible = $True 

$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)

$c.Cells.Item(1,1) = "Machine Name"
$c.Cells.Item(1,2) = "Drive"
$c.Cells.Item(1,3) = "Total size (MB)"
$c.Cells.Item(1,4) = "Free Space (MB)"
$c.Cells.Item(1,5) = "Free Space (%)"
$c.Cells.Item(1,6) = "OS Version / Name"

$d = $c.UsedRange
$d.Interior.ColorIndex = 19
$d.Font.ColorIndex = 11
$d.Font.Bold = $True
$d.EntireColumn.AutoFit($True)

$intRow = 2
$colComputers = get-content C:\servers.txt
foreach ($strComputer in $colComputers)
{
$colDisks = get-wmiobject Win32_LogicalDisk -computername $strComputer -Filter "DriveType = 3" 
foreach ($objdisk in $colDisks)
{

$OS = Get-WmiObject -Class win32_OperatingSystem -namespace "root\CIMV2" -ComputerName $strComputer

if ($OS.name -like '*2003*') {$OSV = "2003"} 
if ($OS.name -like '*2008*') {$OSV = "2008"}

$c.Cells.Item($intRow, 1) = $strComputer.ToUpper()
$c.Cells.Item($intRow, 2) = $objDisk.DeviceID
$c.Cells.Item($intRow, 3) = "{0:N0}" -f ($objDisk.Size/1MB)
$c.Cells.Item($intRow, 4) = "{0:N0}" -f ($objDisk.FreeSpace/1MB)
$c.Cells.Item($intRow, 5) = "{0:P0}" -f ([double]$objDisk.FreeSpace/[double]$objDisk.Size)
$c.Cells.Item($intRow, 6) = $OSV
$intRow = $intRow + 1
}
}
