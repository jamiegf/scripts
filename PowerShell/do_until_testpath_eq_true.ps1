$folder = "Music_DJ"
$timestamp = Get-Date -format d.M.yyyy
#$sourcepath = "d:\googledrive"
#$destpath = "m:\"
$sourcepath = "h:\test"
$destpath = "j:"



[int]$retries = 6
[int]$c = 0
$continue = $false

do{
   $a = test-path $destpath
    if ($a -eq $true) 
        {
         robocopy "$sourcepath\$folder" "$destpath\$folder" /r:1 /w:2 /MIR /TEE /NP /Z /LOG:"c:\scripts\log\Log.$timestamp.txt"
         $continue = $true
        }
    if ($a -eq $false) 
        {
        write-host "File not found!!!!!"
        sleep 2
        $c++
        If ($c -gt $retries)
            {write-host "exiting" ;exit}
        }
  }
  until ($continue -eq $true)


  


