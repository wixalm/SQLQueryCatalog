-- Logins with no associated user in current database
SELECT 
    sp.name AS LoginName
FROM sys.server_principals sp
LEFT JOIN sys.database_principals dp ON sp.sid = dp.sid
WHERE sp.type IN ('S', 'U', 'G') -- SQL and Windows logins
  AND dp.sid IS NULL
  AND sp.name NOT LIKE '##%'; -- Exclude system logins

-- Orphaned users in the current database
SELECT 
    dp.name AS OrphanedUser
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.type IN ('S', 'U', 'G') AND sp.sid IS NULL;

-- Count of orphaned users
SELECT 
    COUNT(*) AS OrphanedUsersCount
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.type IN ('S', 'U', 'G') AND sp.sid IS NULL;
