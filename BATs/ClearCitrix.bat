for /f "tokens=3" %%a in ('qwinsta %username% /server:lgactx00 ^| find /i "%username%"') do rwinsta %%a /server:lgactx00
for /f "tokens=3" %%a in ('qwinsta %username% /server:lgactx01 ^| find /i "%username%"') do rwinsta %%a /server:lgactx01
for /f "tokens=3" %%a in ('qwinsta %username% /server:lgactx02 ^| find /i "%username%"') do rwinsta %%a /server:lgactx02
for /f "tokens=3" %%a in ('qwinsta %username% /server:lgactx03 ^| find /i "%username%"') do rwinsta %%a /server:lgactx03
