-- Parameters and default values per project
SELECT 
    f.folder_name,
    p.project_name,
    op.object_name AS PackageName,
    op.parameter_name,
    op.design_default_value,
    op.sensitive
FROM SSISDB.catalog.object_parameters op
JOIN SSISDB.catalog.projects p ON op.project_id = p.project_id
JOIN SSISDB.catalog.folders f ON p.folder_id = f.folder_id
ORDER BY f.folder_name, p.project_name;

-- List of all parameters
SELECT 
    parameter_name,
    design_default_value,
    required,
    sensitive
FROM SSISDB.catalog.object_parameters
ORDER BY parameter_name;

-- Parameters used in a specific package (replace name)
SELECT 
    parameter_name,
    design_default_value
FROM SSISDB.catalog.object_parameters
WHERE object_name = 'YourPackage.dtsx';
