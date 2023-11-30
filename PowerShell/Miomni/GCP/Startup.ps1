$IDFile  =  "c:\miomni\serverID.txt"
    if (-not(test-path $IDFile))
        {new-item $IDFile
        get-date -format "MMM-dd__HH-mm" | out-file $IDFile 
        }