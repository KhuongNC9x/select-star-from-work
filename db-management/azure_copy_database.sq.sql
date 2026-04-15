/* ==============================================================================
   IMPORTANT NOTE: 
   This script is EXCLUSIVELY for Azure SQL Database (PaaS). 
   The 'AS COPY OF' syntax is a built-in Azure feature for database duplication.
   It must be executed while connected to the 'master' database of the target server.
============================================================================== */

-- 1. Create a new database by copying an existing one
-- This process is asynchronous and performs a transactionally consistent copy
CREATE DATABASE [Your_New_Database_Name]
AS COPY OF [Your_Source_Database_Name]
(
    -- Specify the service objective (e.g., Elastic Pool or Standalone Tier)
    SERVICE_OBJECTIVE = ELASTIC_POOL(name = [Your_Elastic_Pool_Name])
);
GO

-- 2. Monitor the copying progress
-- Use this view to check if the operation is 'IN_PROGRESS', 'COMPLETED', or 'FAILED'
SELECT 
    major_resource_id AS DatabaseName,
    operation,
    state_desc,
    percent_complete,
    start_time,
    last_modify_time
FROM sys.dm_operation_status 
WHERE operation = 'CREATE DATABASE COPY'
ORDER BY start_time DESC;
GO