@echo off
:MENU
cls
@echo off
echo.
echo What would you like to do?
echo.
echo  1. Notepad
echo.
echo  2. Calculator
echo.
echo  3. Exit
echo.
echo.
echo.
echo ....................
set /p m=Type choice now:
echo ....................
if %m%==1 GOTO SELECTION1
if %m%==2 GOTO SELECTION2
if %m%==3 GOTO EOF
CLS

ECHO **** INVALID INPUT ****
echo.
ECHO Please select 1,2 or 3
echo.
PAUSE  
GOTO MENU 
CLS 

:SELECTION1
@echo off
cls
cd %windir%\system32\notepad.exe
start notepad.exe
cls
echo Complete!
pause
GOTO MENU

:SELECTION2
@echo off
cls
cd %windir%\system32\calc.exe
start calc.exe
cls
echo Complete!
pause
GOTO MENU
