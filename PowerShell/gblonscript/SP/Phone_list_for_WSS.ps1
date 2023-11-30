Add-PSSnapin quest.activeroles.admanagement
$phonefile = "\\gblonbm02\c$\Program Files\Common Files\Microsoft Shared\web server extensions\12\TEMPLATE\IMAGES\phone.txt"
$phonefileexcel = '\\gblonfile02\cifs_data$\Facilities\Brandon House Admin\Phone_List.csv'
$firsthtml = @"
 <table width=100% border=0> 
<tr>
    <td height=22 bgcolor=#fee8b7><strong>First Name</strong></td>
    <td bgcolor="#fee8b7"><strong>Surname</strong></td>
    <td bgcolor="#fee8b7"><strong>Office Phone</strong></td>
    <td bgcolor="#fee8b7"><strong>Mobile Phone</strong></td>
    <td bgcolor="#fee8b7"><strong>Job Title</strong></td>
    <td bgcolor="#fee8b7"><strong>Department</strong></td>
    <td bgcolor="#fee8b7"><strong>Email</strong></td>
    </tr>
      <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
"@

$firsthtml | Out-File $phonefile 

    $ou = "ou=EU Users,dc=eu,dc=above,dc=net"
	Get-QADUser -SearchRoot $ou | sort-object firstname |select-object firstname, lastname, homephone, mobile, title, department, email |export-csv $phonefileexcel
$a = $null
$c = 0
Get-QADUser -searchroot $ou |sort-object firstname | foreach-object {
                                                
                                $c = $c + 1
                                $d = $c % 2     # % = powershell version of  VBS MOD (it divides, then returns only the remainder)
                            if($d -eq 0) 
                                { $a =  $a + "<tr><td bgcolor=#fef7e6>" + $_.firstname + "</td><td bgcolor=#fef7e6>" + $_.lastname  + "</td><td bgcolor=#fef7e6>" + $_.phonenumber + "</td><td bgcolor=#fef7e6>" + $_.mobile + "</td><td bgcolor=#fef7e6>" + $_.title + "</td><td bgcolor=#fef7e6>" + $_.department + "</td><td bgcolor=#fef7e6><a href=mailto:" + $_.email + ">" + $_.email + "</a></td>" 
                                }
                            if($d -ne 0)
                                { $a =  $a + "<tr><td bgcolor=#e1ecfc>" + $_.firstname + "</td><td bgcolor=#e1ecfc>" + $_.lastname  + "</td><td bgcolor=#e1ecfc>" + $_.phonenumber + "</td><td bgcolor=#e1ecfc>" + $_.mobile + "</td><td bgcolor=#e1ecfc>" + $_.title + "</td><td bgcolor=#e1ecfc>" + $_.department + "</td><td bgcolor=#e1ecfc><a href=mailto:" + $_.email + ">" + $_.email + "</a></td>"
                                }
                                                                 }
                                                
                                                
                                                
                                               
$a | out-file $phonefile -append

"</table>" | out-file $phonefile -Append
  
    
    