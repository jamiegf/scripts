import-module webadministration
$URLs = 
"www.bbc.co.uk",
"http://24.120.115.216:84/PLEEAppService.dll",
"http://www.google.com",
"http://www.yahoo.com",
"http://www.madeup7hjydhsn.com"

foreach ($URL in $URLs)
        { 
         $call = "clear"
            $call = invoke-webrequest $URL -DisableKeepAlive -UseBasicParsing  # -Method head

             if ($call.statuscode -eq "200")
                {write-host "$URL = up"
                }
                    else {write-host "$URL = down"
   
                            $subject = "Alert: Site Down! "
                            $emailbody = "Site down = $URL"
                            $SMTPserver = "mail.miomni.com"
                            $from = "nv-servers@miomni.com"
                            $to = "jamiegarrowfisher@gmail.com"

                            Send-MailMessage -To $to -from $from -smtpServer $SMTPServer -subject $subject -body $emailbody
                
                }

                
        }