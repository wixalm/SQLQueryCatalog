-- Last 20 package executions
SELECT TOP 20 
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
ORDER BY e.start_time DESC;

-- Executions in the last 24 hours
SELECT 
    e.execution_id,
    e.package_name,
    e.status,
    e.start_time,
    e.end_time
FROM SSISDB.catalog.executions e
WHERE e.start_time >= DATEADD(HOUR, -24, GETDATE())
ORDER BY
