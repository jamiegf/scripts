SELECT * 
FROM dbo.sysprocesses 
WHERE status NOT IN ('background','sleeping','runnable','suspended') OR SPID = -2;

SELECT des.program_name,
des.login_name,
des.host_name,
COUNT(des.session_id) [Connections]
FROM sys.dm_exec_sessions des
INNER JOIN sys.dm_exec_connections DEC
ON des.session_id = DEC.session_id
WHERE des.is_user_process = 1
GROUP BY des.program_name,
des.login_name,
des.host_name
HAVING COUNT(des.session_id) > 2
ORDER BY COUNT(des.session_id) DESC

SELECT des.*
FROM sys.dm_exec_sessions des
INNER JOIN sys.dm_exec_connections DEC
ON des.session_id = DEC.session_id
WHERE des.is_user_process = 1
AND status NOT IN ('sleeping') AND dec.session_id<>@@SPID
ORDER BY des.session_id DESC

SELECT
st.text
FROM
sys.dm_exec_requests r
CROSS APPLY
sys.dm_exec_sql_text(sql_handle) AS st
WHERE r.session_id IN (SELECT DISTINCT des.session_id
						FROM sys.dm_exec_sessions des
						INNER JOIN sys.dm_exec_connections DEC
						ON des.session_id = DEC.session_id
						WHERE des.is_user_process = 1  AND dec.session_id<>@@SPID
						AND status NOT IN ('sleeping')
)




EXEC sp_who2;

SELECT * FROM sys.syslockinfo
WHERE req_spid in (SELECT spid
FROM dbo.sysprocesses 
WHERE status NOT IN ('background','sleeping','runnable','suspended') OR SPID = -2
)

EXEC sp_lock;