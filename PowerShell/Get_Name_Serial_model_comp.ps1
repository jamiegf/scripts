Add-Pssnapin quest.activeroles.admanagement
$a = get-qadcomputer 
#$a
#$a = "gblonl00205"
#$a | % {
$a | % { $b = gwmi win32_systemenclosure -ComputerName $_.name
            $c = gwmi win32_computersystem -computername $_.name
            $_.name + "," + $_.description + "," + $b.serialnumber + "," +  $c.model + "`n" >> c:\serials5.txt} 


