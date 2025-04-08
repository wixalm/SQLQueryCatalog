-- Disk latency by database files
SELECT 
    DB_NAME(vfs.database_id) AS DatabaseName,
    mf.name AS FileLogicalName,
    vfs.io_stall_read_ms / NULLIF(vfs.num_of_reads,0) AS ReadLatencyMs,
    vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes,0) AS WriteLatencyMs
FROM sys.dm_io_virtual_file_stats(NULL, NULL) vfs
JOIN sys.master_files mf ON vfs.database_id = mf.database_id AND vfs.file_id = mf.file_id
ORDER BY ReadLatencyMs DESC;

-- Files with high write latency
SELECT 
    DB_NAME(vfs.database_id) AS DatabaseName,
    mf.physical_name,
    vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes,0) AS WriteLatencyMs
FROM sys.dm_io_virtual_file_stats(NULL, NULL) vfs
JOIN sys.master_files mf ON vfs.database_id = mf.database_id AND vfs.file_id = mf.file_id
ORDER BY WriteLatencyMs DESC;

-- Total IO stats
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    SUM(io_stall_read_ms) AS TotalReadStall,
    SUM(io_stall_write_ms) AS TotalWriteStall
FROM sys.dm_io_virtual_file_stats(NULL, NULL)
GROUP BY database_id
ORDER BY TotalReadStall DESC;
