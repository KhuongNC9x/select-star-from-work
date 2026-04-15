/* ==============================================================================
   IMPORTANT NOTE: 
   This script is for SQL Server On-Premises or VMs (IaaS). 
   Do NOT run this script on Azure SQL Database (PaaS). Changing user states 
   (MULTI_USER) and renaming databases behave differently or are restricted in Azure.
============================================================================== */

-- 1. Set the database to Read-Write mode
-- WITH NO_WAIT ensures the command fails immediately if it cannot get an exclusive lock
ALTER DATABASE [Your_Database_Name] 
    SET READ_WRITE 
    WITH NO_WAIT;
GO

-- 2. Set the database to Multi-User mode
ALTER DATABASE [Your_Database_Name] 
    SET MULTI_USER 
    WITH NO_WAIT;
GO

-- 3. Rename the database
-- NOTE: sp_renamedb is deprecated. The modern best practice is ALTER DATABASE ... MODIFY NAME
ALTER DATABASE [Your_Old_Database_Name] 
    MODIFY NAME = [Your_New_Database_Name];
GO