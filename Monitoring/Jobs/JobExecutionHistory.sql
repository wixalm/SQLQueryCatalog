-- Job execution summary with status
SELECT 
    j.name AS JobName,
    h.run_date,
    h.run_time,
    h.step_name,
    h.run_status,
    CASE h.run_status
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Canceled'
        ELSE 'Unknown'
    END AS Status
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.step_id = 0
ORDER BY h.run_date DESC, h.run_time DESC;

-- Count of successes and failures per job
SELECT 
    j.name AS JobName,
    SUM(CASE h.run_status WHEN 1 THEN 1 ELSE 0 END) AS SuccessCount,
    SUM(CASE h.run_status WHEN 0 THEN 1 ELSE 0 END) AS FailureCount
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.step_id = 0
GROUP BY j.name
ORDER BY FailureCount DESC;

-- Average job duration (estimate)
SELECT 
    j.name AS JobName,
    AVG(h.run_duration) AS AvgRunDuration
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
WHERE h.step_id = 0
GROUP BY j.name
ORDER BY AvgRunDuration DESC;
