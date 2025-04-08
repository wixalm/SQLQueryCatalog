-- Blocking sessions with SQL text and wait info
SELECT 
    bl.session_id AS BlockedSession,
    wt.blocking_session_id AS BlockingSession,
    es.login_name,
    es.host_name,
    es.program_name,
    r.wait_type,
    r.wait_resource,
    r.wait_time,
    SUBSTRING(t.text, r.statement_start_offset / 2,
              (CASE 
                   WHEN r.statement_end_offset = -1 
                   THEN LEN(CONVERT(NVARCHAR(MAX), t.text)) * 2 
                   ELSE r.statement_end_offset 
               END - r.statement_start_offset) / 2) AS RunningSQL
FROM sys.dm_exec_requests r
JOIN sys.dm_os_waiting_tasks wt ON r.session_id = wt.session_id
JOIN sys.dm_exec_sessions es ON r.session_id = es.session_id
JOIN sys.dm_exec_connections con ON es.session_id = con.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
JOIN sys.dm_exec_requests bl ON bl.session_id = wt.session_id
WHERE wt.blocking_session_id IS NOT NULL
ORDER BY r.wait_time DESC;
