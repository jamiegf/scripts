$target = "10.10.10.229"

while($true){
     test-connection $target -count 1 |
     select @{N='Time';E={[dateTime]::Now}},
          @{N='Destination';E={$_.address}},
          replysize,
          @{N='Time(ms)'; E={$_.ResponseTime}}
          sleep -MilliSeconds 1000
}

$target = "8.8.8.8"

while($true){
     test-connection $target -count 1 |
     select @{N='Time';E={[dateTime]::Now}},
          @{N='Destination';E={$_.address}},
          replysize,
          @{N='Time(ms)'; E={$_.ResponseTime}}
          sleep -MilliSeconds 1000
}