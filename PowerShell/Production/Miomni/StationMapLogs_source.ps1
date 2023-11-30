<#
Sends Station Map logs 2 days later to WEB2 for Station to see their logs

#>
$yesterday = ((get-date).adddays(-2)).tostring('MM_dd_yyyy') 
$yesterdayUS = ((get-date).adddays(-2)).tostring('yyyy-MM-dd') 
$Node1 = "\\mvm-prd1"
$Node2 = "\\mvm-prd2"
$Node3 = "\\mvm-prd3"
$NodeR = "\\mvm-race1"
$NodeR2 = "\\mvm-race2"
$NodeR3 = "\\mvm-race3"
$NodeR4 = "\\mvm-race4"
$NodeI = "\\mvm-inPlay1"
$NodeI2 = "\\mvm-inPlay2"
$NodeI3 = "\\mvm-inPlay3"
$NodeI4 = "\\mvm-inPlay4"
$nodeI5 = "\\mvm-inPlay5"


$logfolderSource = "$Node1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily\$yesterday"
$logfolderDest = "\\mvm-web2\C$\inetpub\wwwroot\StationMapLogs\Logs\MapLogsDaily\$yesterday"

#\\mvm-prd1\C$\inetpub\wwwroot\Logs_Casino_bets_314159265358979323846\Logs\MapLogsDaily


$LogsWebsite = "https://Station-Map-Logs.miomni.com"


New-Item $logfolderDest -ItemType directory

#New-Item $InplayLogFolder -ItemType directory



 

###############################################





#StationRace
##############


copy-item $logfolderSource\stationRace_$yesterday.txt $logfolderDest\stationRace_$yesterday.txt


#count lines
$stationRaceCount = get-content "$logfolderDest\stationRace_$yesterday.txt"  | measure-object -line
$intStationRaceCount =  $stationRaceCount.lines




#StationInPLay
#################
copy-item $logfolderSource\stationInPlay_$yesterday.txt $logfolderDest\stationInPlay_$yesterday.txt

#count lines
$stationInPlayCount = get-content "$logfolderDest\stationInPlay_$yesterday.txt"  | measure-object -line
$intStationInPlayCount =  $stationInPlayCount.lines


# Station
##############
copy-item $logfolderSource\station_$yesterday.txt $logfolderDest\station_$yesterday.txt


#count lines
$stationCount = get-content "$logfolderDest\station_$yesterday.txt"  | measure-object -line
$intStationCount =  $stationCount.lines




#Email Body for Daily
$emailBody = @"

Station Log Count
-------------
Pre Game    $intStationCount
InPlay          $intStationInPlayCount
Race            $intStationRaceCount


Map Links
-------------
Pre Game              - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=station
InPlay                    - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationInPLay
Race		          - $LogsWebsite/maplogsgps.aspx?logdate=$yesterday&client=stationRace
  

TXT Links
------------
Pregame                - $LogsWebsite/Logs/MapLogsDaily/$yesterday/station_$yesterday.txt
InPlay	                  - $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationInPlay_$yesterday.txt
Race	                  - $LogsWebsite/Logs/MapLogsDaily/$yesterday/stationRace_$yesterday.txt



"@



                            $emailAddress = "alert@miomni.com"
                            $from = "Notifications@miomni.com"
                            $password = "777RedHound321"
                           $to = @("logs@miomni.com", "Thomas.Mikulich@redrockresorts.com", "Jason.Simbal@StationCasinos.com", "Jason.McCormick@StationCasinos.com", "Pat.gordon@stationcasinos.com","lou.ragg@stationcasinos.com")
                           # $to = "jamie@miomni.com"
                           # $to = "logs@miomni.com"
                            $smtpServer = "smtp.office365.com"
                            $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
                            $mycreds = New-Object System.Management.Automation.PSCredential ($emailAddress, $secpasswd)
                            $port = "587"


                            $subject = "Station Map Logs"
                            
                           

 Send-MailMessage -To $to -SmtpServer $smtpServer -Credential $mycreds -UseSsl $subject -Port $port -Body $emailBody -From $from

