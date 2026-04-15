/* ==============================================================================
   IMPORTANT NOTE: 
   This script is for SQL Server On-Premises or VMs. 
   Verify the logical file names using RESTORE FILELISTONLY if the MOVE command fails.
============================================================================== */

USE [master];
GO

-- 1. Check if the database exists and close active connections
IF EXISTS (
    SELECT 1 
    FROM sys.databases 
    WHERE name = 'Your_Database_Name'
)
BEGIN
    -- Set the database to single user mode with rollback immediate to drop connections
    ALTER DATABASE [Your_Database_Name] 
        SET SINGLE_USER 
        WITH ROLLBACK IMMEDIATE;
END
GO

-- 2. Restore the database from backup
RESTORE DATABASE [Your_Database_Name] 
FROM 
    DISK = N'C:\Path\To\Your\Backup_File.bak' 
WITH 
    FILE = 1,  
    -- NOTE: Update the logical file names and destination folder paths accordingly
    MOVE N'Your_Logical_Data_Name' TO N'C:\Path\To\Your\Data_Folder\Your_Database_Name.mdf',  
    MOVE N'Your_Logical_Log_Name'  TO N'C:\Path\To\Your\Log_Folder\Your_Database_Name.ldf', 
    NOUNLOAD,  
    REPLACE,  
    STATS = 5;
GO

-- 3. Set the database back to multi-user mode
ALTER DATABASE [Your_Database_Name] 
    SET MULTI_USER;
GO