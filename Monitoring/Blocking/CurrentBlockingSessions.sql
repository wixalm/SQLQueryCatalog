-- Currently blocked and blocking sessions
SELECT 
    bl.session_id AS BlockedSessionID,
    wt.blocking_session_id AS BlockingSessionID,
    wt.wait_type,
    wt.wait_time,
    wt.wait_resource,
    es.login_name,
    es.host_name,
    es.program_name,
    r.status,
    r.command,
    r.start_time,
    r.cpu_time,
    r.logical_reads
FROM sys.dm_exec_requests r
INNER JOIN sys.dm_os_waiting_tasks wt ON r.session_id = wt.session_id
INNER JOIN sys.dm_exec_sessions es ON r.session_id = es.session_id
INNER JOIN sys.dm_exec_connections con ON es.session_id = con.session_id
INNER JOIN sys.dm_exec_requests bl ON bl.session_id = wt.session_id
WHERE wt.blocking_session_id IS NOT NULL
ORDER BY wait_time DESC;
