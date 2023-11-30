$CasinoInitials = "WI"
$siteURL = "https://miomni.sharepoint.com/sites/WheelingIsland/"
$Username = "alert@miomni.com"
$Password = "777RedHound321"
$yesterday = ((get-date).adddays(-1)).tostring('yyyy_MM_dd')

$Folder = "C:\Reports\Results\WI\Reports_2019-05-15"




[Securestring]$SecurePass = ConvertTo-SecureString  $password -AsPlainText -Force
[System.Management.Automation.PSCredential]$PSCredentials = new-object system.management.Automation.Pscredential($Username, $SecurePass)

Connect-PnPOnline -Url $SiteUrl -Credentials $PSCredentials   
Add-PnPFolder -name $yesterday -folder "shared documents/FinancialReporting" 

cd "C:\Reports\Results\$CasinoInitials\Reports_$today" 

$spfolder = "shared documents/FinancialReporting/$yesterday" 
 
Add-PnPFile -Path "GLI_7.7.3.xlsx"  -Folder $spfolder
Add-PnPFile -Path "MICS_125.xlsx"  -Folder $spfolder
Add-PnPFile -Path "MICS_125_SUMMATIONS.xlsx"  -Folder $spfolder
Add-PnPFile -Path "Mobile_Daily_Audit.xlsx" -Folder $spfolder
Add-PnPFile -Path "Open_Close_RetailSummary_$CasinoInitials.xlsx"  -Folder $spfolder
Add-PnPFile -Path "MICS_127_$CasinoInitials.xlsx"  -Folder $spfolder
Add-PnPFile -Path "Player_Accounts_$CasinoInitials.xlsx" -Folder $spfolder
 

  