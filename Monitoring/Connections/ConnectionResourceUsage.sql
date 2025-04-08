-- Current resource usage by session
SELECT 
    session_id,
    login_name,
    cpu_time,
    memory_usage * 8 AS MemoryKB,
    reads, 
    writes
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
ORDER BY cpu_time DESC;

-- Connections per database
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    COUNT(session_id) AS ConnectionCount
FROM sys.dm_exec_sessions
WHERE database_id <> 0
GROUP BY database_id
ORDER BY ConnectionCount DESC;

-- Blocked connections
SELECT 
    session_id, 
    blocking_session_id, 
    wait_type, 
    wait_time, 
    wait_resource
FROM sys.dm_exec_requests
WHERE blocking_session_id <> 0;
