﻿Get-ChildItem c:\temp\log -Include U_ex*.log -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-30)} | Remove-Item