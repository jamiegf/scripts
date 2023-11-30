@ECHO OFF

cls

SETLOCAL

SET SqlServer=127.0.0.1
SET SQLScriptRoot=\\rs-2k8fp01.resource.wildnet.local\operations\06_DatabaseAdministration\
SET ScriptRoot=\\rs-2k8fp01.resource.wildnet.local\operations\06_DatabaseAdministration\BackupDatabases\
SET BackupDatabasesLocation=D:\DatabaseBackups\

REM Backup Database Location
mkdir %BackupDatabasesLocation%
REM Use this batch command or execute the BackupDatabases.sql

echo.
echo Backing Up Databases...

Call "%SQLScriptRoot%ExecuteSQL.cmd" -E -s %SqlSERVER% -db master -f "%ScriptRoot%BackupDatabases.sql" > %BackupDatabasesLocation%BackupDatabases.log

:finish

echo.
echo Completed backup of databases to %BackupDatabasesLocation%
echo.
echo Please review BackupDatabases.log for any errors
echo.

Pause

Start notepad D:\DatabaseBackups\BackupDatabases.log


