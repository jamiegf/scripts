/*
#####################################################################################################
## Create Date: 6.16.05
## v1.0 (beta)
## Author: Jonas Irwin
## Purpose: 
## Grab IO statistics for SQL Server databases and data files over operator specified time interval
## Mods: 6.27.05 - WAITFOR DELAY '000:00:10'
## Added Delay time - 
## Please update at will for your use - example above is only 10 seconds
##  search for text "WAITFOR DELAY to find section to change
## Mods: 09.09.05 - Added new columns for log/data file distinction 0 for log, 1 for data
## Added total size of file all at the end columns so we don't break the parser 
## as per Radha's request              
#####################################################################################################
 
*/
 
DECLARE @total int
DECLARE @now datetime
select @now = getdate()
select @total = 0



 
USE master
 
SELECT @total=count(*)
FROM sysobjects
WHERE  (name = 'sqlio')
 

IF @total = 0 BEGIN
CREATE TABLE #SQLIO
  (dbname  varchar(128) ,
  fName  varchar(2048), 
  startTime  datetime,
  noReads1  int,
  noWrites1  int,
  BytesRead1  bigint , 
  BytesWritten1  bigint ,
  noReads2  int,
  noWrites2  int,
  BytesRead2  bigint , 
  BytesWritten2 bigint, 
  endtime datetime,
  deltawrites  bigint,
  deltareads  bigint,
  timedelta   bigint,
  fileType   bit,
  fileSizeBytes bigint 
  )
END
ELSE
	--remove what was there from before
	delete from #sqlio
 

--grab baseline first sample
INSERT INTO #SQLIO 
SELECT 
 cast(DB_Name(a.dbid) as varchar) as Database_name,
 b.filename,
 getdate(),
 cast(numberReads as int),
 cast(numberWrites as int),
 cast(a.BytesRead as bigint),
 cast(a.BytesWritten as bigint),
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 0,
 'filetype' = case when groupid > 0 then 1 else 0 end,
 cast(b.size as bigint) * 8192
FROM  
 ::fn_virtualfilestats(-1,-1) a
Inner join sysaltfiles b on
  a.dbid = b.dbid and
  a.fileid = b.fileid
ORDER BY Database_Name
 
/*DELAY AREA  - change time at will */
WAITFOR DELAY '000:30:00'
 

UPDATE #SQLIO 
set 
 BytesRead2=cast(a.BytesRead as bigint),
 BytesWritten2=cast(a.BytesWritten as bigint),
 noReads2 =numberReads ,
 noWrites2 =numberWrites,
 endtime= getdate(),
 deltaWrites = (cast(a.BytesWritten as bigint)-BytesWritten1),
 deltaReads= (cast(a.BytesRead as bigint)-BytesRead1),
        timedelta = (cast(datediff(s,startTime,getdate()) as bigint))
 
FROM ::fn_virtualfilestats(-1,-1) a ,sysaltfiles b
WHERE   fName= b.filename and dbname=DB_Name(a.dbid) and
  a.dbid = b.dbid and
  a.fileid = b.fileid
 

/*dump results to screen */
select * from #sqlio