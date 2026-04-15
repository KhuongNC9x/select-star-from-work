/* ==============================================================================
   IMPORTANT NOTE: 
   This script is designed specifically for SQL Server On-Premises or 
   SQL Server on VMs (IaaS). 
   
   Do NOT run this script on Azure SQL Database (PaaS). Azure SQL does not 
   support the 'USE' statement, 'SINGLE_USER' mode, or direct access to the 
   'msdb' system database.
============================================================================== */

USE master;
GO

-- 1. Close existing connections
-- Switch to Single User mode and terminate all active sessions immediately
ALTER DATABASE [Your_Database_Name] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Drop the database
-- Proceed to remove the database from the server
DROP DATABASE [Your_Database_Name];
GO

-- 3. Optional: Delete backup and restore history (from msdb)
-- Clean up backup/restore history in msdb to prevent system clutter
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'Your_Database_Name';
GO