-- Failed SQL Agent Jobs (last 7 days)
SELECT 
    j.name AS JobName,
    h.run_status,
    h.run_date,
    h.run_time,
    h.step_name,
    h.message
FROM msdb.dbo.sysjobs j
JOIN msdb.dbo.sysjobhistory h ON j.job_id = h.job_id
WHERE h.run_status = 0 
  AND h.run_date >= CONVERT(INT, CONVERT(VARCHAR(8), GETDATE()-7, 112))
ORDER BY h.run_date DESC, h.run_time DESC;

-- Failed Job Execution Summary
SELECT 
    j.name AS JobName,
    COUNT(*) AS FailedExecutions
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.run_status = 0
GROUP BY j.name
ORDER BY FailedExecutions DESC;
