$outageLog = "c:\temp\no_connnections_log.txt"
$testhost = "www.google.com"
while($true){
     $a = test-connection $testhost -count 1
          sleep -MilliSeconds 1000
          if($a -eq $null) {write-output "no connection at $(get-date)" | out-file $outageLog -append}
           
}