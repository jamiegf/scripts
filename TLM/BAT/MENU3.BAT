@ECHO OFF 
C: 
CD\ 
CLS



SET /P m=Type 1, 2, 3, or 4 then press ENTER:
if %m%==1 goto disk1
if %m%==2 goto disk2
if %m%==3 goto disk3
if %m%==4 goto disk4
if %m%==Q goto EOF
if %m%==q goto EOF
GOTO menu


:DISK0 
diskpart /s x:\Windows\System32\batchref\format0.txt
goto IMAGE

:DISK1
diskpart /s x:\Windows\System32\batchref\format1.txt
goto IMAGE


:DISK2
diskpart /s x:\Windows\System32\batchref\format2.txt
goto IMAGE

:DISK3
diskpart /s x:\Windows\System32\batchref\format3.txt
goto IMAGE

:DISK4
diskpart /s x:\Windows\System32\batchref\format4.txt
goto IMAGE

:IMAGE
echo.
echo.Select an image...
echo.
echo.
echo   1. 6910p
echo.
echo   2. 6930p
echo.
echo   3. 8440p
echo.
echo   4. 8460p
echo.
echo   5. 2560p
echo.
:IMAGECHOICE
set /p i=Type choice:
if %i%==1 goto IMAGE1
if %i%==2 goto IMAGE2
if %i%==3 goto IMAGE3
if %i%==4 goto IMAGE4
if %i%==5 goto IMAGE5
if %i%==Q goto EOF
if %i%==q goto EOF
GOTO IMAGECHOICE

:IMAGE1
Imagex.exe /apply %SOURCEDRIVE%images\6910p.wim 1 C:
X:\windows\system32\bcdboot C:\windows /s C: 
EXIT 

:IMAGE2
Imagex.exe /apply %SOURCEDRIVE%images\6930p.wim 1 C:
X:\windows\system32\bcdboot C:\windows /s C: 
bcdboot.exe c:\windows /s c:
EXIT 

:IMAGE3
Imagex.exe /apply %SOURCEDRIVE%images\8440p.wim 1 C:
bootsect /nt60 C: 
X:\windows\system32\bcdboot C:\windows 
EXIT

:IMAGE4
Imagex.exe /apply %SOURCEDRIVE%images\8460p.wim 1 C:
bootsect /nt60 C: 
X:\windows\system32\bcdboot C:\windows 
EXIT 

:IMAGE5
Imagex.exe /apply %SOURCEDRIVE%images\2560p.wim 1 C:
bootsect /nt60 C: 
X:\windows\system32\bcdboot C:\windows 
EXIT
