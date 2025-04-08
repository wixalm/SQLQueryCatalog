-- Total CPU time used by each session
SELECT 
    session_id, 
    login_name, 
    total_worker_time, 
    total_elapsed_time, 
    cpu_time
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
ORDER BY total_worker_time DESC;

-- Top requests by CPU time
SELECT 
    r.session_id, 
    r.status, 
    r.cpu_time, 
    r.total_elapsed_time, 
    t.text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
ORDER BY r.cpu_time DESC;

-- Historical CPU usage by SQL Server
SELECT 
    record_id,
    DATEADD(mi, -1 * (total_buffer_usage_kb/1024), GETDATE()) AS ApproxTime,
    SQLProcessUtilization,
    SystemIdle,
    100 - SystemIdle - SQLProcessUtilization AS OtherProcesses
FROM sys.dm_os_ring_buffers
WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
AND record_id % 100 = 0;
