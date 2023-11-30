

$urls = "https://stn-ip-6-s1.miomni.com/signalrcore/feedshub", "https://stn-ip-6-s2.miomni.com/signalrcore/feedshub", "https://stn-ip-6-s3.miomni.com/signalrcore/feedshub", "https://stn-ip-6-s4.miomni.com/signalrcore/feedshub", "https://www.google.com"


foreach ($url in $urls)
    {
    $statuscode = "error!"
    $statusCode = wget $url | % {$_.StatusCode}
    write-host $url  $statusCode
    }