-- Audit data changes in a specific table (e.g., Employee)
SELECT 
    et.name AS TableName,
    c.name AS ColumnName,
    d.audit_action AS ActionType,
    d.audit_date AS ActionDate,
    d.user_name AS ChangedBy
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.dm_audit_actions d ON c.column_id = d.column_id
WHERE t.name = 'Employee' AND d.audit_action IN ('INSERT', 'UPDATE', 'DELETE')
ORDER BY d.audit_date DESC;

-- Tracking DDL changes (e.g., CREATE, ALTER, DROP)
SELECT 
    event_time,
    database_name,
    schema_name,
    object_name,
    event_class,
    login_name,
    object_type
FROM sys.fn_xe_file_target_read_file('audit_data*.xel', NULL, NULL, NULL)
WHERE event_class IN (46, 47, 48) -- DDL Event Classes
ORDER BY event_time DESC;
