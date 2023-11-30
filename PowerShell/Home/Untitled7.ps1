# Load WinSCP .NET assembly
Add-Type -Path "WinSCPnet.dll"

# Setup session options
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = "ftp.example.com"
    UserName = "user"
    Password = "mypassword"
}

$session = New-Object WinSCP.Session

# Connect
$session.Open($sessionOptions)

# Resumable upload
$transferResult = $session.PutFiles("C:\path\file.zip", "/home/user/file.zip").Check()