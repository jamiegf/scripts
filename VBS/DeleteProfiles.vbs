'deletes all folders within docs and settings with excetions  
Const LocalDocumentsFolder = "M:\Documents and Settings"

set objFSO = createobject("Scripting.FileSystemObject")
set objFolder = objFSO.GetFolder(localdocumentsfolder)

on error resume next

for each fldr in objFolder.SubFolders
                if not isexception(fldr.name) then
                                objFSO.DeleteFolder fldr.path, True
                                ' WScript.Echo "Deleting : " & fldr.path & vbcrlf & "- (Unless currently in use)"
                end if
next


Function isException(byval foldername)
                if Right(foldername, 1) = "2" then
                                isException = True

                elseif Left(lcase(Foldername), 3) = "ctx" then
                                isException = True
                else
                                                select case foldername
                                                                case "All Users"
                                                                                isException = True
                                                                case "Default User"
                                                                                isException = True
                                                                case "LocalService"
                                                                isException = True
                                                case "NetworkService"
                                                                isException = True
                                                case "Administrator"
                                                                isException = True
                                                case "server.support"
                                                                isException = True
                                                case "veritas"
                                                                isException = True
                                                case ""
                                                                isException = True                           
                                                case Else
                                                                isException = False
                                End Select
                end if
End Function
