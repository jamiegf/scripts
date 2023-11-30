
$ReportsLocation = "C:\Reports\Reports_Service_WI"
$casinoName = "WheelingIsland"
$CasinoInitials = "WI"


$reportsServiceFolder = "Reports_Service_$CasinoInitials"
cd "C:\Reports\$reportsServiceFolder"
#.\ReportPROcessor.exe

#Specify tenant admin and site URL
$today = (get-date).tostring('yyyy-MM-dd')
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 
$User = "alert@miomni.com"
$SiteURL = "https://miomni.sharepoint.com/sites/$casinoName/"
$Folder = "C:\Reports\Results\$CasinoInitials\Reports_$today\ToUpload"
$DocLibName = "Documents"
$FolderName = "FinancialReporting/$yesterday"
   
   #Copy relevant reports
 #   cd "C:\Reports\Results\$CasinoInitials\Reports_$today"
 #   $ToUpload = New-Item ToUpload -ItemType Directory
 #   Copy-Item GLI_7.7.3.xlsx $ToUpload 
 #   Copy-Item MICS_125.xlsx $ToUpload 
 #   copy-item MICS_125_SUMMATIONS.xlsx $ToUpload
 #   copy-item Mobile_Daily_Audit.xlsx  $ToUpload
 #   copy-item Open_Close_RetailSummary_$CasinoInitials.xlsx $ToUpload
 #   copy-item MICS_127_$CasinoInitials.xlsx $ToUpload
 #   Copy-Item Player_Accounts_$CasinoInitials.xlsx $ToUpload
 #


#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
$Password = "777RedHound321"  | ConvertTo-SecureString -AsPlainText -Force


#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,$Password)
$Context.Credentials = $Creds


              Function Create-Folder()
              {
                  param(
                      [Parameter(Mandatory=$true)][string]$SiteURL,
                      [Parameter(Mandatory=$false)][System.Management.Automation.PSCredential] $Cred,
                      [Parameter(Mandatory=$true)][string]$LibraryName,
                      [Parameter(Mandatory=$true)][string]$FolderName
                  )
               
                  Try {
                      #$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.Username, $Cred.Password)
                      $Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User, (ConvertTo-SecureString $Password -AsPlainText -Force))  
                      #Setup the context
                      $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
                      $Ctx.Credentials = $Credentials
               
                      #Get the Library by Name
                      $List = $Ctx.Web.Lists.GetByTitle($LibraryName)
               
                      #Check Folder Exists already
                      $Folders = $List.RootFolder.Folders
                      $Ctx.Load($Folders)
                      $Ctx.ExecuteQuery()
               
                      #Get existing folder names
                      $FolderNames = $Folders | Select -ExpandProperty Name
                      if($FolderNames -contains $FolderName)
                      {
                          write-host "Folder Exists Already!" -ForegroundColor Yellow
                      }
                      else
                      {
                          #sharepoint online create folder powershell
                          $NewFolder = $List.RootFolder.Folders.Add($FolderName)
                          $Ctx.ExecuteQuery()
                          Write-host "Folder '$FolderName' Created Successfully!" -ForegroundColor Green
                      }
                  }
                  Catch {
                      write-host -f Red "Error Creating Folder!" $_.Exception.Message
                  }
              }
               
              #Call the function to delete list view
              Create-Folder -SiteURL "https://miomni.sharepoint.com/sites/$casinoName/" -Cred $credentials -LibraryName "Documents" -FolderName $yesterday
              




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



