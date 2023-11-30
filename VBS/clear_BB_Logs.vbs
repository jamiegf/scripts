Dim fso, OlderThanDate
Dim folder, folderCollection, subFolder
OlderThanDate = DateAdd("d", -9, Date) 
Set fso = CreateObject("Scripting.FileSystemObject")
Set folder = fso.GetFolder("C:\Program Files\Research In Motion\BlackBerry Enterprise Server\Logs\")
Set folderCollection = folder.SubFolders
For Each subFolder In folderCollection
If subFolder.Name <> "webserver" Then
If subfolder.Name <> "Installer" Then
If subFolder.DateCreated < OlderThanDate Then
fso.DeleteFolder subFolder.Path, True
End If
End If
End If
Next