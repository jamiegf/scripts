@ECHO OFF

rem -s			Server expect next param to be server name (shift twice)
rem -db			Database name
rem -u			Username expect next param to be users account name (shift twice)
rem -p			Password expect next param to be user password (shift twice)
rem -E			Trusted connection
rem -f			Filename

SETLOCAL
SET OLDSCRIPTPATH=%CD%

:SetupPath
REM If script root is set, use that, else set our default path.
IF [%SCRIPTROOT%] == [] (
	SET SCRIPTROOT=.\
	goto PathSet
	)
SET SCRIPTROOT=%SCRIPTROOT:"=%
:PathSet

SET ServerName=
SET DatabaseName=
SET ConnectionType=
SET ConnectionInfo=
SET Filename=

:Loop
	IF "%1"=="" GOTO DoneParams
	
	IF "%1"=="-f" (
		SET Filename=%2
REM		SET Filename=%Filename:"=%
		SHIFT
		Goto NextParam
	)
	
	IF "%1"=="-s" (
		SET ServerName=%2
		SHIFT
		Goto NextParam
	)

	IF "%1"=="-S" (
		SET ServerName=%2
		SHIFT
		Goto NextParam
	)

	IF "%1"=="-u" (
		SET UserName=%2
		SET ConnectionType=STANDARD
		SHIFT
		Goto NextParam
	)
	
	IF "%1"=="-U" (
		SET UserName=%2
		SET ConnectionType=STANDARD
		SHIFT
		Goto NextParam
	)
	
	IF "%1"=="-p" (
		SET UserPassword=%2
		SET ConnectionType=STANDARD
		SHIFT
		Goto NextParam
	)
	
	IF "%1"=="-P" (
		SET UserPassword=%2
		SET ConnectionType=STANDARD
		SHIFT
		Goto NextParam
	)
	
	IF "%1"=="-E" (
		SET ConnectionType=TRUSTED
		Goto NextParam
	)
	
	IF "%1"=="-db" (
		SET DatabaseName=%2
		SHIFT
		Goto NextParam
	)

	IF "%1"=="-d" (
		SET DatabaseName=%2
		SHIFT
		Goto NextParam
	)

:NextParam
	SHIFT
GOTO Loop
:DoneParams

IF "%ConnectionType%"=="TRUSTED" (
	SET ConnectionInfo=-E
)

IF "%ConnectionType%"=="STANDARD" (
	SET ConnectionInfo=-U %UserName% -P %UserPassword%
)

:CheckParams
REM Check database
if "%DatabaseName%"=="" Goto Usage
REM Check Server
if "%ServerName%"=="" Goto Usage
REM Check ConnectionInfo
if "%ConnectionInfo%"=="" Goto Usage
REM Check Filename
if "%Filename%"=="" Goto Usage

:ShowParms

SET Params=-S %ServerName% -d %DatabaseName% %ConnectionInfo%

Goto Continue

:Usage
@Echo Usage (Note Parameters are case and switch sensitive):
@Echo	-s			Server host name next parameter expects SQL server name
@Echo	-db			Database name next parameter expects SQL server database name
@Echo	-u			Username next parameter expects users account name
@Echo	-p			Password next parameter expects user password
@Echo	-E			Use a Trusted database connection
@Echo	-f			Filename (Fully qualified path) to execute

Goto ScriptDone

:Continue
IF EXIST %Filename% (
	Echo Adding file %Filename%
	SQLCMD %Params% -i %Filename%
) ELSE (
	Echo Attention; File Missing: %Filename%
	Goto ScriptDone
)

:ScriptDone
ENDLOCAL