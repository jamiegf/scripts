:MENU
cls
@echo off
echo.
echo   COPY PROFILE
echo   *************
echo.
echo.
echo What would you like to do?
echo.
echo  1. Copy XP Profile to H:\Temp_Profile
echo.
echo  2. Copy W7 Profile to H:\Temp_Profile
echo.
echo  3. Copy H:\Temp_Profile to W7
echo.
echo  4. Exit?
echo.
echo.
echo.
echo ....................
set /p m=Type choice now:
echo ....................
if %m%==1 GOTO XP
if %m%==2 GOTO W7
if %m%==3 GOTO H
if %m%==4 GOTO EOF


:xp
@echo off
XCOPY "C:\Documents and Settings\%username%\Application Data\microsoft\outlook\*.nk2" "H:\_Temp_Profile" /C /R /I /K /Y
XCOPY "C:\Documents and Settings\%username%\Application Data\microsoft\Templates" "H:\_Temp_Profile\Templates" /E /C /R /I /K /Y
XCOPY "C:\Documents and Settings\%username%\Favorites" "H:\_Temp_Profile\Favorites" /E /C /R /I /K /Y
XCOPY "C:\Documents and Settings\%username%\My Documents" "H:\_Temp_Profile\My Documents" /E /C /R /I /K /Y
XCOPY "C:\Documents and Settings\%username%\Desktop" "H:\_Temp_Profile\Desktop" /E /C /R /I /K /Y
echo complete
pause
GOTO MENU

:W7
@echo off
XCOPY "C:\Users\%username%\appdata\roaming\microsoft\outlook\*.nk2" "H:\_Temp_Profile" /C /R /I /K /Y
XCOPY "C:\Users\%username%\appdata\roaming\microsoft\Templates" "H:\_Temp_Profile\Templates" /E /C /R /I /K /Y
XCOPY "C:\users\%username%\Favorites" "H:\_Temp_Profile\Favorites" /E /C /R /I /K /Y
XCOPY "C:\users\%username%\Documents" "H:\_Temp_Profile\My Documents" /E /C /R /I /K /Y
XCOPY "C:\users\%username%\Desktop" "H:\_Temp_Profile\Desktop" /E /C /R /I /K /Y
echo Complete
pause
GOTO MENU



:H
@echo off
xcopy "H:\_Temp_Profile\*.nk2" "C:\Users\%username%\appdata\roaming\microsoft\outlook" /C /R /I /K /Y
xcopy "H:\_Temp_Profile\Templates" "C:\Users\%username%\appdata\roaming\microsoft\Templates" /E /C /R /I /K /Y
XCOPY "H:\_Temp_Profile\Favorites" "C:\users\%username%\Favorites"  /E /C /R /I /K /Y
XCOPY "H:\_Temp_Profile\My Documents" "C:\users\%username%\Documents" /E /C /R /I /K /Y
XCOPY "H:\_Temp_Profile\Desktop" "C:\users\%username%\Desktop" /E /C /R /I /K /Y
echo complete
pause
GOTO MENU
