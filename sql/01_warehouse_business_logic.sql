/*
PSCMD - Warehouse Business Logic

```
Purpose:
Demonstrates SQL patterns used to prepare procurement
data for reporting and analytics.

Note:
This is a sanitized portfolio example.
Production table names, identifiers and business data
have been replaced with generic names.
```

*/

/* =========================================================

1. Identify the latest record for each business key
   ========================================================= */

WITH RankedRecords AS
(
SELECT
*,
ROW_NUMBER() OVER
(
PARTITION BY business_key
ORDER BY execution_datetime DESC
) AS record_rank
FROM silver_procurement
)

SELECT
*
FROM RankedRecords
WHERE record_rank = 1;

/* =========================================================
2. Calculate procurement KPIs
========================================================= */

SELECT
business_unit,

```
COUNT(*) AS transaction_count,

SUM(quantity) AS total_quantity,

SUM(purchase_value) AS total_purchase_value,

SUM(discount_value) AS total_discount,

CASE
    WHEN SUM(purchase_value) = 0 THEN 0
    ELSE
        SUM(discount_value) * 100.0
        / SUM(purchase_value)
END AS discount_percentage
```

FROM silver_procurement

GROUP BY
business_unit;

/* =========================================================
3. Classify procurement records using business rules
========================================================= */

SELECT
item_id,
last_transaction_date,

```
CASE
    WHEN last_transaction_date IS NULL
        THEN 'Dead'

    WHEN DATEDIFF
    (
        DAY,
        last_transaction_date,
        GETDATE()
    ) <= 185
        THEN 'Fast Moving'

    WHEN DATEDIFF
    (
        DAY,
        last_transaction_date,
        GETDATE()
    ) > 185
    AND DATEDIFF
    (
        DAY,
        last_transaction_date,
        GETDATE()
    ) < 365
        THEN 'Slow Moving'

    ELSE 'Dead'
END AS movement_status
```

FROM dim_item;

/* =========================================================
4. Detect duplicate business keys
========================================================= */

SELECT
business_key,
COUNT(*) AS duplicate_count

FROM silver_procurement

GROUP BY
business_key

HAVING COUNT(*) > 1;

/* =========================================================
5. Prepare a reporting dataset using joins
========================================================= */

SELECT
F.item_id,
D.item_description,
D.category,
F.business_unit,
F.quantity,
F.purchase_value,
F.transaction_date

FROM fact_procurement AS F

LEFT JOIN dim_item AS D
ON F.item_id = D.item_id;

/* =========================================================
6. Example date-based monthly aggregation
========================================================= */

SELECT
YEAR(transaction_date) AS transaction_year,
MONTH(transaction_date) AS transaction_month,

```
SUM(quantity) AS total_quantity,
SUM(purchase_value) AS total_value
```

FROM fact_procurement

GROUP BY
YEAR(transaction_date),
MONTH(transaction_date)

ORDER BY
transaction_year,
transaction_month;
