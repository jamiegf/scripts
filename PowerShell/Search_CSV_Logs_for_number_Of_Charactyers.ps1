



    $CSVLOG = "C:\Users\jamie.garrow-fisher\Downloads\southpoint_06_26_2017.csv"
    Import-Csv $CSVLOG | Foreach-Object { 

        foreach ($property in $_.PSObject.Properties)
            {
            $str = $property.value
            if ($str.length -eq 0) {write-host "Error! - Contains a BLANK cell, Please check $"}
            elseif ($str.length -lt 7) {write-host "Error! Please check $CSVLOG :
           Too few characters: $str"}
         
            } 

    }