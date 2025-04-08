-- Blocking chain (blocking hierarchy)
WITH BlockingTree AS (
    SELECT 
        session_id,
        blocking_session_id,
        wait_type,
        wait_time,
        CAST(session_id AS VARCHAR(MAX)) AS BlockPath
    FROM sys.dm_exec_requests
    WHERE blocking_session_id = 0

    UNION ALL

    SELECT 
        r.session_id,
        r.blocking_session_id,
        r.wait_type,
        r.wait_time,
        CAST(bt.BlockPath + ' -> ' + CAST(r.session_id AS VARCHAR) AS VARCHAR(MAX))
    FROM sys.dm_exec_requests r
    JOIN BlockingTree bt ON r.blocking_session_id = bt.session_id
)
SELECT 
    session_id,
    blocking_session_id,
    wait_type,
    wait_time,
    BlockPath
FROM BlockingTree
ORDER BY BlockPath;
