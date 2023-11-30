for /f "tokens=3" %%a in ('qwinsta %username% /server:btgukctx04 ^| find /i "%username%"') do rwinsta %%a /server:btgukctx04
for /f "tokens=3" %%a in ('qwinsta %username% /server:btgukctx06 ^| find /i "%username%"') do rwinsta %%a /server:btgukctx06
for /f "tokens=3" %%a in ('qwinsta %username% /server:btgukctx08 ^| find /i "%username%"') do rwinsta %%a /server:btgukctx08
for /f "tokens=3" %%a in ('qwinsta %username% /server:ukbtgctx09 ^| find /i "%username%"') do rwinsta %%a /server:ukbtgctx09
for /f "tokens=3" %%a in ('qwinsta %username% /server:ukbtgctx10 ^| find /i "%username%"') do rwinsta %%a /server:ukbtgctx10