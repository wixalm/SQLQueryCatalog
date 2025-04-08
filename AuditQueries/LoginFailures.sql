-- Track failed logins
SELECT 
    login_name,
    COUNT(*) AS FailureCount,
    MAX(login_time) AS LastFailedLogin
FROM syslogins
WHERE is_disabled = 0
  AND login_time > DATEADD(HOUR, -24, GETDATE())
GROUP BY login_name
HAVING COUNT(*) > 0
ORDER BY FailureCount DESC;

-- Track failed logins with error messages
SELECT 
    login_name,
    error_number,
    error_message,
    COUNT(*) AS FailureCount
FROM sys.dm_exec_sessions
JOIN sys.dm_exec_connections ON sys.dm_exec_sessions.session_id = sys.dm_exec_connections.session_id
WHERE is_user_process = 1
  AND login_time > DATEADD(HOUR, -24, GETDATE())
GROUP BY login_name, error_number, error_message
HAVING COUNT(*) > 0
ORDER BY FailureCount DESC;
