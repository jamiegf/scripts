<#
When adding a new casino. check logs are going to \\mvm-bak\E$\Wager_logs 

#>
$yesterday = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') 
$yesterdayUS = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
net use w: \\prd-web\logs /user:logs Orange21! /persistent:yes


$logfolder = "w:\MapLogsDaily\$yesterday"
#$InplayLogFolder = "C:\inetpub\wwwroot\DriftWood\Logs\MapInplayLogsDaily\$yesterday"
$BackupLogsFolder = "\\mvm-bak\E$\Wager_logs"

$logFolderCSV = "download\csv\$yesterday.csv"
$logFolderLOG = "gaming\StationSports\CSV\$yesterdayUS.miomni.csv.log"
$logFolderWynn = "gaming\WynnSports\CSV\$yesterdayUS.miomni.csv.log"

$LogsWebsite = "https://Logs_Casino_bets_314159265358979323846.miomni.com"
$ZipTarget = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily_Zips\LogsCombined_$Yesterday.zip"

New-Item $logfolder -ItemType directory

#New-Item $InplayLogFolder -ItemType directory

#debug
$ProgLog = "c:\temp\dailylogs1.txt"
remove-item $progLog -force
New-Item $ProgLog -ItemType File
$timeStamp = get-date
write-host $timeStamp

###############################################

# Wynn
##############
#write-host "starting Wynn"
#$timeStamp = get-date
#"$timeStamp wynn start" >> $ProgLog #debug
#WebsiteWager Log Files
$WynnCSV = "$Node1\c$\$logFolderWynn"

#create outfile in logs website
$WynnOutfile = "$logfolder\Wynn_$yesterday.txt"
if (!(test-path $WynnOutfile)) {New-Item $WynnOutfile -ItemType file}
#create outfile on backup server
$WynnOutfileBak = "$BackupLogsFolder\Wynn\$yesterday.csv"
if (!(test-path $BackupLogsFolder\Wynn)) {New-Item $BackupLogsFolder\Wynn -ItemType directory }
if (!(test-path $WynnOutfileBak)) {New-Item $WynnOutfileBak -ItemType file}
#suckup all logs
$WynnCombined = Get-Content $WynnCSV
$WynnCombined = $WynnCombined + (Get-Content $WynnCSV2)
$WynnCombined = $WynnCombined + (Get-Content $WynnCSV3)
#copy concatanated logs to logs website and backup server
$WynnCombined | Out-File -Encoding utf8 $WynnOutfile
$WynnCombined | Out-File -Encoding utf8 $WynnOutfileBak
#count lines
$WynnCount = get-content "$logfolder\Wynn_$yesterday.txt"  | measure-object -line
$intWynnCount =  $WynnCount.lines
$timeStamp = get-date
"$timeStamp wynn end" >> $ProgLog #debug


##################################################################
sleep 5
#Compress Logs and put in zips folder
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

sz a -tzip  $ZipTarget $logfolder
####################################################################
#check for any errors in the CSV files
sleep 5
cd $logfolder

$errormessage = $null
gci $logfolder -Filter *.txt |
ForEach-Object {
    $CSVLOG = $_.Name
    
        Import-Csv $CSVLOG | Foreach-Object { 
                #check for blank cells or too few characters
                foreach ($property in $_.PSObject.Properties)
                    {
                    $count = $count + 1
                    $str = $property.value
                    if ($str.length -eq 0) {$errorMessage = $errormessage +  " `r `n  Error! $CSVLOG contains a BLANK cell"}
                    elseif ($str.length -lt 3) {$errormessage = $errormessage + "`r `n  Error! Please check $CSVLOG : Too few characters: $str"}
         
                    } 

            }
    
    }
  if (!$errormessage) {$errormessage =  "Results: No errors found in Log Files :)"}


#Email Body for Daily
$emailBody = @"

$errorMessage

Log Count
-------------

Wynn                      $intWynnCount


Map Links
-------------

Wynn                                - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=wynn          

TXT Links
------------

Wynn     	     	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/wynn_$yesterday.txt


"@



                           $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                           #$from = "alert@miomni.com"
                            $password = "777RedHound321"
                         $to = @("logs@miomni.com", "dgtemba@yahoo.co.uk")
                        #  $to = @("dave.garrity@miomni.com", "jamie.garrow-fisher@miomni.com")
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Live Logs"
                            
                           
"$timeStamp sending email1" >> $ProgLog #debug
 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from
 "$timeStamp sent email1, sending email2" >> $ProgLog #debug
 Send-MailMessage -To $to2 -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from
  "$timeStamp sent email2" >> $ProgLog #debug  

