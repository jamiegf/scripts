@ECHO OFF 
C: 
CD\ 
CLS

:MENU

ECHO ============= Installeren Thin Image ============= 
ECHO ****************
ECHO 1.  Thinclient T5740 
ECHO *****************
ECHO 2.  ThinPC 8200 
ECHO ******************
ECHO ==========PRESS 'Q' TO QUIT========== 
ECHO.

SET INPUT= 
SET /P INPUT=Please select a number:

IF /I '%INPUT%'='1' GOTO Selection1 
IF /I '%INPUT%'=='2' GOTO Selection2 
IF /I '%INPUT%'=='Q' GOTO Quit 
CLS

ECHO *********INVALID INPUT**********
ECHO ***************
ECHO Please select a number from the Main 
echo Menu [1-2] or select 'Q' to quit. 
ECHO ***************
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL 
GOTO MENU 
CLS 
:Selection1
ECHO U SELECTED NUMERO 1
:Selection2
ECHO U SELECTED NUMERO 2
:Quit 
CLS 
ECHO ************************
ECHO =============PRESS ANY KEY TO CONTINUE============== 
ECHO ****************************

PAUSE>NUL 
EXIT