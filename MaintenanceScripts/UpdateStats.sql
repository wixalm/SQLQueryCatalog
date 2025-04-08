-- Update statistics for all user tables in the current database
EXEC sp_msforeachtable 'UPDATE STATISTICS ? WITH FULLSCAN';

-- Update stats with sample for large environments
EXEC sp_msforeachtable 'UPDATE STATISTICS ? WITH SAMPLE 50 PERCENT';

-- Update statistics for a specific schema (e.g., dbo)
DECLARE @SQL NVARCHAR(MAX) = N'';
SELECT @SQL += 'UPDATE STATISTICS [' + s.name + '].[' + t.name + '];' + CHAR(13)
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo';
EXEC sp_executesql @SQL;
