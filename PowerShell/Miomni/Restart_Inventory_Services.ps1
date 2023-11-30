
$fullPaths = 
            "C:\inetpub\wwwroot\WestgateSports-Live452\MiomniGettingInventoryWestgate4.5.2.exe",
            "C:\inetpub\wwwroot\treasure-live372\TIGettingInventory3.7.2.exe"

foreach ($fullPath in $fullPaths)
        {

        $pos = $fullPath.LastIndexOf("\")
        $Path = $fullPath.Substring(0, $pos)
        $exe = $fullPath.Substring($pos+1)
        $process = $exe.Substring(0,$exe.Length-4)

        Get-Process $process | Stop-Process -Force
        cd $Path
        Start-Process ".\$exe"
        }