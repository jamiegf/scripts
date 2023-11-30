FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukctx04 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukctx04 %%j

FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukctx06 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukctx06 %%j

FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukctx08 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukctx08 %%j

FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:ukbtgctx09 ^| findstr "."') DO @echo %%j | rwinsta /server:ukbtgctx09 %%j

FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:ukbtgctx10 ^| findstr "."') DO @echo %%j | rwinsta /server:ukbtgctx10 %%j

FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:ukbssctx01 ^| findstr "."') DO @echo %%j | rwinsta /server:ukbssctx01 %%j



FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukexc03 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukexc03 %%j
FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:ukbtgexc01 ^| findstr "."') DO @echo %%j | rwinsta /server:ukbtgexc01 %%j


FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukdat03 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukdat03 %%j
FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukdat02 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukdat02 %%j
FOR /F "tokens=2,3 skip=1 delims= " %%i IN ('qwinsta jamie.garrow-fisher2 /server:btgukarc01 ^| findstr "."') DO @echo %%j | rwinsta /server:btgukarc01 %%j
pause

for /f "tokens=3" %%a in ('qwinsta "jamie.garrow-fisher2" /server:btgukctx04 ^| find /i "jamie.garrow-fisher2"') do rwinsta %%a /server:btgukctx04
for /f "tokens=3" %%a in ('qwinsta "jamie.garrow-fisher2" /server:btgukexc03 ^| find /i "jamie.garrow-fisher2"') do rwinsta %%a /server:btgukexc03


pause