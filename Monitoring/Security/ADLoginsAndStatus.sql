-- List all AD-based logins and their status
SELECT 
    name AS LoginName,
    type_desc AS LoginType,
    is_disabled,
    default_database_name,
    create_date,
    modify_date
FROM sys.server_principals
WHERE type IN ('U', 'G')  -- U = Windows Login, G = Windows Group
ORDER BY name;

-- Grouped count of AD vs SQL Logins
SELECT 
    type_desc,
    COUNT(*) AS Count
FROM sys.server_principals
WHERE type IN ('S', 'U', 'G') -- SQL, Windows Login, Windows Group
GROUP BY type_desc;

-- Disabled AD Logins
SELECT 
    name AS DisabledADLogin
FROM sys.server_principals
WHERE type IN ('U', 'G') AND is_disabled = 1;
