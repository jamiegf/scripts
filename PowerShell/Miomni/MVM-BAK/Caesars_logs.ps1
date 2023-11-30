 $yesterday = ((get-date).adddays(-1)).tostring('MM_dd_yyyy') 

try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = "64.141.194.98"
        UserName = "miomni"
        #Password = "mypassword"
        SshPrivateKeyPath = "C:\Certificates\miomni.ppk"
        SshHostKeyFingerprint = "ssh-rsa 2048 OEptbpP5cCoJ9N3M3XdHh6C0atwC9UY4waVPjhkskmo="
    }
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        # Upload files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
 
        $transferResult =
            $session.PutFiles("E:\Wager_Logs\caesars\$yesterday.csv", "/nvmobilesports/dropoff/", $False, $transferOptions)
 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host "Upload of $($transfer.FileName) succeeded"
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}