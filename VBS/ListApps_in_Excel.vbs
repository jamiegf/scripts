  
'Request Machine name
'Open Excel
'list Installed Software
'Auto fit columns

Set objExcel = CreateObject("Excel.Application")
objExcel.Visible = True
Set objWorkbook = objExcel.Workbooks.Add()
Set objWorksheet = objWorkbook.Worksheets(1)
x = 2
strComputer = inputbox("Enter machine name")
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colSoftware = objWMIService.ExecQuery _
    ("Select * from Win32_Product")

objWorksheet.Cells(1,2) = "Please Wait - retrieving data..."
For Each objSoftware in colSoftware
    objWorksheet.Cells(x, 1) = objSoftware.name
    objWorksheet.Cells(x, 2) = objSoftware.vendor
    objWorksheet.Cells(x, 3) = objSoftware.PackageCache
 objWorksheet.Cells(x, 4) = objSoftware.Version
    x = x + 1
Next
objWorksheet.Cells(1,1) = "Software List : " & strComputer
objWorksheet.Cells(1,2) = "Vendor"
objWorksheet.Cells(1,3) = "Package"
objWorksheet.Cells(1,4) = "Version"

Set objRange = objWorksheet.UsedRange
objRange.EntireColumn.Autofit()
 

 
