-- Failed package executions with basic info
SELECT 
    e.execution_id,
    f.folder_name,
    p.project_name,
    e.package_name,
    e.status,
    e.start_time,
    e.end_time,
    DATEDIFF(SECOND, e.start_time, e.end_time) AS DurationSeconds
FROM SSISDB.catalog.executions e
JOIN SSISDB.catalog.projects p ON e.project_id = p.project_id
JOIN SSISDB.catalog.folders f ON p.folder_id = f.folder_id
WHERE e.status = 4 -- Failed
ORDER BY e.start_time DESC;

-- Failed executions in the last 7 days
SELECT 
    execution_id,
    package_name,
    start_time,
    end_time
FROM SSISDB.catalog.executions
WHERE status = 4 AND start_time >= DATEADD(DAY, -7, GETDATE());

-- Execution errors from operation messages
SELECT 
    operation_id,
    message_time,
    message
FROM SSISDB.catalog.operation_messages
WHERE message_type = 120 -- Error
ORDER BY message_time DESC;
