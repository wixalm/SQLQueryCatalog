-- Last 20 failed SQL Agent job executions
SELECT TOP 20 
    j.name AS JobName,
    h.run_date,
    h.run_time,
    h.step_name,
    h.sql_severity,
    h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status = 0 -- Failed
ORDER BY h.run_date DESC, h.run_time DESC;

-- Count of failed executions per job (last 30 days)
SELECT 
    j.name AS JobName,
    COUNT(*) AS FailedExecutions
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status = 0
  AND h.run_date >= CONVERT(INT, CONVERT(VARCHAR(8), GETDATE()-30, 112))
GROUP BY j.name
ORDER BY FailedExecutions DESC;

-- Most recent failed step messages
SELECT 
    j.name AS JobName,
    h.step_name,
    h.run_date,
    h.run_time,
    h.message
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status = 0 AND h.step_id > 0
ORDER BY h.run_date DESC, h.run_time DESC;
