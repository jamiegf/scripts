$servers = "mvm-inplay2" #"mvm-prd1", "mvm-prd2" , "mvm-prd3", "mvm-inplay1", "mvm-inplay2", "mvm-race1", "mvm-Race2"
    foreach ($server in $servers)
    {
    $hostname = $server #$env:computername
    $startDate = ((Get-Date).AddDays(-1)).Date 
    $endDate = get-date 

    write-host "Logons: "$hostname "`tStart: "$startDate "`tEnd: "$endDate 

    $log = Get-Eventlog -LogName Security -ComputerName $hostname -after $startDate -before $endDate 
 

        foreach ($i in $log){ 
    
            if (($i.EventID -eq 4624 ) -and ($i.ReplacementStrings[8] -eq 10)){ 
               write-host "Type: Remote Logon`tDate: "$i.TimeGenerated "`tStatus: Success`tUser: "$i.ReplacementStrings[5] "`tIP Address: "$i.ReplacementStrings[18] 
            } 
         
      
        } 
    }