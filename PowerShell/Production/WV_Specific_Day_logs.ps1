#When adding a new casino. check logs are going to \\mvm-bak\E$\Wager_logs 

#>
$yesterday = "12_27_2018" #((get-date).adddays(-1)).tostring('MM_dd_yyyy') 
$yesterdayUS = "2018-12-27" #((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$Node1 = "\\sports1"
$Node2 = "\\sports2"
$Node3 = "\\sports3"
$NodeR = "\\race1"
$NodeR2 = "\\race2"
$NodeI = "\\inPlay1"
$NodeI2 = "\\inPlay2"

$logfolder = "$Node1\C$\inetpub\wwwroot\Wager_logs_DN\Logs\MapLogsDaily\$yesterday"
$BackupLogsFolder = "\\bak\E$\Wager_logs"

$logFolderCSV = "download\csv\$yesterday.csv"
$LogsWebsite = "https://Wager_Logs_DN.miomni.com"
#$ZipTarget = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily_Zips\LogsCombined_$Yesterday.zip"

New-Item $logfolder -ItemType directory



###############################################

# Mardigras Sports
##############
#WebsiteWager Log Files
$MGSportsCSV = "$Node1\c$\inetpub\wwwroot\MardiGrasSports-Live2\$logfolderCSV"
$MGSportsCSV2 = "$Node2\c$\inetpub\wwwroot\MardiGrasSports-Live2\$logfolderCSV"
$MGSportsCSV3 = "$Node3\c$\inetpub\wwwroot\MardiGrasSports-Live2\$logfolderCSV"

#create outfile in logs website
$MGSportsOutfile = "$logfolder\MGSports_$yesterday.txt"
if (!(test-path $MGSportsOutfile)) {New-Item $MGSportsOutfile -ItemType file}
#create outfile on backup server
$MGSportsOutfileBak = "$BackupLogsFolder\MGSports\$yesterday.csv"
if (!(test-path $BackupLogsFolder\MGSports)) {New-Item $BackupLogsFolder\MGSports -ItemType directory }
if (!(test-path $MGSportsOutfileBak)) {New-Item $MGSportsOutfileBak -ItemType file}
#suckup all logs
$MGSportsCombined = Get-Content $MGSportsCSV
$MGSportsCombined = $MGSportsCombined + (Get-Content $MGSportsCSV2)
$MGSportsCombined = $MGSportsCombined + (Get-Content $MGSportsCSV3)
#copy concatanated logs to logs website and backup server
$MGSportsCombined | Out-File -Encoding utf8 $MGSportsOutfile
$MGSportsCombined | Out-File -Encoding utf8 $MGSportsOutfileBak
#count lines
$MGSportsCount = get-content "$logfolder\MGSports_$yesterday.txt"  | measure-object -line
$intMGSportsCount =  $MGSportsCount.lines



########################################################################


# WheelingIsland Sports
##############
#WebsiteWager Log Files
$WISportsCSV = "$Node1\c$\inetpub\wwwroot\WheelingIslandSports-Live2\$logfolderCSV"
$WISportsCSV2 = "$Node2\c$\inetpub\wwwroot\WheelingIslandSports-Live2\$logfolderCSV"
$WISportsCSV3 = "$Node3\c$\inetpub\wwwroot\WheelingIslandSports-Live2\$logfolderCSV"

#create outfile in logs website
$WISportsOutfile = "$logfolder\WISports_$yesterday.txt"
if (!(test-path $WISportsOutfile)) {New-Item $WISportsOutfile -ItemType file}
#create outfile on backup server
$WISportsOutfileBak = "$BackupLogsFolder\WISports\$yesterday.csv"
if (!(test-path $BackupLogsFolder\WISports)) {New-Item $BackupLogsFolder\WISports -ItemType directory }
if (!(test-path $WISportsOutfileBak)) {New-Item $WISportsOutfileBak -ItemType file}
#suckup all logs
$WISportsCombined = Get-Content $WISportsCSV
$WISportsCombined = $WISportsCombined + (Get-Content $WISportsCSV2)
$WISportsCombined = $WISportsCombined + (Get-Content $WISportsCSV3)
#copy concatanated logs to logs website and backup server
$WISportsCombined | Out-File -Encoding utf8 $WISportsOutfile
$WISportsCombined | Out-File -Encoding utf8 $WISportsOutfileBak
#count lines
$WISportsCount = get-content "$logfolder\WISports_$yesterday.txt"  | measure-object -line
$intWISportsCount =  $WISportsCount.lines




#Mardigrasinplay
#################

#Set Wager logs CSV
$MGinplayCSV = "$nodeI\c$\Gaming\Mardigrasinplay-live301\WagerLogs\$yesterdayUS.txt"
$MGinplayCSV2 = "$nodeI2\c$\Gaming\Mardigrasinplay-live301\WagerLogs\$yesterdayUS.txt"


#create outfile in logs website
$MGinplayOutfile = "$logfolder\MGinplay_$yesterday.txt"
if (!(test-path $MGinplayOutfile)) {New-Item $MGinplayOutfile -ItemType file}
#create outfile on backup server
$MGinplayOutfileBak = "$BackupLogsFolder\MGinplay\$yesterday.csv"
if (!(test-path $BackupLogsFolder\MGinplay)) {New-Item $BackupLogsFolder\MGinplay -ItemType directory }
if (!(test-path $MGinplayOutfileBak)) {New-Item $MGinplayOutfileBak -ItemType file}
#suckup all logs
$MGinplayCombined = Get-Content $MGinplayCSV
$MGinplayCombined = $MGinplayCombined + (Get-Content $MGinplayCSV2)
#copy concatanated logs to logs website and backup server
$MGinplayCombined | Out-File -Encoding utf8 $MGinplayOutfile
$MGinplayCombined | Out-File -Encoding utf8 $MGinplayOutfileBak
#count lines
$MGinplayCount = get-content "$logfolder\MGinplay_$yesterday.txt"  | measure-object -line
$intMGinplayCount =  $MGinplayCount.lines


#WheelingIslandinplay
#################

#Set Wager logs CSV
$WIinplayCSV = "$nodeI\c$\Gaming\WheelingIslandinplay-live301\WagerLogs\$yesterdayUS.txt"
$WIinplayCSV2 = "$nodeI2\c$\Gaming\WheelingIslandinplay-live301\WagerLogs\$yesterdayUS.txt"


#create outfile in logs website
$WIinplayOutfile = "$logfolder\WIinplay_$yesterday.txt"
if (!(test-path $WIinplayOutfile)) {New-Item $WIinplayOutfile -ItemType file}
#create outfile on backup server
$WIinplayOutfileBak = "$BackupLogsFolder\WIinplay\$yesterday.csv"
if (!(test-path $BackupLogsFolder\WIinplay)) {New-Item $BackupLogsFolder\WIinplay -ItemType directory }
if (!(test-path $WIinplayOutfileBak)) {New-Item $WIinplayOutfileBak -ItemType file}
#suckup all logs
$WIinplayCombined = Get-Content $WIinplayCSV
$WIinplayCombined = $WIinplayCombined + (Get-Content $WIinplayCSV2)
#copy concatanated logs to logs website and backup server
$WIinplayCombined | Out-File -Encoding utf8 $WIinplayOutfile
$WIinplayCombined | Out-File -Encoding utf8 $WIinplayOutfileBak
#count lines
$WIinplayCount = get-content "$logfolder\WIinplay_$yesterday.txt"  | measure-object -line
$intWIinplayCount =  $WIinplayCount.lines

############################

# Total Bets yesterday
$intTotalBets = $intWIinplayCount + $intMGinplayCount + $intWISportsCount + $intMGSportsCount

#############################################################################



##################################################################

#Compress Logs and put in zips folder
#set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

#sz a -tzip  $ZipTarget $logfolder
####################################################################
#check for any errors in the CSV files

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
MardiGras Sports                      $intMGSportsCount
Wheeling Island Sports            $intWISportsCount
MardiGras InPlay                         $intMGInplayCount
Wheeling Island InPlay               $intWIInplayCount

Total combined bets                 $intTotalBets

Map Links
-------------
MardiGras Sports                             - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=MGSports
Wheeling Island Sports 	                  - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=WISports
MardiGras InPlay                             - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=MGinPlay
Wheeling Island InPlay                     - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=WIinPlay 


TXT Links
------------


MardiGras Sports                            - $LogsWebsite/Logs/MapLogsDaily/$yesterday/MGSports_$yesterday.txt
Wheeling Island Sports 	    	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/WISports_$yesterday.txt
MardiGras InPlay                              - $LogsWebsite/Logs/MapLogsDaily/$yesterday/MGinPlay_$yesterday.txt
Wheeling Island InPlay 	  	- $LogsWebsite/Logs/MapLogsDaily/$yesterday/WIinPlay_$yesterday.txt


"@



                            $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                            $password = "777RedHound321"
                            $to = "sysadmin@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Prod Logs: West Viginia $yesterday"
                            
                           

 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from


