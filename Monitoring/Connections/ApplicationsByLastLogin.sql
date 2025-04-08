-- Applications and their last login time
SELECT 
    login_name,
    program_name,
    MAX(connect_time) AS LastConnectTime
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
GROUP BY login_name, program_name
ORDER BY LastConnectTime DESC;

-- Count connections by application
SELECT 
    program_name,
    COUNT(*) AS ConnectionCount
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
GROUP BY program_name
ORDER BY ConnectionCount DESC;

-- Applications used by each login
SELECT DISTINCT
    login_name,
    program_name
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
ORDER BY login_name, program_name;
