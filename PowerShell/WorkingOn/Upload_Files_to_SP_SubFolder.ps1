#Specify tenant admin and site URL
$today = (get-date).tostring('yyyy-MM-dd')
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$User = "alert@miomni.com"
$SiteURL = "https://miomni.sharepoint.com/sites/WheelingIsland/"
$Folder = "C:\Reports\Results\WI\Reports_$today\ToUpload"
$DocLibName = "Documents"
$FolderName = "FinancialReporting/$yesterday"

#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
$Password = "777RedHound321"  | ConvertTo-SecureString -AsPlainText -Force


#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,$Password)
$Context.Credentials = $Creds


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