/* ==============================================================================
   IMPORTANT NOTE: 
   This script is for SQL Server On-Premises or VMs (IaaS). 
   Azure SQL Database handles read/write permissions primarily through 
   service tiers and user roles rather than this specific ALTER DATABASE command.
============================================================================== */

USE [master];
GO

-- Set the database to Read-Write mode
-- This allows the database to accept data modifications (INSERT, UPDATE, DELETE)
ALTER DATABASE [Your_Database_Name]
    SET READ_WRITE;
GO