/* ==============================================================================
   IMPORTANT NOTE: 
   This script is compatible with both SQL Server (On-Premises) and 
   Azure SQL Database (PaaS). 
   The FORMAT() function is used for better readability of large numbers.
============================================================================== */

SELECT 
    SCH.name + '.' + OBJ.name AS [TableName],
    -- Convert page count to Gigabytes (GB) with 2 decimal places
    CAST(SUM(PART.reserved_page_count) * 8.0 / 1024 / 1024 AS DECIMAL(18, 2)) AS [SizeInGB],
    -- Format total rows with thousand separators (e.g., 1,234,567)
    FORMAT(SUM(CASE 
                   WHEN PART.index_id IN (0, 1) THEN PART.row_count 
                   ELSE 0 
               END), '#,0') AS [TotalRows]
FROM 
    sys.dm_db_partition_stats AS PART
INNER JOIN 
    sys.objects AS OBJ ON OBJ.object_id = PART.object_id
INNER JOIN 
    sys.schemas AS SCH ON SCH.schema_id = OBJ.schema_id
GROUP BY 
    SCH.name, 
    OBJ.name
ORDER BY 
    SUM(PART.reserved_page_count) DESC; -- Sort by physical size
GO