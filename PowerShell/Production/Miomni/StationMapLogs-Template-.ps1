<#
Sends Station Map logs 2 days later to WEB2 for Station to see their logs

#>
$yesterday = ((get-date).adddays(-2)).tostring('MM_dd_yyyy') 
$yesterdayUS = ((get-date).adddays(-2)).tostring('yyyy-MM-dd') 
net use w: \\prd-web\logs /user:logs Orange21! /persistent:yes
net use s: \\prd-web\stationlogs /user:logs Orange21! /persistent:yes

$logfolder = "w:\MapLogsDaily\$yesterday"
$logfolderDest = "s:\MapLogsDaily\$yesterday"


$LogsWebsite = "https://Station-Map-Logs.miomni.com"


New-Item $logfolderDest -ItemType directory

 

###############################################





#StationRace
##############


#copy-item $logfolderSource\stationRace_$yesterday.txt $logfolderDest\stationRace_$yesterday.txt


#count lines
#$stationRaceCount = get-content "$logfolderDest\stationRace_$yesterday.txt"  | measure-object -line
#$intStationRaceCount =  $stationRaceCount.lines




#StationInPLay
#################
copy-item $logfolder\stationInPlay_$yesterday.txt $logfolderDest\stationInPlay_$yesterday.txt

#count lines
$stationInPlayCount = get-content "$logfolderDest\stationInPlay_$yesterday.txt"  | measure-object -line
$intStationInPlayCount =  $stationInPlayCount.lines


# Station
##############
#copy-item $logfolder\station_$yesterday.txt $logfolderDest\station_$yesterday.txt


#count lines
#$stationCount = get-content "$logfolderDest\station_$yesterday.txt"  | measure-object -line
#$intStationCount =  $stationCount.lines




#Email Body for Daily
$emailBody = @"

Station Log Count (Migrated)
-------------
Pre Game    $intStationCount
InPlay          $intStationInPlayCount
Race            $intStationRaceCount


Map Links
-------------
Pre Game              
InPlay                    - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationInPLay
Race		          
  

TXT Links
------------
Pregame               
InPlay	                  - $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationInPlay_$yesterday.txt
Race	                  



"@



                            $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                            $password = "777RedHound321"
                           #$to = @("logs@miomni.com", "Thomas.Mikulich@redrockresorts.com", "Jason.Simbal@StationCasinos.com", "Jason.McCormick@StationCasinos.com", "Pat.gordon@stationcasinos.com","lou.ragg@stationcasinos.com")
                            $to = "jamie@miomni.com"
                           # $to = "logs@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Station Map Logs"
                            
                           

 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from

