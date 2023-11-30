$machines = get-content c:\winxp.txt
foreach($machine in $machines){gwmi win32_computersystem -computername $machine | fl name, model, username | out-file c:\winXPDetails.txt -append}