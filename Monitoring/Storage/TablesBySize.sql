-- Table sizes per schema
SELECT 
    s.name AS SchemaName, 
    t.name AS TableName,
    SUM(a.total_pages) * 8 / 1024 AS TotalSizeMB
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.indexes i ON t.object_id = i.object_id
JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units a ON p.partition_id = a.container_id
GROUP BY s.name, t.name
ORDER BY TotalSizeMB DESC;

-- Top 10 largest tables
SELECT TOP 10 
    t.name AS TableName,
    SUM(p.rows) AS TotalRows,
    SUM(a.total_pages) * 8 / 1024 AS TotalSizeMB
FROM sys.tables t
JOIN sys.indexes i ON t.object_id = i.object_id
JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units a ON p.partition_id = a.container_id
GROUP BY t.name
ORDER BY TotalSizeMB DESC;

-- Row count per table
SELECT 
    t.name AS TableName,
    SUM(p.rows) AS TotalRows
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY t.name
ORDER BY TotalRows DESC;
