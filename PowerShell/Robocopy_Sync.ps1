
$folder = "testenv1"
$timestamp = Get-Date -format d.M.yyyy
$sourcepath = "H:\test"
$destpath = "c:\temp"
Write-Host $timestamp
robocopy "$sourcepath\$folder" "$destpath\$folder" /r:1 /w:2 /MIR /TEE /NP /Z /XF *.csv /LOG:"c:\temp\Log.$timestamp.txt"


#r is number of retries if there is an error
#NP No Progress = removes the  progress of the copying operation (the number of files or directories copied so far)  - not as messy log file.
#TEE outputs to screen and log file
#/MIR specifies that Robocopy should mirror the source directory and the destination directory. Note that this will delete files at the destination if they were deleted at the source.
#/FFT uses fat file timing instead of NTFS. This means the granularity is a bit less precise. For across-network share operations this seems to be much more reliable - just don't rely on the file timings to be completely precise to the second.
#/Z ensures Robocopy can resume the transfer of a large file in mid-file instead of restarting.
#/XA:H makes Robocopy ignore hidden files, usually these will be system files that we're not interested in.
#/W:2 reduces the wait time between failures to 2 seconds instead of the 30 second default.
#/XF excludes ffiles types
