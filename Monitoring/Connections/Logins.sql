--============= Select SQL Server LOGINS ==================
SELECT
    name AS LoginName,
    type_desc AS LoginType,
    CASE
        WHEN type IN ('U', 'G') THEN 'Yes'  -- U = Windows Login, G = Windows Group
        ELSE 'No'
    END AS IsADLogin
FROM sys.server_principals
WHERE type IN ('S', 'U', 'G')  -- S = SQL Login, U = Windows Login, G = Windows Group
ORDER BY name;

--============= List all Server Role Memberships ==================

SELECT 
    sp1.name AS LoginName,
    sp2.name AS ServerRole
FROM sys.server_role_members rm
JOIN sys.server_principals sp1 ON rm.member_principal_id = sp1.principal_id
JOIN sys.server_principals sp2 ON rm.role_principal_id = sp2.principal_id
ORDER BY sp2.name, sp1.name;


--============= List Users in a Specific Database and Their Login Mapping ==================
SELECT 
    dp.name AS UserName,
    dp.type_desc AS UserType,
    dp.authentication_type_desc AS AuthType,
    sp.name AS LoginName
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.type IN ('S', 'U', 'G')  -- SQL user, Windows user/group
AND dp.name NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA', 'sys')
ORDER BY dp.name;


--============= List Database Role Memberships ==================
SELECT 
    dp1.name AS DatabaseUser,
    dp2.name AS DatabaseRole
FROM sys.database_role_members rm
JOIN sys.database_principals dp1 ON rm.member_principal_id = dp1.principal_id
JOIN sys.database_principals dp2 ON rm.role_principal_id = dp2.principal_id
ORDER BY dp2.name, dp1.name;


--============= Find Orphaned Users (Users without Login) ==================
SELECT 
    name AS OrphanedUser
FROM sys.database_principals
WHERE type IN ('S', 'U', 'G')
AND authentication_type_desc = 'INSTANCE'
AND sid NOT IN (SELECT sid FROM sys.server_principals)
AND name NOT IN ('guest', 'dbo', 'INFORMATION_SCHEMA', 'sys');

-- Fix
-- Replace with actual login and username
EXEC sp_change_users_login 'Auto_Fix', 'username', null, 'password';

-- SQL Server 2012+
ALTER USER [username] WITH LOGIN = [loginname];


--============= Create User Template ==================
-- Server level
CREATE LOGIN MyLogin WITH PASSWORD = 'StrongPassword123!';

-- Database level (inside target database)
CREATE USER MyLogin FOR LOGIN MyLogin;
ALTER ROLE db_datareader ADD MEMBER MyLogin;
ALTER ROLE db_datawriter ADD MEMBER MyLogin;


--============= List Permissions Granted to a Login or User ==================
-- Server-level permissions
SELECT * 
FROM sys.server_permissions p
JOIN sys.server_principals sp ON p.grantee_principal_id = sp.principal_id
WHERE sp.name = 'LoginName';

-- Database-level (run inside DB)
SELECT 
    dp.name AS Principal,
    dp.type_desc,
    perm.permission_name,
    perm.state_desc,
    perm.class_desc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp ON perm.grantee_principal_id = dp.principal_id
WHERE dp.name = 'UserName';


--=============  Check for Logins with Elevated Permissions (sysadmin, securityadmin, etc.) ==================
SELECT 
    sp.name AS LoginName,
    sp.type_desc,
    sp.is_disabled,
    slr.name AS ServerRole
FROM sys.server_principals sp
JOIN sys.server_role_members srm ON sp.principal_id = srm.member_principal_id
JOIN sys.server_principals slr ON srm.role_principal_id = slr.principal_id
WHERE slr.name IN ('sysadmin', 'securityadmin', 'serveradmin')
ORDER BY slr.name, sp.name;


--============= Find Logins Without Password Policies Enforced ==================
SELECT 
    name,
    is_policy_checked,
    is_expiration_checked
FROM sys.sql_logins
WHERE is_policy_checked = 0 OR is_expiration_checked = 0;


--============= Check Last Login Time (if Audit is Enabled) ==================
SELECT 
    login_name, 
    connect_time, 
    auth_scheme
FROM sys.dm_exec_sessions
WHERE is_user_process = 1;


--============= Logins Mapped to Multiple Databases ==================
EXEC sp_MSforeachdb '
USE [?];
SELECT 
    DB_NAME() AS DatabaseName, 
    dp.name AS DatabaseUser, 
    sp.name AS MappedLogin
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.sid IS NOT NULL
AND dp.type IN (''S'', ''U'', ''G'')
AND dp.name NOT IN (''guest'', ''dbo'', ''INFORMATION_SCHEMA'', ''sys'');';


--============= Transfer Logins Between Servers (With SID) ==================
-- Generate script to recreate SQL logins with same SID and password
EXEC sp_help_revlogin;


--============= Find Logins that Haven’t Been Used Recently ==================
-- Check audit logs for login success
SELECT * FROM fn_get_audit_file('C:\Audit\*.sqlaudit', DEFAULT, DEFAULT)
WHERE action_id = 'LGIS';  -- Login Successful

--============= Find Logins with CONTROL SERVER or IMPERSONATE Rights ==================
SELECT 
    sp.name AS LoginName,
    perm.permission_name,
    perm.state_desc
FROM sys.server_permissions perm
JOIN sys.server_principals sp ON perm.grantee_principal_id = sp.principal_id
WHERE perm.permission_name IN ('CONTROL SERVER', 'IMPERSONATE');