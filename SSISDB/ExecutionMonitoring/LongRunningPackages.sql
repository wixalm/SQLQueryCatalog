-- Executions that ran over 5 minutes
SELECT 
    execution_id,
    package_name,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS DurationSeconds
FROM SSISDB.catalog.executions
WHERE DATEDIFF(SECOND, start_time, end_time) > 300
ORDER BY DurationSeconds DESC;

-- Top 10 longest executions
SELECT TOP 10
    execution_id,
    package_name,
    start_time,
    end_time,
    DATEDIFF(SECOND, start_time, end_time) AS DurationSeconds
FROM SSISDB.catalog.executions
ORDER BY DurationSeconds DESC;

-- Average execution time per package
SELECT 
    package_name,
    AVG(DATEDIFF(SECOND, start_time, end_time)) AS AvgDurationSeconds
FROM SSISDB.catalog.executions
GROUP BY package_name
ORDER BY AvgDurationSeconds DESC;
