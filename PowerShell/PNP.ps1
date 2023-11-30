#Config Variables
$SiteURL = "https://miomni.sharepoint.com/sites/WheelingIsland/"
$FolderName= "test444"
$RelativeURL= "/FinancialReports" #Relative URL of the Parent Folder
 
#Get Credentials to connect
$Cred = Get-Credential
 
Try {
    #Connect to PNP Online
    Connect-PnPOnline -Url $SiteURL -Credentials $Cred
     
    #sharepoint online create folder powershell
    Add-PnPFolder -Name $FolderName -Folder $RelativeURL -ErrorAction Stop
    Write-host -f Green "New Folder '$FolderName' Added!"
}
catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}

#Read more: http://www.sharepointdiary.com/2016/08/sharepoint-online-create-folder-using-powershell.html#ixzz5nzCRuEB1
