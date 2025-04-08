-- Check database integrity (lightweight)
DBCC CHECKDB WITH PHYSICAL_ONLY;

-- Full integrity check (may take longer)
DBCC CHECKDB;

-- Run on specific database
DECLARE @dbname SYSNAME = 'YourDatabaseName';
EXEC('DBCC CHECKDB([' + @dbname + ']) WITH NO_INFOMSGS, ALL_ERRORMSGS');
