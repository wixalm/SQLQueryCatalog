-- Environment variables by environment
SELECT 
    env.environment_name,
    ev.variable_name,
    ev.value_type,
    ev.sensitive,
    ev.value
FROM SSISDB.catalog.environments env
JOIN SSISDB.catalog.environment_variables ev ON env.environment_id = ev.environment_id
ORDER BY env.environment_name;

-- Variables assigned to a package
SELECT 
    ev.environment_name,
    ev.variable_name,
    ev.value
FROM SSISDB.catalog.environment_variables ev
JOIN SSISDB.catalog.environment_references er ON ev.environment_id = er.environment_id
WHERE er.project_name = 'YourProjectName';

-- Count of variables per environment
SELECT 
    env.environment_name,
    COUNT(*) AS VariableCount
FROM SSISDB.catalog.environments env
JOIN SSISDB.catalog.environment_variables ev ON env.environment_id = ev.environment_id
GROUP BY env.environment_name;
