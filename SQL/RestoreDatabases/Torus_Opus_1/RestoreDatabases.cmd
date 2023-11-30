REM @ECHO OFF

cls

SETLOCAL

SET SqlServer=127.0.0.1
SET SQLScriptRoot=\\rs-2k8fp01.resource.wildnet.local\operations\06_DatabaseAdministration\
SET ScriptRoot=\\rs-2k8fp01.resource.wildnet.local\operations\06_DatabaseAdministration\RestoreDatabases\Torus_Opus_1\
SET BackupDatabasesLocation=%1
SET SourceServer=%2

REM Use this batch command or execute the RestoreDatabases.sql

echo.
echo Restoring Databases...

Call "%SQLScriptRoot%ExecuteSQL.cmd" -E -s %SqlSERVER% -db master -f "%ScriptRoot%RestoreDatabases.sql" > %BackupDatabasesLocation%RestoreDatabases.log

:finish

echo.
echo Completed Restore of databases to %BackupDatabasesLocation%
echo.
echo Please review RestoreDatabases.log for any errors
echo.

Pause

Start notepad %BackupDatabasesLocation%RestoreDatabases.log


