-- List of all disabled SQL Agent jobs
SELECT 
    name AS JobName,
    description,
    date_created,
    date_modified
FROM msdb.dbo.sysjobs
WHERE enabled = 0
ORDER BY date_modified DESC;

-- Count of enabled vs disabled jobs
SELECT 
    enabled,
    COUNT(*) AS JobCount
FROM msdb.dbo.sysjobs
GROUP BY enabled;

-- Recently disabled jobs (last 30 days)
SELECT 
    name AS JobName,
    description,
    date_modified
FROM msdb.dbo.sysjobs
WHERE enabled = 0 AND date_modified >= DATEADD(DAY, -30, GETDATE())
ORDER BY date_modified DESC;
