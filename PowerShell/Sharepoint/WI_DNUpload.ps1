

$ReportsLocation = "C:\Reports\Reports_Service_WI"
$casinoName = "WheelingIsland"
$CasinoInitials = "WI"
$SPSubFolder = "DNReporting"


$reportsServiceFolder = "Reports_Service_$CasinoInitials"

#Specify tenant admin and site URL
$today = (get-date).tostring('yyyy-MM-dd')
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$User = "alert@miomni.com"
$password = "777RedHound321"
$SiteURL = "https://miomni.sharepoint.com/sites/$casinoName/"

$DocLibName = "Documents"
$FolderName = "$SPSubFolder/$yesterday"
   
$spfolder = "shared documents/$SPSubFolder/$yesterday"

#connect to Sharepoint
#[Securestring]$SecurePass = ConvertTo-SecureString  $password -AsPlainText -Force
#[System.Management.Automation.PSCredential]$PSCredentials = new-object system.management.Automation.Pscredential($Username, $SecurePass)
$sp = $password | ConvertTo-SecureString -AsPlainText -Force
$plainCred = New-Object system.management.automation.pscredential -ArgumentList $user, $sp


#create yesterday folder
Connect-PnPOnline -Url $SiteUrl -Credentials $plainCred   
Add-PnPFolder -name $yesterday -folder "shared documents/$SPSubFolder" 

#upload reports
cd "d:\Reports\Results\$CasinoInitials\Reports_$today" 
 
Add-PnPFile -Path "Mobile_Daily_Audit.xlsx" -Folder $spfolder
Add-PnPFile -Path "Open_Close_Summary_$CasinoInitials.xlsx" -Folder $spfolder
Add-PnPFile -Path "MICS_127_$CasinoInitials.xlsx" -Folder $spfolder
Add-PnPFile -Path "Player_Accounts_$CasinoInitials.xlsx" -Folder $spfolder 
Add-PnPFile -Path "Flash_Report_$CasinoInitials.xlsx" -Folder $spfolder