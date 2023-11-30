set fso = CreateObject("Scripting.FileSystemObject")

'the 2 = write permission, 1= read and 3= append,
'true = if file doesnt exist, it will be created
Set objTextFile = fso.OpenTextFiles("Results.txt", 2, True)


objTextFile.WriteLine("This is Text" & thisIsAVariable)
