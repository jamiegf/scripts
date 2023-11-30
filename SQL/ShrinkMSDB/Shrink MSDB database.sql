DECLARE @HistoryDays integer, @endtime datetime
SELECT @HistoryDays = 14
Select @endtime = getutcdate()

WHILE EXISTS(
	SELECT TOP 1 task_detail_id,l.start_time
	FROM sysmaintplan_log l
	WHERE DATEDIFF(dd,l.start_time,@endtime) > @HistoryDays
	ORDER BY l.start_time ASC
	)
BEGIN
	BEGIN TRANSACTION

	SELECT TOP 100 task_detail_id,l.start_time
	into #Remove 
	FROM sysmaintplan_log l
	WHERE DATEDIFF(dd,l.start_time,@endtime) > @HistoryDays
	ORDER BY l.start_time ASC

	DELETE lg
	FROM sysmaintplan_logdetail lg
	inner join #Remove R on lg.task_detail_id = r.task_detail_id

	DELETE l
	FROM sysmaintplan_log l
	inner join #Remove R on l.task_detail_id = r.task_detail_id

	DROP TABLE #Remove

	COMMIT TRANSACTION
END
GO
CHECKPOINT
GO

DBCC SHRINKDATABASE(N'msdb', 0 )
GO