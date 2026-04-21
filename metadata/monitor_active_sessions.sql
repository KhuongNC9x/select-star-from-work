/* ==============================================================================
   IMPORTANT NOTE: 
   This script is compatible with both SQL Server (On-Premises) and 
   Azure SQL Database (PaaS). 
   It tracks active user sessions and provides performance metrics such as 
   I/O (reads/writes), CPU usage, and memory consumption.
============================================================================== */

SELECT 
    session_id, 
    login_name, 
    [status], 
    host_name, 
    program_name, 
    -- Convert UTC time to Vietnam Local Time (SE Asia Standard Time)
    login_time AT TIME ZONE 'UTC' AT TIME ZONE 'SE Asia Standard Time' 
        AS [LocalLoginTime], 
    last_request_start_time AT TIME ZONE 'UTC' AT TIME ZONE 'SE Asia Standard Time' 
        AS [LocalLastRequestStartTime], 
    last_request_end_time AT TIME ZONE 'UTC' AT TIME ZONE 'SE Asia Standard Time' 
        AS [LocalLastRequestEndTime], 
    reads, 
    writes, 
    cpu_time, -- Measured in milliseconds
    memory_usage * 8 / 1024 AS [MemoryUsageMB] -- Convert pages to Megabytes
FROM 
    sys.dm_exec_sessions
WHERE 
    is_user_process = 1       -- Filter out internal system processes
    AND [status] = 'running'  -- Focus only on active/executing sessions
ORDER BY 
    cpu_time DESC;            -- Sort by highest CPU usage first
GO