

$ReportsLocation = "C:\Reports\Reports_Service_WI"
$casinoName = "WheelingIsland"
$CasinoInitials = "WI"


$reportsServiceFolder = "Reports_Service_$CasinoInitials"
cd "d:\Reports\$reportsServiceFolder"
.\ReportPROcessor.exe

#Specify tenant admin and site URL
$today = (get-date).tostring('yyyy-MM-dd')
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$User = "alert@miomni.com"
$password = "777RedHound321"
$SiteURL = "https://miomni.sharepoint.com/sites/$casinoName/"

$DocLibName = "Documents"
$FolderName = "FinancialReporting/$yesterday"
   
$spfolder = "shared documents/FinancialReporting/$yesterday"

#connect to Sharepoint
#[Securestring]$SecurePass = ConvertTo-SecureString  $password -AsPlainText -Force
#[System.Management.Automation.PSCredential]$PSCredentials = new-object system.management.Automation.Pscredential($Username, $SecurePass)
$sp = $password | ConvertTo-SecureString -AsPlainText -Force
$plainCred = New-Object system.management.automation.pscredential -ArgumentList $user, $sp


#create yesterday folder
#Connect-PnPOnline -Url $SiteUrl -Credentials $PSCredentials   
Connect-PnPOnline -Url $SiteUrl -Credentials $plainCred   
Add-PnPFolder -name $yesterday -folder "shared documents/FinancialReporting" 

#upload reports
cd "d:\Reports\Results\$CasinoInitials\Reports_$today" 
 
Add-PnPFile -Path "GLI_7.7.3.xlsx" -Folder $spfolder
Add-PnPFile -Path "MICS_125.xlsx" -Folder $spfolder
Add-PnPFile -Path "MICS_125_SUMMATIONS.xlsx" -Folder $spfolder
Add-PnPFile -Path "Mobile_Daily_Audit.xlsx" -Folder $spfolder
Add-PnPFile -Path "Open_Close_RetailSummary_$CasinoInitials.xlsx" -Folder $spfolder
Add-PnPFile -Path "MICS_127_$CasinoInitials.xlsx" -Folder $spfolder
Add-PnPFile -Path "Player_Accounts_$CasinoInitials.xlsx" -Folder $spfolder 