
$yesterday = ((get-date).adddays(-1)).tostring('yyyy-MM-dd') 

$User = "alert@miomni.com"  
$Password = "777RedHound321"


#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
  
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
Create-Folder -SiteURL "https://miomni.sharepoint.com/sites/WheelingIsland/" -Cred $credentials -LibraryName "Documents" -FolderName "FinancialReporting/$yesterday"


#Read more: http://www.sharepointdiary.com/2016/08/sharepoint-online-create-folder-using-powershell.html#ixzz5nRKbhkPP