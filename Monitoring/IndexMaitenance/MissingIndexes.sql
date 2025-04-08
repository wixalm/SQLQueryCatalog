-- Missing index suggestions
SELECT 
    DB_NAME(mid.database_id) AS DatabaseName,
    OBJECT_NAME(mid.object_id, mid.database_id) AS TableName,
    migs.unique_compiles,
    migs.user_seeks,
    migs.user_scans,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns,
    migs.avg_total_user_cost * migs.avg_user_impact AS ImprovementMeasure
FROM sys.dm_db_missing_index_groups mig
JOIN sys.dm_db_missing_index_group_stats migs ON mig.index_group_handle = migs.group_handle
JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
ORDER BY ImprovementMeasure DESC;

-- Top missing indexes by impact
SELECT TOP 10
    migs.user_seeks,
    mid.statement AS TableName,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns
FROM sys.dm_db_missing_index_group_stats migs
JOIN sys.dm_db_missing_index_groups mig ON migs.group_handle = mig.index_group_handle
JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
ORDER BY migs.user_seeks DESC;

-- Count of missing indexes by database
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    COUNT(*) AS MissingIndexCount
FROM sys.dm_db_missing_index_details
GROUP BY database_id
ORDER BY MissingIndexCount DESC;
