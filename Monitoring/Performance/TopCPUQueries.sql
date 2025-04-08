-- Top 10 queries by total CPU time
SELECT TOP 10 
    qs.total_worker_time / 1000 AS CPU_ms,
    qs.execution_count,
    qs.total_worker_time / qs.execution_count AS AvgCPU_ms,
    qt.text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY CPU_ms DESC;

-- Top queries by CPU and logical reads
SELECT TOP 10 
    qs.total_worker_time AS CPUTime, 
    qs.total_logical_reads AS LogicalReads,
    qt.text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY qs.total_worker_time DESC;

-- Highest avg CPU per execution
SELECT TOP 10
    total_worker_time / execution_count AS AvgCPU,
    execution_count,
    qt.text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
WHERE execution_count > 0
ORDER BY AvgCPU DESC;
