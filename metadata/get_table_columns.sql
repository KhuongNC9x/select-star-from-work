SELECT 
    TABLE_CATALOG,      -- The name of the catalog (database) containing the table.
    TABLE_SCHEMA,       -- The name of the schema containing the table.
    TABLE_NAME,         -- The name of the table.
    COLUMN_NAME,        -- The name of the column.
    ORDINAL_POSITION,   -- The column's position in the table (starting at 1).
    COLUMN_DEFAULT,     -- The default value for the column.
    IS_NULLABLE,        -- Whether the column is nullable (YES or NO).
    DATA_TYPE,          -- The data type of the column.
    CHARACTER_MAXIMUM_LENGTH, -- The maximum length for character data types.
    CHARACTER_OCTET_LENGTH,   -- The maximum length in bytes for character data types.
    NUMERIC_PRECISION,  -- The precision of numeric data types.
    NUMERIC_SCALE,      -- The scale of numeric data types.
    DATETIME_PRECISION, -- The precision of datetime data types.
    CHARACTER_SET_NAME, -- The name of the character set for the column.
    COLLATION_NAME      -- The collation of the column.
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'YourTableName'      -- Replace with your table name
    AND TABLE_SCHEMA = 'dbo';         -- Replace with your specific schema (e.g., 'dbo', 'public')