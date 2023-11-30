
$yesterday = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') 
#yesterday = "06_27_2017
$logfolder = "C:\inetpub\wwwroot\DriftWood\Logs\DailyLogs\$yesterday"


cd $logfolder
$errormessage = $null
gci $logfolder -Filter *.csv |
ForEach-Object {
    $CSVLOG = $_.Name
    
        Import-Csv $CSVLOG | Foreach-Object { 

                foreach ($property in $_.PSObject.Properties)
                    {
                    $str = $property.value
                    if ($str.length -eq 0) {$errorMessage = $errormessage +  " `r `n  Error! $CSVLOG contains a BLANK cell"}
                    elseif ($str.length -lt 6) {$errormessage = $errormessage + "`r `n  Error! Please check $CSVLOG : Too few characters: $str"}
         
                    } 

            }

    }
  if (!$errormessage) {$errormessage =  "Results: No errors found in Log CSVs :)"}
    #write-host $errormessage

$emailBody = @"

$errorMessage

Map Links
---------
Atlantis			- https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=atlantis
Boyd                 - https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=boyd
Golden Nugget		- https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=goldennugget
Southpoint		    - https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=southpoint
Station 	                - https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=station
Treasure	     	- https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=treasure
Westgate		    - https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=westgate
Wynn 	                    - https://timber.miomni.com/maplogsgps.aspx?logdate=$yesterday&client=wynn



CSV Links
----------
Atlantis			- https://timber.miomni.com\Logs\MapLogs\$yesterday\atlantis_$yesterday.csv
Boyd Combined	     - https://timber.miomni.com\Logs\MapLogs\$yesterday\boyd_$yesterday.csv
Boyd Split 1		- https://timber.miomni.com\Logs\MapLogs\$yesterday\boyd_split1_$yesterday.csv
Southpoint		- https://timber.miomni.com\Logs\MapLogs\$yesterday\southpoint_$yesterday.csv
Station Combined	- https://timber.miomni.com\Logs\MapLogs\$yesterday\station_$yesterday.csv
Station Split 1		- https://timber.miomni.com\Logs\MapLogs\$yesterday\station_split1_$yesterday.csv
Station Split 2		- https://timber.miomni.com\Logs\MapLogs\$yesterday\station_split2_$yesterday.csv
Treasure		- https://timber.miomni.com\Logs\MapLogs\$yesterday\treasure_$yesterday.csv
Westgate		- https://timber.miomni.com\Logs\MapLogs\$yesterday\westgate_$yesterday.csv
Westgate Split 1	- https://timber.miomni.com\Logs\MapLogs\$yesterday\westgate_split1_$yesterday.csv
Wynn Combined	- https://timber.miomni.com\Logs\MapLogs\$yesterday\wynn_$yesterday.csv
Wynn Split 1		- https://timber.miomni.com\Logs\MapLogs\$yesterday\wynn_split1_$yesterday.csv



"@

$emailBody > "c:\scripts\Maplogs\daily_results.txt"


cd "C:\Program Files (x86)\Blat Mailer"
invoke-expression ".\blat.exe C:\Scripts\MapLogs\daily_results.txt -imaf  -to logs@miomni.com -subject 'LiveLogs'"
