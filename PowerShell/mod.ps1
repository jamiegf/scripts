#Add-PSSnapin quest.activeroles.admanagement
$c = 0
$a = $null
$ou = "ou=EU Users,dc=eu,dc=above,dc=net"

 
Get-QADUser -searchroot $ou | ForEach-Object { 
                                $c = $c + 1
                                $d = $c % 2
                            if($d -eq 0) 
                                {$a= $a + $_.mobile
                                }
                            if($d -ne 0)
                                {$a= $a + $_.firstname 
                                }
                            }
                                
                            
                               
                                
$a | Out-File c:\testmod.txt
