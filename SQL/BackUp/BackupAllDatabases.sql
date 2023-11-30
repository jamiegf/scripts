Create Procedure #NightlyBackup(
	@BackupDate varchar(30)
,	@BackupPath nvarchar(2048)
,	@DB sysname
	) AS

DECLARE 
	@BackupFile nvarchar(2048)
,	@BackupFullPath nvarchar(3096)
,	@BackupName nvarchar(256)
,	@BackupSQL nvarchar(MAX), @ErrorSQL nvarchar(MAX)
,	@backupSetId int

SET @BackupFullPath = @BackupPath + @DB
EXECUTE master.dbo.xp_create_subdir @BackupFullPath

Select 
	@BackupFile = @BackupFullPath + '\' + @DB + '_backup_' + @BackupDate + '.bak'
,	@BackupName = @DB + N'_backup_' + @BackupDate
Select 
	@BackupSQL = N'BACKUP DATABASE [' + @DB + '] TO  DISK = N''' + @BackupFile + '''
	WITH NOFORMAT, COPY_ONLY, NOINIT,  NAME = N''' + @BackupName + ''', SKIP, REWIND, NOUNLOAD,  STATS = 10'
exec sp_executesql @Statement = @BackupSQL

select @backupSetId = position from msdb..backupset where database_name= @DB and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name= @DB )
if @backupSetId is null 
begin 
	Set @ErrorSQL =N'Verify failed. Backup information for database [' + @DB + '] not found.'
	raiserror(@ErrorSQL, 16, 1) 
end
RESTORE VERIFYONLY FROM  DISK = @BackupFile WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
use tempdb
DECLARE	@BackupDate varchar(30)
Set @BackupDate = REPLACE(convert(varchar(30),getutcdate(),112) + convert(varchar(30),getutcdate(),108),':','')
SELECT @BackupDate = LEFT(@BackupDate,LEN(@BackupDate)-2)

DECLARE @dbName sysname
DECLARE AllDBCursor CURSOR  STATIC LOCAL FOR
  SELECT   name FROM     MASTER.dbo.sysdatabases
  WHERE    name NOT IN ('tempdb') --'master','model','msdb'
  ORDER BY name
OPEN AllDBCursor; 
FETCH  AllDBCursor INTO @dbName;
WHILE (@@FETCH_STATUS = 0) -- loop through all db-s 
  BEGIN
	IF (@@FETCH_STATUS <> 2)
	BEGIN
		Exec #NightlyBackup
			@BackupDate
		,	N'E:\MSSQL\Backup\'
		,	@dbName
			;
	END
    FETCH  AllDBCursor   INTO @dbName
  END -- while 
CLOSE AllDBCursor; 
DEALLOCATE AllDBCursor;

Drop Procedure #NightlyBackup;
