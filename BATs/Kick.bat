@echo off
echo **************************
echo Welcome JGF's kick script
echo. 
echo **************************
echo.
echo.
pause
GOTO MENU
:MENU
cls
@echo off
echo.
echo What would you like to do?
echo.
echo  1. View/Clear a users Citrix sessions?
echo.
echo  2. View/clear server session?
echo.
echo  3. Exit?
echo.
echo.
echo.
echo ....................
set /p m=Type choice now:
echo ....................
if %m%==1 GOTO CITRIX
if %m%==2 GOTO QWINSTA
if %m%==3 GOTO EOF
:CITRIX
@echo off
set /p user=Enter User name  : 
cls
echo.
echo next server BTGUKCTX04
pause
echo %user%
qwinsta %user% /server:btgukctx04
echo .
echo .
echo .
echo If no session ID exists, press enter
set /p id4=or enter session ID to delete : 
echo %id4%
rwinsta %id4% /server:btgukctx04
cls



echo next server BTGUKCTX06
pause
qwinsta %user% /server:BTGUKCTX06
echo .
echo .
echo .
echo If no session ID exists, press enter
set /p id6=or enter session ID to delete : 
echo %id6%
rwinsta %id6% /server:BTGUKCTX06
cls



echo next server BTGUKCTX08
pause
qwinsta %user% /server:BTGUKCTX08
echo .
echo .
echo .
echo If no session ID exists, press enter
set /p id8=or enter session ID to delete : 
echo %id8%
rwinsta %id8% /server:BTGUKCTX08
cls


echo next server UKBTGCTX09
pause
qwinsta %user% /server:UKBTGCTX09
echo .
echo .
echo .
echo If no session ID exists, press enter
set /p id9=or enter session ID to delete : 
echo %id9%
rwinsta %id9% /server:UKBTGCTX09
cls


echo next server UKBTGCTX10
pause
qwinsta %user% /server:UKBTGCTX10
echo .
echo .
echo .
echo If no session ID exists, press enter
set /p id10=or enter session ID to delete : 
echo %id10%
rwinsta %id10% /server:UKBTGCTX10
cls



echo Complete!
pause

GOTO MENU



:QWINSTA
@echo off
cls
set /p svr=Enter name of server to view : 
echo %svr%
qwinsta /server:%svr%

set /p id=Enter ID to clear session or just press enter to continue : 
echo %id%
rwinsta %id% /server:%svr%
cls
pause
cls
qwinsta /server:%svr%
pause
GOTO MENU
