/* ==============================================================================
   IMPORTANT NOTE: 
   This script is for SQL Server On-Premises or VMs (IaaS). 
   Do NOT run this script on Azure SQL Database (PaaS). Native 'BACKUP TO DISK' 
   is not supported in Azure SQL as backups are managed automatically.
============================================================================== */

-- Declare variables for database name and file paths
DECLARE @DatabaseName    NVARCHAR(255) = N'Your_Database_Name';
DECLARE @BackupDirectory NVARCHAR(MAX) = N'C:\Path\To\Your\Backup_Folder\';
DECLARE @BackupFile      NVARCHAR(MAX);
DECLARE @BackupCommand   NVARCHAR(MAX);

-- 1. Dynamically construct the full backup file path
SET @BackupFile = @BackupDirectory + @DatabaseName + N'.bak';

-- 2. Prepare the dynamic SQL backup command
SET @BackupCommand = 
    N'BACKUP DATABASE [' + @DatabaseName + N'] 
    TO DISK = ''' + @BackupFile + N''' 
    WITH 
        INIT,        -- Overwrite the backup file if it already exists
        STATS = 5;'; -- Output progress messages every 5 percent

-- 3. Execute the dynamic SQL backup command
EXEC sp_executesql @BackupCommand;