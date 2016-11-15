/* Get table creation and modification dates */
SELECT
	[name],
	create_date,
	modify_date

FROM
	sys.tables

/* Reset Auto-Index on a specific table */
/* NOTE: Remove all items from the table
   before doing this because it doesn't
   change the indices of the current items */
DBCC CHECKIDENT ("YourTableNameHere", RESEED, 0);

/* Remove duplicate entries from a table */
WITH cte
	AS (SELECT ROW_NUMBER() OVER (PARTITION BY ServiceId, ChargeTypeId ORDER BY ( SELECT 0)) RN
        FROM   UtilityServices.dbo.ServiceChargeType)
DELETE FROM cte
WHERE  RN > 1;