USE MilesDB


DECLARE @Table varchar(100)
SET @Table = 'Roles'


SELECT 'CREATE TABLE [' + @Table + ']('
UNION ALL
SELECT CONCAT(COLUMN_NAME,' ',DATA_TYPE,
(CASE WHEN DATA_TYPE = 'varchar' AND CHARACTER_MAXIMUM_LENGTH = -1 THEN '(max)'  
WHEN DATA_TYPE = 'varchar' AND CHARACTER_MAXIMUM_LENGTH != -1 THEN '(' + CAST(CHARACTER_MAXIMUM_LENGTH as varchar) + ')'
WHEN DATA_TYPE = 'decimal' THEN ' (' + CAST(NUMERIC_PRECISION as varchar) + ',' + CAST(NUMERIC_SCALE as varchar) + ')'
ELSE '' END),
' ', (CASE WHEN IS_NULLABLE = 'NO' THEN 'NOT NULL' ELSE 'NULL' END), 
(CASE WHEN ORDINAL_POSITION != (SELECT MAX(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = @Table) THEN ',' ELSE '' END))
FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = @Table
UNION ALL
SELECT ');'

SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = @Table
