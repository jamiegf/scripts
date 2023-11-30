USE [master];
SET ANSI_NULLS ON; SET QUOTED_IDENTIFIER ON;
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DataFiles]') AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[sp_DataFiles];
GO

 
CREATE PROCEDURE [dbo].[sp_DataFiles] 
/*
	01/08/2007 Yaniv Etrogi   
	http://www.sqlserverutilities.com	
*/
 
AS  
SET NOCOUNT ON;  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  


CREATE TABLE dbo.#Data
(
	 l1 int
	,file_group_name sysname
	,logical_file_name sysname
	,phisical_file_name sysname
	,space_reserved decimal(17, 2)
	,space_reserved_unit nchar(2)
	,space_used decimal(17, 2)
	,space_used_unit nchar(2)
);


DECLARE cur CURSOR LOCAL FAST_FORWARD READ_ONLY FOR 
	SELECT [name] FROM sys.databases 
	WHERE [state] = 0 /* online */
	AND [name] NOT IN ('master', 'model' ) 
ORDER BY [name];


SET NOCOUNT ON;
OPEN cur;
DECLARE @Database sysname, @Command varchar(8000);  

	FETCH NEXT FROM cur INTO @Database ;

	WHILE (@@FETCH_STATUS <> -1)
	BEGIN;

		SELECT @Command = 'USE [' + @Database + ']; 	
		DECLARE @filestats_temp_table TABLE
		(    
			 file_id int
			,file_group_id int
			,total_extents int
			,used_extents int
			,logical_file_name varchar(500) COLLATE database_default
			,physical_file_name varchar(500) COLLATE database_default
		);   
		INSERT INTO @filestats_temp_table EXEC (''DBCC SHOWFILESTATS'');  
		INSERT dbo.#Data (l1,file_group_name ,logical_file_name ,phisical_file_name ,space_reserved ,space_reserved_unit ,space_used ,space_used_unit )
		SELECT  (row_number() OVER (ORDER BY t2.name))%2 AS l1
		,		t2.name AS [file_group_name]
		,       t1.logical_file_name
		,       t1.physical_file_name
		,       CAST(CASE WHEN (total_extents * 64) < 1024 THEN (total_extents * 64)               
										 WHEN (total_extents * 64 / 1024.0) < 1024 THEN  (total_extents * 64 / 1024.0)                
										 ELSE (total_extents * 64 / 1048576.0)  
						END AS DECIMAL(10,2)) AS space_reserved
		,       CASE WHEN (total_extents * 64) < 1024 THEN ''KB''               
										WHEN (total_extents * 64 / 1024.0) < 1024 THEN  ''MB''                  
										ELSE ''GB''       
						END AS space_reserved_unit
		,		CAST(CASE WHEN (used_extents * 64) < 1024 THEN (used_extents * 64)             
										WHEN (used_extents * 64 / 1024.0) < 1024 THEN  (used_extents * 64 / 1024.0)           
										ELSE (used_extents * 64 / 1048576.0)    
						END AS DECIMAL(10,2)) AS space_used
		,		CASE WHEN (used_extents * 64) < 1024 THEN ''KB''            
										WHEN (used_extents * 64 / 1024.0) < 1024 THEN  ''MB''           
										ELSE ''GB''       
						END AS space_used_unit   
		FROM    @filestats_temp_table t1 
		INNER JOIN sys.data_spaces t2 ON ( t1.file_group_id = t2.data_space_id ); ';
				

		--PRINT @Command;
		EXEC (@Command); 

	
		FETCH NEXT FROM cur INTO @Database ;
	END;
CLOSE cur; DEALLOCATE cur;


SELECT * FROM #Data ORDER BY space_reserved_unit ASC, space_reserved DESC;
GO


EXEC sp_ms_marksystemobject 'sp_DataFiles';
GO