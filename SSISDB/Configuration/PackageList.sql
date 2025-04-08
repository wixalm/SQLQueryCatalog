-- All packages per folder/project
SELECT 
    f.folder_name,
    p.project_name,
    pkg.name AS PackageName
FROM SSISDB.catalog.projects p
JOIN SSISDB.catalog.folders f ON p.folder_id = f.folder_id
JOIN SSISDB.catalog.object_parameters pkg ON p.project_id = pkg.project_id
GROUP BY f.folder_name, p.project_name, pkg.name
ORDER BY f.folder_name, p.project_name;

-- List all deployed packages
SELECT 
    project_name,
    package_name
FROM SSISDB.catalog.packages
ORDER BY project_name, package_name;

-- Package count per project
SELECT 
    project_name,
    COUNT(*) AS PackageCount
FROM SSISDB.catalog.packages
GROUP BY project_name
ORDER BY PackageCount DESC;
