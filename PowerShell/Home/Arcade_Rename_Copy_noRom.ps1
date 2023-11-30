$rom = "legend_of_mana"
$console = "PS1"
#$extension = "zip"

$arcadeOutFolder = "c:\temp\Arcade_Out"

#edit file extensions for rom downlaods of necessary below
#####cop rom
#@(Get-ChildItem c:\users\j\Downloads\* -Include *.7z, *.zip | Sort LastWriteTime -Descending)[0] |  Copy-Item -destination $destination -force 
#copy snap  video
Move-Item -Path C:\Users\j\Documents\YouTubeDownloads\*.mp4 -Destination $arcadeOutFolder 

#Get-ChildItem $arcadeOutFolder\*.$extension | Rename-Item -NewName "$rom.$extension"
Get-ChildItem $arcadeOutFolder\*.jpg | Rename-Item -NewName "$rom.jpg"
Get-ChildItem $arcadeOutFolder\*.png | Rename-Item -NewName "$rom.png"
Get-ChildItem $arcadeOutFolder\*.mp4 | Rename-Item -NewName "$rom.mp4"



# large roms / small roms? edit rom path below
& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\temp\WinSCP.log" /ini=nul `
  /command `
    "open scp://jamiegf:Fenrir21@192.168.1.102/ -hostkey=`"`"ssh-ed25519 255 49kUUcfrYoHIMF8IHGemywvfiL9ktDGdq2n7p5nORL4=`"`"" `
    "put $arcadeOutFolder\*.jpg /home/jamiegf/roms/$console/_boxart/" `
    "put $arcadeOutFolder\*.png /home/jamiegf/roms/$console/_wheel/" `
    "put $arcadeOutFolder\*.mp4 /home/jamiegf/roms/$console/_snap/" `
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
  Write-Host "Success"
}
else
{
  Write-Host "Error"
}


# local
#copy-item "$arcadeOutFolder\*.$extension" "C:\Users\j\OneDrive - JamieGF\IT_Docs\Emulation\Home\roms\$console\"  # comment out for large roms
copy-item "$arcadeOutFolder\*.jpg" "C:\Users\j\OneDrive - JamieGF\IT_Docs\Emulation\Home\roms\$console\_boxart" -Force
copy-item "$arcadeOutFolder\*.png" "C:\Users\j\OneDrive - JamieGF\IT_Docs\Emulation\Home\roms\$console\_wheel" -Force
copy-item "$arcadeOutFolder\*.mp4" "C:\Users\j\OneDrive - JamieGF\IT_Docs\Emulation\Home\roms\$console\_snap" -Force

#clean up
Remove-Item –path $arcadeOutFolder\*.* -Force

exit $winscpResult