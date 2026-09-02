# SQL — Procurement Data Engineering

This section contains sanitized SQL examples demonstrating the warehouse and analytics logic used in the PSCMD project.

The examples are designed to demonstrate practical SQL engineering concepts without exposing proprietary organizational data.

## SQL Responsibilities

The SQL layer supports:

* Warehouse business logic
* Fact and dimension processing
* KPI calculations
* Data validation
* Aggregations
* Window functions
* Incremental data processing
* Procurement analytics
* Reporting preparation

## Key SQL Concepts

Examples in this section demonstrate:

1. Common Table Expressions (CTEs)
2. `JOIN` operations
3. `CASE` expressions
4. Aggregations
5. Window functions
6. Date-based calculations
7. Duplicate detection
8. Business-rule classification
9. Incremental update patterns
10. Reporting-ready datasets

## Example Structure

```text
sql/
├── README.md
├── 01_warehouse_business_logic.sql
├── 02_data_quality_checks.sql
└── 03_kpi_queries.sql
```

## Data Security

All SQL examples are sanitized for portfolio use.

They do not contain:

* Production credentials
* Server names
* Internal connection information
* Proprietary source-system files
* Personally identifiable information
* Confidential organizational data
* Production-only business identifiers

The examples demonstrate the engineering patterns and problem-solving approaches rather than exposing the underlying organization's data.
