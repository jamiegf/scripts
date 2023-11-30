

#Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-HTTP
#Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server


$queueName = "Test448884"
Write-Host "... create new queue, set FullControl permissions for Nexus\jamiegf"
$q1 = [System.Messaging.MessageQueue]::Create(".\private$\$queueName")
$q1.label = $queueName
$q1.SetPermissions("Nexus\jamiegf", 
      [System.Messaging.MessageQueueAccessRights]::FullControl,            
      [System.Messaging.AccessControlEntryType]::Set)