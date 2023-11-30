$today = (get-date).tostring('yyyy-MM-dd') 
cd "C:\Reports\Results\WI\Reports_$today"
$ToUpload = New-Item ToUpload -ItemType Directory
Copy-Item GLI_7.7.3.xlsx $ToUpload 
Copy-Item MICS_125.xlsx $ToUpload 
copy-item MICS_125_SUMMATIONS.xlsx $ToUpload
copy-item Mobile_Daily_Audit.xlsx  $ToUpload
copy-item Open_Close_RetailSummary_WI.xlsx $ToUpload
copy-item MICS_127_WI.xlsx $ToUpload
Copy-Item Player_Accounts_WI.xlsx $ToUpload



