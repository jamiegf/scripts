DECLARE @DBName sysname, @HistoricalMonths int

SET @DBName = 'Panorama'
SET @HistoricalMonths = 300

DECLARE @BackupList TABLE (
	[backup_set_id] [int] NOT NULL,
	[backup_set_uuid] [uniqueidentifier] NOT NULL,
	[media_set_id] [int] NOT NULL,
	[database_name] [nvarchar](128) COLLATE Latin1_General_CI_AS NULL,
	[server_name] [nvarchar](128) COLLATE Latin1_General_CI_AS NULL,
	[machine_name] [nvarchar](128) COLLATE Latin1_General_CI_AS NULL,
	[physical_device_name] [nvarchar](260) COLLATE Latin1_General_CI_AS NULL,
	[SourceFileLogicalName] [nvarchar](128) COLLATE Latin1_General_CI_AS NULL,
	[SourceFilePhysicalDrive] [nvarchar](260) COLLATE Latin1_General_CI_AS NULL,
	[SourceFilePhysicalName] [nvarchar](260) COLLATE Latin1_General_CI_AS NULL,
	[database_creation_date] [datetime]
)

INSERT INTO @BackupList
           ([backup_set_id]
           ,[backup_set_uuid]
           ,[media_set_id]
           ,[database_name]
           ,[server_name]
           ,[machine_name]
           ,[physical_device_name]
           ,[SourceFileLogicalName]
           ,[SourceFilePhysicalDrive]
           ,[SourceFilePhysicalName]
           ,[database_creation_date]
	)
SELECT --TOP 100
		bs.[backup_set_id]
      ,bs.[backup_set_uuid]
      ,bs.[media_set_id]
      ,bs.[database_name]
      ,bs.[server_name]
      ,bs.[machine_name]
--      ,bms.[name] [MediaName]
--      ,bms.[description] [MediaDescription]
	,bmf.[physical_device_name]
      ,bf.[logical_name]	[SourceFileLogicalName]
      ,bf.[physical_drive]	[SourceFilePhysicalDrive]
      ,bf.[physical_name]	[SourceFilePhysicalName]
      ,bs.[database_creation_date]
FROM [msdb].[dbo].[backupset]   bs
LEFT JOIN [msdb].[dbo].[backupmediaset] bms ON bms.[media_set_id] = bs.[media_set_id]
LEFT JOIN [msdb].[dbo].[backupmediafamily] bmf ON bmf.[media_set_id] = bs.[media_set_id]
LEFT JOIN [msdb].[dbo].[backupfile] bf ON bf.[backup_set_id] = bs.[backup_set_id]
WHERE 
	bs.[database_name] = @DBName
OR  bs.[database_creation_date] <= dateadd(m,-1 * @HistoricalMonths,getdate())

Select * from @BackupList

DELETE bf
FROM [msdb].dbo.backupfile bf
INNER JOIN @BackupList   x ON bf.[backup_set_id] = x.[backup_set_id]

IF  EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[backupfilegroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--IF  EXISTS (SELECT * FROM sys.objects  WHERE object_id = OBJECT_ID(N'[dbo].[backupfilegroup]') AND type in (N'U'))
exec sp_executesql @Statement=N'DELETE bfg
	FROM [msdb].dbo.backupfilegroup bfg
	INNER JOIN @BackupList   x ON bfg.[backup_set_id] = x.[backup_set_id]'

DELETE bmf
FROM [msdb].dbo.backupmediafamily bmf
INNER JOIN @BackupList   x ON bmf.[media_set_id] = x.[media_set_id]
DELETE rfg
FROM [msdb].dbo.restorefilegroup rfg
INNER JOIN [msdb].[dbo].[restorehistory] rh ON rfg.restore_history_id = rh.restore_history_id
INNER JOIN @BackupList   x ON rh.[backup_set_id] = x.[backup_set_id]
DELETE rf
FROM [msdb].dbo.restorefile rf
INNER JOIN [msdb].[dbo].[restorehistory] rh ON rf.restore_history_id = rh.restore_history_id
INNER JOIN @BackupList   x ON rh.[backup_set_id] = x.[backup_set_id]
DELETE rh
FROM [msdb].[dbo].[restorehistory] rh
INNER JOIN @BackupList   x ON rh.[backup_set_id] = x.[backup_set_id]
DELETE bs
FROM [msdb].dbo.backupset bs
INNER JOIN @BackupList   x ON bs.[backup_set_id] = x.[backup_set_id]
DELETE bms
FROM [msdb].dbo.backupmediaset bms
INNER JOIN @BackupList   x ON bms.[media_set_id] = x.[media_set_id]
