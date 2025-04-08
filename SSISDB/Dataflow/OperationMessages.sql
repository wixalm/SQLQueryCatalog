-- Execution messages (info, warning, error)
SELECT 
    operation_id,
    message_time,
    message_type,
    message_source_name,
    message
FROM SSISDB.catalog.operation_messages
ORDER BY message_time DESC;

-- Only warning and error messages
SELECT 
    operation_id,
    message_time,
    message_type,
    message
FROM SSISDB.catalog.operation_messages
WHERE message_type IN (110, 120) -- Warning, Error
ORDER BY message_time DESC;

-- Message counts by type
SELECT 
    message_type,
    COUNT(*) AS MessageCount
FROM SSISDB.catalog.operation_messages
GROUP BY message_type;
