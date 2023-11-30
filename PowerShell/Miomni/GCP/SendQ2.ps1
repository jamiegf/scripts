
[int]$messageCount = 0

Do {$messages = Get-MsmqQueue -QueueType Private #| Format-Table -Property QueueName,MessageCount;
    [int]$messageCount = $messages.messagecount
    $messageCount
    if ($messageCount -gt 0)
            {& 'C:\Miomni\Q2Email\Q2Email.exe - Station.lnk'
            sleep 5}
        }until ($messageCount -eq 0)