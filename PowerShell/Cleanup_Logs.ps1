$limit = (Get-Date).AddDays(-30)
$iislimit = (Get-Date).AddDays(-7)
#$path = "D:\LogShare"
$paths = "D:\LogShare\Sports\", "D:\LogShare\Inplay\", "D:\LogShare\Race\"


    foreach ($path in $paths)
        {
        # Delete files older than the $limit.
        Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

        # Delete files older than the $limit.
        Get-ChildItem -Path $path -Include u_ex*.log -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $iislimit } | Remove-Item -Force

        # Delete any empty directories left behind after deleting the old files.
        Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
        }
