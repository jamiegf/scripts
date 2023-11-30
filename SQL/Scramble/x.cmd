SET SERVERConnection=DBA-Sanitise
SET DBNAME=%Tmei_WildCommercial_ProdSupport%

CALL .\Scramble.cmd -s %SERVERConnection% -db %DBNAME% -E -f .\ScrambleProcess.sql -LogFile=".\%SERVERConnection%_%DBNAME%.log" 
