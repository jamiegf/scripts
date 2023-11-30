#JGF Cleardown script

$path = "d:\logshare\"
$iisDays = 7
$gamingDays = 30

#delete iis logs
Get-ChildItem $path -Include u_ex*.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$iisDays)} | Remove-Item

#delete gaming logs
Get-ChildItem $path -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$gamingDays)} | Remove-Item

#clean up / delete empty directories
Get-ChildItem $path -Recurse -Force -Directory | 
    Sort-Object -Property FullName -Descending |
    Where-Object { $($_ | Get-ChildItem -Force | Select-Object -First 1).Count -eq 0 } |
    Remove-Item -Verbose
