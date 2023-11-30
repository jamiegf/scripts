#When setting up virtual machines to be used for development work, one typically needs the following Windows features installed:
#IIS
#ASP.NET
#MSMQ
#Below is a handy PowerShell script that configures the installs the aforementioned features and does the following additional configuration items:
#Registers ASP.NET 4.0 with IIS via aspnet_regiis.exe
#Adds a firewall rule to allow inbound traffic over TCP port 1433 for remote SQL Server access
ConfigureDevServerRequiredFeatures

function ConfigureDevServerRequiredFeatures()
{
    $ErrorActionPreference  = "Stop";
    
    write-host "Starting setup…" -foregroundcolor yellow;
    
    #First check if .NET 4.0 is installed
 
    $net40Path = [System.IO.Path]::Combine($env:SystemRoot, "Microsoft.NET\Framework\v4.0.30319");
    $aspnetRegIISFullName = [System.IO.Path]::Combine($net40Path, "aspnet_regiis.exe");
 
    if ((test-path $aspnetRegIISFullName) -eq $false)
    {
        $message =  "aspnet_regiis.exe was not found in {0}. Make sure Microsoft .NET Framework 4.0 installed first." -f $net40Path;
        write-error $message;
    }
 
    write-host "Microsoft .NET Framework 4.0 appears to be installed." -foregroundcolor green;
 
    import-module ServerManager
 
    #Check for existance of required Windows features
 
    write-host "Checking for existance of required Windows features…" -foregroundcolor yellow
    CheckFeatureExists MSMQ-Server "Message Queueing Server";
    CheckFeatureExists Web-Mgmt-Console "IIS Management Console";
    CheckFeatureExists Web-Metabase "IIS 6 Metabase Compatibility";
    CheckFeatureExists Web-Asp-Net "ASP.NET";
    CheckFeatureExists Web-Dir-Browsing "Directory Browsing";
    CheckFeatureExists Web-Default-Doc "Default Document";
    CheckFeatureExists Web-Net-Ext ".NET Extensibility";
    CheckFeatureExists Web-ISAPI-Ext "ISAPI Extensions";
    CheckFeatureExists Web-ISAPI-Filter "ISAPI Filters";
    CheckFeatureExists Web-Basic-Auth "Basic Authentication";
    CheckFeatureExists Web-Windows-Auth "Windows Authentication";
    CheckFeatureExists Web-Filtering "Request Filtering";
    CheckFeatureExists Web-CGI "CGI";
    CheckFeatureExists AS-HTTP-Activation "HTTP Activation"
    CheckFeatureExists Web-Static-Content "Static Content"
    write-host "All required features were found and can be enabled." -foregroundcolor green
 
    #Install features
 
    write-host "Installing features…" -foregroundcolor yellow;
    add-windowsfeature MSMQ-Server, Web-Mgmt-Console, Web-Metabase, Web-Asp-Net, Web-Dir-Browsing, Web-Default-Doc, Web-Net-Ext, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Basic-Auth, Web-Windows-Auth, Web-Filtering, Web-CGI, AS-HTTP-Activation, Web-Static-Content;
    
    write-host "Features installed." -foregroundcolor green;
 
    #Register ASP.NET 4.0 with IIS
 
    write-host "Registering ASP.NET 4.0 with IIS…" -foregroundcolor yellow;
    start-process -filepath $aspnetRegIISFullName  -argumentlist "-iru";
 
    #Add firewall rule for SQL Server
    write-host "Configuring firewall for remote SQL Server access…" -foregroundcolor yellow;
    netsh advfirewall firewall add rule name="MSSQLSERVER" dir=in action=allow profile=any localport=1433 protocol=tcp interfacetype=any security=notrequired
    write-host "Firewall rule configured." -foregroundcolor green;
 
    write-host "Setup complete." -foregroundcolor green;
}
 
function CheckFeatureExists
(
    [string] $featureName = $(throw "Specify a feature name."),
    [string] $featureDescription = $(throw "Specify a feature description.")
)
{
    $ErrorActionPreference  = "Stop";
    $feature = get-windowsfeature $featureName;
    
    if ($feature -eq $null)
    {    
        $message = "The {0} feature is not supported by this operating system." -f $featureDescription;
        
        write-error $message;
    }
}