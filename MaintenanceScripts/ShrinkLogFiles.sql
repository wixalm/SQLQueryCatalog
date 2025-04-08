-- Check current log file sizes
SELECT 
    name, type_desc,
    size / 128 AS SizeMB,
    FILEPROPERTY(name, 'SpaceUsed') / 128 AS UsedMB
FROM sys.database_files
WHERE type_desc = 'LOG';

-- Shrink log file (replace with your file name)
USE [YourDatabaseName];
DBCC SHRINKFILE (YourLogFileName_Log, 1024); -- Shrink to 1GB

-- Shrink log after log backup (for FULL recovery)
BACKUP LOG [YourDatabaseName] TO DISK = 'NUL:';
DBCC SHRINKFILE (YourLogFileName_Log, 512); -- Shrink to 512MB
