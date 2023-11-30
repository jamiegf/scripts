Dim fso
Dim tst
Dim strMachineName

Set fso = createObject("Scripting.FileSystemObject")
Set tst = fso.OpenTextFile("c:\listOfMachineNames.txt", 1, false)

While Not tst.AtEndOfStream
	strMachineName = tst.readLine
	
	echoMAC strMachineName
Wend

Sub echoMAC(strComputer)

	On error resume next
	 strComputer = (InputBox(" Computer name for MAC address", "Computer Name"))
	If strComputer <> "" Then
		strInput = True
	End if

	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
	Set colItems = objWMIService.ExecQuery _
		("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")

	For Each objItem in colItems
		Wscript.Echo objItem.MACAddress
	Next
End Sub