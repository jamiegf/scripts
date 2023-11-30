USE NexusPlayer3_1;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE  NexusPlayer3_1
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE ( NexusPlayer3_1_log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE  NexusPlayer3_1
SET RECOVERY FULL;
GO