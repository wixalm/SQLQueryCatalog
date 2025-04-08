-- Memory used per database
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    COUNT(*) * 8 / 1024 AS MemoryMB
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
ORDER BY MemoryMB DESC;

-- Memory clerk usage
SELECT 
    type, 
    SUM(virtual_memory_committed_kb) AS VMCommitted_KB,
    SUM(virtual_memory_reserved_kb) AS VMReserved_KB
FROM sys.dm_os_memory_clerks
GROUP BY type
ORDER BY VMCommitted_KB DESC;

-- Memory grants pending
SELECT * 
FROM sys.dm_exec_query_memory_grants
WHERE grant_time IS NULL;
