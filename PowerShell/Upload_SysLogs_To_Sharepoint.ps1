#Specify tenant admin and site URL  
$User = "alert@miomni.com"  
$Password = '777RedHound321'  
$SiteURL = "https://miomni.sharepoint.com/sites/WVLottery/" 
$Folder = "E:\Firewall_Syslogs"  
#Path where you want to Copy  
$DocLibName = "Firewall_SysLog"  
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)  
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User, (ConvertTo-SecureString $Password -AsPlainText -Force))  
$Context.Credentials = $Creds  
#Retrieve list  
$List = $Context.Web.Lists.GetByTitle($DocLibName)  
$Context.Load($List)  
$Context.ExecuteQuery()  
# Upload file  
Foreach($File in (dir $Folder -File))  
{  
    $FileStream = New-Object IO.FileStream($File.FullName, [System.IO.FileMode]::Open)  
    $FileCreationInfo = New-Object Microsoft.SharePoint.Client.FileCreationInformation  
    $FileCreationInfo.Overwrite = $False  
    $FileCreationInfo.ContentStream = $FileStream  
    $FileCreationInfo.URL = $File  
    $Upload = $List.RootFolder.Files.Add($FileCreationInfo)  
    $Context.Load($Upload)  
    $Context.ExecuteQuery()  
}  