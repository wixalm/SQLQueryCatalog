-- Detecting TempDB page contention (PFS, GAM, SGAM)
SELECT 
    database_id,
    file_id,
    page_id,
    COUNT(*) AS ContentionCount,
    wait_type
FROM sys.dm_os_waiting_tasks
WHERE wait_type LIKE 'PAGELATCH_%'
  AND resource_description LIKE '2:%' -- File ID 2 is TempDB
GROUP BY database_id, file_id, page_id, wait_type
ORDER BY ContentionCount DESC;
