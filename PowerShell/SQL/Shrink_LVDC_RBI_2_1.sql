USE LVDC_RBI_2_1;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE  LVDC_RBI_2_1
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE ( LVDC_RBI_2_1_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE  LVDC_RBI_2_1
SET RECOVERY FULL;
GO