-- Space used per filegroup
SELECT 
    fg.name AS FilegroupName,
    SUM(size) * 8 / 1024 AS SizeMB
FROM sys.filegroups fg
JOIN sys.master_files mf ON fg.data_space_id = mf.data_space_id
GROUP BY fg.name;

-- Data files per filegroup
SELECT 
    fg.name AS Filegroup,
    mf.name AS FileName,
    mf.physical_name,
    mf.size * 8 / 1024 AS SizeMB
FROM sys.master_files mf
JOIN sys.filegroups fg ON mf.data_space_id = fg.data_space_id
ORDER BY fg.name;

-- Filegroup file count
SELECT 
    fg.name,
    COUNT(*) AS FileCount
FROM sys.filegroups fg
JOIN sys.database_files df ON fg.data_space_id = df.data_space_id
GROUP BY fg.name;
