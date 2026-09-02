/*
PSCMD - KPI Queries

```
Purpose:
Demonstrates reporting and procurement KPI calculations.

This is a sanitized portfolio example.
```

*/

/* =========================================================

1. Core procurement KPIs
   ========================================================= */

SELECT
SUM(quantity) AS total_quantity,

```
SUM(purchase_value) AS total_purchase_value,

SUM(discount_value) AS total_discount,

AVG(unit_cost) AS average_unit_cost
```

FROM fact_procurement;

/* =========================================================
2. Average discount percentage
========================================================= */

SELECT
CASE
WHEN SUM(purchase_value) = 0 THEN 0
ELSE
SUM(discount_value) * 100.0
/ SUM(purchase_value)
END AS average_discount_percentage

FROM fact_procurement;

/* =========================================================
3. Procurement value by purchase type
========================================================= */

SELECT
purchase_type,

```
SUM(purchase_value) AS total_purchase_value,

SUM(quantity) AS total_quantity
```

FROM fact_procurement

GROUP BY
purchase_type

ORDER BY
total_purchase_value DESC;

/* =========================================================
4. Percentage contribution by purchase type
========================================================= */

WITH PurchaseTypeSummary AS
(
SELECT
purchase_type,
SUM(purchase_value) AS purchase_value
FROM fact_procurement
GROUP BY purchase_type
)

SELECT
purchase_type,
purchase_value,

```
purchase_value * 100.0
    / NULLIF(SUM(purchase_value) OVER (), 0)
    AS percentage_of_total
```

FROM PurchaseTypeSummary

ORDER BY
purchase_value DESC;

/* =========================================================
5. Monthly procurement trend
========================================================= */

SELECT
YEAR(transaction_date) AS transaction_year,

```
MONTH(transaction_date) AS transaction_month,

SUM(quantity) AS total_quantity,

SUM(purchase_value) AS total_purchase_value,

SUM(discount_value) AS total_discount
```

FROM fact_procurement

GROUP BY
YEAR(transaction_date),
MONTH(transaction_date)

ORDER BY
transaction_year,
transaction_month;

/* =========================================================
6. Top items by procurement value
========================================================= */

SELECT TOP 100
item_id,

```
SUM(purchase_value) AS total_purchase_value,

SUM(quantity) AS total_quantity
```

FROM fact_procurement

GROUP BY
item_id

ORDER BY
total_purchase_value DESC;

/* =========================================================
7. Procurement value by business unit
========================================================= */

SELECT
business_unit,

```
SUM(purchase_value) AS total_purchase_value,

SUM(quantity) AS total_quantity,

COUNT(*) AS transaction_count
```

FROM fact_procurement

GROUP BY
business_unit

ORDER BY
total_purchase_value DESC;
