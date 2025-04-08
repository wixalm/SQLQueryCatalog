-- Current TempDB file sizes and autogrowth settings
SELECT 
    name,
    size / 128 AS SizeMB,
    max_size,
    growth / 128 AS GrowthMB,
    physical_name
FROM tempdb.sys.database_files
ORDER BY name;

-- TempDB space usage by type
SELECT 
    SUM(user_object_reserved_page_count) * 8 AS UserObjectKB,
    SUM(internal_object_reserved_page_count) * 8 AS InternalObjectKB,
    SUM(version_store_reserved_page_count) * 8 AS VersionStoreKB,
    SUM(unallocated_extent_page_count) * 8 AS FreeSpaceKB
FROM sys.dm_db_file_space_usage;
