-- TempDB usage per active session
SELECT 
    s.session_id,
    r.status,
    r.command,
    s.login_name,
    s.host_name,
    s.program_name,
    (tus.user_objects_alloc_page_count + tus.internal_objects_alloc_page_count) * 8 AS AllocatedKB,
    (tus.user_objects_dealloc_page_count + tus.internal_objects_dealloc_page_count) * 8 AS DeallocatedKB
FROM sys.dm_db_session_space_usage tus
JOIN sys.dm_exec_sessions s ON tus.session_id = s.session_id
LEFT JOIN sys.dm_exec_requests r ON s.session_id = r.session_id
WHERE s.is_user_process = 1
ORDER BY AllocatedKB DESC;
