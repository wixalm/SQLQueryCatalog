# SQL Query Catalog for SQL Server 2017

This catalog contains useful SQL queries for monitoring, auditing, and maintaining SQL Server 2017 databases. The queries are organized into specific categories to help DBAs perform essential tasks efficiently.

## Table of Contents

- [Monitoring Queries](#monitoring-queries)
  - [Performance](#performance)
  - [Storage](#storage)
  - [Connections](#connections)
  - [Index Maintenance](#index-maintenance)
  - [Jobs](#jobs)
  - [Blocking](#blocking)
  - [TempDB](#tempdb)
- [Maintenance Scripts](#maintenance-scripts)
  - [Update Stats](#update-stats)
  - [Check Database Integrity](#check-database-integrity)
  - [Shrink Log Files](#shrink-log-files)
  - [Backup Status](#backup-status)
  - [Restore History](#restore-history)
- [Audit Queries](#audit-queries)
  - [Login Failures](#login-failures)
  - [Data Change Audit](#data-change-audit)
  - [Failed Jobs Audit](#failed-jobs-audit)

---

## Monitoring Queries

### Performance

- **`CPUConsumption.sql`** – Tracks CPU usage and identifies sessions using excessive CPU.
- **`TopCPUQueries.sql`** – Displays the queries consuming the most CPU resources.
- **`MemoryByDatabase.sql`** – Shows memory usage per database.

### Storage

- **`TablesBySize.sql`** – Lists tables ordered by their size.
- **`FilegroupConsumption.sql`** – Displays filegroup storage usage.
- **`FileLatency.sql`** – Measures file latency for each data file.

### Connections

- **`ApplicationsByLastLogin.sql`** – Displays applications that logged into the database recently.
- **`ConnectionResourceUsage.sql`** – Shows resource usage by each connection.

### Index Maintenance

- **`MissingIndexes.sql`** – Lists missing indexes that could improve query performance.
- **`IndexFragmentation.sql`** – Identifies fragmented indexes.

### Jobs

- **`FailedAgentJobs.sql`** – Lists failed SQL Agent jobs.
- **`JobExecutionHistory.sql`** – Displays job execution history.
- **`DisabledJobs.sql`** – Shows SQL Agent jobs that are disabled.

### Blocking

- **`CurrentBlockingSessions.sql`** – Shows currently blocked and blocking sessions.
- **`BlockingTree.sql`** – Displays the blocking chain (hierarchy).
- **`BlockingDetailsWithSQL.sql`** – Provides blocking session details along with the SQL text causing the block.

### TempDB

- **`TempDBUsageBySession.sql`** – Displays TempDB usage per active session.
- **`TempDBFilesGrowth.sql`** – Tracks TempDB file size and autogrowth settings.
- **`TempDBContention.sql`** – Identifies TempDB page contention issues.

---

## Maintenance Scripts

### Update Stats

- **`UpdateStats.sql`** – Updates statistics for all user tables or a specific schema.

### Check Database Integrity

- **`CheckDBIntegrity.sql`** – Runs DBCC CHECKDB to check database integrity.

### Shrink Log Files

- **`ShrinkLogFiles.sql`** – Shrinks the transaction log files to free space.

### Backup Status

- **`BackupStatus.sql`** – Displays the status of the last full, differential, and log backups.

### Restore History

- **`RestoreHistory.sql`** – Tracks restore history and provides restore details.

---

## Audit Queries

### Login Failures

- **`LoginFailures.sql`** – Tracks failed logins and failed login attempts over the past 24 hours.

### Data Change Audit

- **`DataChangeAudit.sql`** – Audits data changes on specific tables or tracks DDL changes.

### Failed Jobs Audit

- **`FailedJobsAudit.sql`** – Tracks failed SQL Agent job executions over the past 7 days.

---

## How to Use

1. **Access the Scripts**: Navigate to the respective folder in the SQL Query Catalog for the query you need.
2. **Run the Queries**: You can run these queries directly in SQL Server Management Studio (SSMS).
3. **Modify as Needed**: Modify the queries for your specific database environment, such as changing database names or specifying different tables.

---

## Contribution

Feel free to contribute to this catalog by submitting additional queries, improvements, or enhancements via a pull request.
