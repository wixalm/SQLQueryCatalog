-- Permissions granted to database users
SELECT 
    dp.name AS PrincipalName,
    dp.type_desc AS PrincipalType,
    o.name AS ObjectName,
    p.permission_name,
    p.state_desc AS PermissionState
FROM sys.database_permissions p
JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
LEFT JOIN sys.objects o ON p.major_id = o.object_id
ORDER BY dp.name, o.name;

-- Server-level permissions
SELECT 
    sp.name AS LoginName,
    sp.type_desc,
    slp.permission_name,
    slp.state_desc
FROM sys.server_permissions slp
JOIN sys.server_principals sp ON slp.grantee_principal_id = sp.principal_id
ORDER BY sp.name;

-- Role membership per database
SELECT 
    dp.name AS UserName,
    rp.name AS RoleName
FROM sys.database_role_members drm
JOIN sys.database_principals rp ON drm.role_principal_id = rp.principal_id
JOIN sys.database_principals dp ON drm.member_principal_id = dp.principal_id
ORDER BY dp.name;
