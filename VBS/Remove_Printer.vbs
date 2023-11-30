dim WSHNetwork
Set WSHNetwork = CreateObject("WScript.Network")


'Remove a specific printerWSHNetwork.
WSHNetwork.RemovePrinterConnection "\\UKBSSDC01\Headway_Mid_Xerox",True,True            
'Install A PrinterWSHNetwork.
'WSHNetwork.AddWindowsPrinterConnection"\\UKBSSDC01\Headway_Mid_Xerox",True,True      