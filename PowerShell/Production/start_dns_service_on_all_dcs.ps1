(gwmi -computername gblonad801 -class win32_service | Where-Object { $_.Name -eq “DNS” }).startservice()
(gwmi -computername gblonad802 -class win32_service | Where-Object { $_.Name -eq “DNS” }).startservice()
(gwmi -computername gblonad803 -class win32_service | Where-Object { $_.Name -eq “DNS” }).startservice()
(gwmi -computername gblonad804 -class win32_service | Where-Object { $_.Name -eq “DNS” }).startservice()