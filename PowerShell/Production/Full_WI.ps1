
$ReportsLocation = "C:\Reports\Reports_Service_MG"
$casinoName = "MardiGras"
$CasinoInitials = "MG"


$reportsServiceFolder = "Reports_Service_$CasinoInitials"
cd "C:\Reports\$reportsServiceFolder"
.\ReportPROcessor.exe

#Specify tenant admin and site URL
$today = (get-date).tostring('yyyy-MM-dd')
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$User = "alert@miomni.com"
$SiteURL = "https://miomni.sharepoint.com/sites/$casinoName/"
$Folder = "C:\Reports\Results\$CasinoInitials\Reports_$today\ToUpload"
$DocLibName = "Documents"
$FolderName = "FinancialReporting/$yesterday"
   
   #Copy relevant reports
   cd "C:\Reports\Results\$CasinoInitials\Reports_$today"
   $ToUpload = New-Item ToUpload -ItemType Directory
   Copy-Item GLI_7.7.3.xlsx $ToUpload 
   Copy-Item MICS_125.xlsx $ToUpload 
   copy-item MICS_125_SUMMATIONS.xlsx $ToUpload
   copy-item Mobile_Daily_Audit.xlsx  $ToUpload
   copy-item Open_Close_RetailSummary_$CasinoInitials.xlsx $ToUpload
   copy-item MICS_127_$CasinoInitials.xlsx $ToUpload
   Copy-Item Player_Accounts_$CasinoInitials.xlsx $ToUpload
 


#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
$Password = "777RedHound321"  | ConvertTo-SecureString -AsPlainText -Force


#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,$Password)
$Context.Credentials = $Creds

#connnect with PNP - plugfin needed!
Connect-PnPOnline -Url $SiteUrl -Credentials $cred   
Add-PnPFolder -name $yesterday -folder "shared documents/FinancialReporting"    
              


#Retrieve list
$List = $Context.Web.Lists.GetByTitle($DocLibName)
$Context.Load($List.RootFolder)
$Context.ExecuteQuery()

$TargetFolder = $Context.Web.GetFolderByServerRelativeUrl($List.RootFolder.ServerRelativeUrl + "/" + $FolderName);


#Upload file(s)
Foreach ($File in (dir $Folder -File))
{
    $FileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation
    $FileCreationInfo.Overwrite = $true
    $FileCreationInfo.Content = [System.IO.File]::ReadAllBytes($File.FullName)
    $FileCreationInfo.URL = $File.Name
    $UploadFile = $TargetFolder.Files.Add($FileCreationInfo)
    $Context.Load($UploadFile)
    $Context.ExecuteQuery()
}



