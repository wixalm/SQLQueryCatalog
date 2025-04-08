-- Row count per data flow component
SELECT 
    execution_id,
    task_name,
    dataflow_path_id_string,
    rows_sent
FROM SSISDB.catalog.execution_data_statistics
ORDER BY rows_sent DESC;

-- Total rows processed by package
SELECT 
    execution_id,
    SUM(rows_sent) AS TotalRows
FROM SSISDB.catalog.execution_data_statistics
GROUP BY execution_id
ORDER BY TotalRows DESC;

-- Top row-producing components
SELECT TOP 10
    task_name,
    rows_sent
FROM SSISDB.catalog.execution_data_statistics
ORDER BY rows_sent DESC;
