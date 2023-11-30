Import-Csv -Path "C:\temp\stationInplay.csv" -Header Col1, Col2, Col3, Col4, Col5 |
	Where-Object {$_.Col3 -ne '0'} |
	ConvertTo-Csv -NoTypeInformation |
	Select-Object -Skip 1 |
	Set-Content -Path C:\Temp\output2.csv