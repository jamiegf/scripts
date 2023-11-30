$folder1 =  "C:\DJ_Music"
$folder2 =  "C:\Users\j\OneDrive - JamieGF\Music\DJ_Music"
$files = compare (gci -r $folder1) (gci -r $folder2)

foreach ($file in $files)
           {if ($file.SideIndicator -eq "<=")
             {write-host Only $folder1 contains $file.InputObject.Name}
             elseif ($file.SideIndicator -eq "=>")
             {write-host Only $folder2 contains $file.InputObject.Name}

           }

robocopy "$folder1 $folder2 /copyall /S /E"

pause