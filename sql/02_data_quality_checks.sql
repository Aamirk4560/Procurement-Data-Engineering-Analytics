/*
PSCMD - Data Quality Checks

```
Purpose:
Demonstrates SQL validation patterns used to identify
common data-quality issues before reporting.

This is a sanitized portfolio example.
```

*/

/* =========================================================

1. Check for NULL business keys
   ========================================================= */

SELECT
COUNT(*) AS null_business_key_count

FROM silver_procurement

WHERE business_key IS NULL;

/* =========================================================
2. Check for duplicate business keys
========================================================= */

SELECT
business_key,
COUNT(*) AS record_count

FROM silver_procurement

GROUP BY
business_key

HAVING COUNT(*) > 1;

/* =========================================================
3. Check for invalid quantities
========================================================= */

SELECT
COUNT(*) AS invalid_quantity_count

FROM silver_procurement

WHERE quantity IS NULL
OR quantity < 0;

/* =========================================================
4. Check for invalid monetary values
========================================================= */

SELECT
COUNT(*) AS invalid_value_count

FROM silver_procurement

WHERE purchase_value IS NULL
OR purchase_value < 0;

/* =========================================================
5. Check for missing item references
========================================================= */

SELECT
F.item_id,
COUNT(*) AS transaction_count

FROM fact_procurement AS F

LEFT JOIN dim_item AS D
ON F.item_id = D.item_id

WHERE D.item_id IS NULL

GROUP BY
F.item_id;

/* =========================================================
6. Check for future-dated transactions
========================================================= */

SELECT
COUNT(*) AS future_transaction_count

FROM fact_procurement

WHERE transaction_date > CAST(GETDATE() AS DATE);

/* =========================================================
7. Data-quality summary
========================================================= */

SELECT
COUNT(*) AS total_records,

```
SUM
(
    CASE
        WHEN business_key IS NULL THEN 1
        ELSE 0
    END
) AS null_keys,

SUM
(
    CASE
        WHEN quantity IS NULL OR quantity < 0 THEN 1
        ELSE 0
    END
) AS invalid_quantities,

SUM
(
    CASE
        WHEN purchase_value IS NULL OR purchase_value < 0 THEN 1
        ELSE 0
    END
) AS invalid_values
```

FROM silver_procurement;
