/* ==============================================================================
   IMPORTANT NOTE: 
   This script is compatible with both SQL Server (On-Premises) and 
   Azure SQL Database (PaaS). 
   Note: High fragmentation affects read performance. Using 'LIMITED' mode 
   is recommended for large databases as it is the fastest way to scan indexes.
============================================================================== */

SELECT 
    SCH.[name] AS [SchemaName], 
    TBL.[name] AS [TableName], 
    IDX.[name] AS [IndexName],
    -- The most critical metric: percentage of logical fragmentation
    CAST(IPS.avg_fragmentation_in_percent AS DECIMAL(5, 2)) AS [FragmentationPercent],
    -- Number of data pages in the index
    IPS.page_count AS [PageCount]
FROM 
    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') AS IPS
INNER JOIN 
    sys.tables AS TBL ON TBL.[object_id] = IPS.[object_id]
INNER JOIN 
    sys.schemas AS SCH ON TBL.[schema_id] = SCH.[schema_id]
INNER JOIN 
    sys.indexes AS IDX ON IDX.[object_id] = IPS.[object_id] 
    AND IPS.index_id = IDX.index_id
WHERE 
    IPS.database_id = DB_ID()
    AND IPS.avg_fragmentation_in_percent > 5  -- Filter significant fragmentation
    AND SCH.[name] LIKE '%dbo%'              -- Focus on specific schema
    AND IPS.page_count > 1000                -- Ignore small indexes (not worth rebuilding)
ORDER BY 
    IPS.avg_fragmentation_in_percent DESC;
GO