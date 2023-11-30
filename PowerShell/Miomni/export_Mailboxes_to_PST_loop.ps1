
$exportlist = get-content "C:\Users\jamie.garrow-fisher\Desktop\montdor.txt"
foreach ($mailbox in $exportlist)
    {New-MailboxExportRequest -Mailbox $mailbox -FilePath "\\mi01exch002\e$\temp\$mailbox.pst"
    }