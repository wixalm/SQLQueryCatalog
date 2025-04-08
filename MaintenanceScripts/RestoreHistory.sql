-- Recent database restores (last 30 days)
SELECT 
    rh.destination_database_name,
    rh.restore_date,
    b.backup_finish_date,
    b.backup_start_date,
    b.type AS BackupType,
    b.database_name AS SourceDatabase,
    m.physical_device_name
FROM msdb.dbo.restorehistory rh
JOIN msdb.dbo.backupset b ON rh.backup_set_id = b.backup_set_id
JOIN msdb.dbo.backupmediafamily m ON b.media_set_id = m.media_set_id
WHERE rh.restore_date >= DATEADD(DAY, -30, GETDATE())
ORDER BY rh.restore_date DESC;

-- Count of restores per database
SELECT 
    destination_database_name,
    COUNT(*) AS RestoreCount
FROM msdb.dbo.restorehistory
GROUP BY destination_database_name
ORDER BY RestoreCount DESC;
