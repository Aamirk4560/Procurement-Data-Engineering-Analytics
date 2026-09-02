# Silver Layer — Transformation & Incremental Processing

The Silver layer contains cleaned and transformed procurement data prepared for downstream warehouse and analytics processing.

The transformation process is implemented using PySpark and follows a structured approach to data quality, record identification, and incremental processing.

## Processing Flow

```text
Bronze
   │
   ▼
Data Cleaning
   │
   ▼
Business Key Generation
   │
   ▼
Deduplication
   │
   ▼
Business Rules
   │
   ▼
Incremental MERGE
   │
   ▼
Silver
```

## 1. Data Cleaning

Incoming records are standardized before being loaded into the Silver layer.

Typical operations include:

* Removing duplicate rows
* Trimming string values
* Handling null values
* Standardizing fields
* Filtering invalid records

This creates a more consistent dataset for downstream processing.

## 2. Business Key Generation

A deterministic business key can be generated from relevant business attributes.

A hash-based approach is useful when a natural single-column key is not available.

Conceptually:

```text id="0p4jfh"
Business Attributes
        │
        ▼
Concatenate Relevant Values
        │
        ▼
Hash Function
        │
        ▼
Business Key
```

The business key provides a consistent identifier for comparing incoming records with existing Silver records.

## 3. Deduplication

Multiple records representing the same business entity can occur during ingestion.

A window function can be used to retain the latest version:

```python id="0f1r5j"
window = (
    Window
    .partitionBy("business_key")
    .orderBy(
        F.col("execution_datetime").desc()
    )
)
```

Records can then be ranked and only the latest record retained.

This prevents duplicate versions from unnecessarily propagating into downstream layers.

## 4. Incremental Processing

Rather than rebuilding the entire Silver dataset for every execution, the pipeline can process incoming records incrementally.

The business key is used to determine whether a record already exists.

```text id="c4h5v6"
Incoming Record
      │
      ▼
Compare Business Key
      │
 ┌────┴────┐
 │         │
Match    No Match
 │         │
 ▼         ▼
Update    Insert
```

This approach reduces unnecessary processing and supports recurring data loads.

## 5. Delta MERGE Pattern

A Delta table can be updated using a MERGE operation.

Conceptually:

```sql id="qg8g0r"
MERGE INTO silver_table AS target
USING transformed_data AS source
    ON target.business_key = source.business_key

WHEN MATCHED THEN
    UPDATE SET *

WHEN NOT MATCHED THEN
    INSERT *;
```

The repository contains a sanitized PySpark implementation of this pattern in:

```text id="6h34m5"
notebooks/transformations/02_incremental_processing.py
```

## 6. Business Rules

Transformation logic can also apply domain-specific rules to classify or filter records.

Examples include:

* Organizational filtering
* Procurement status logic
* Item movement classification
* Data validity rules
* Reporting-specific attributes

Production-specific rules and identifiers are intentionally sanitized in this repository.

## 7. Why the Silver Layer Matters

The Silver layer provides a reliable foundation between raw ingestion and analytical reporting.

It separates:

**Ingestion concerns**

from:

**Transformation and business logic**

This makes the overall data platform easier to maintain, troubleshoot, and extend.

## Security

Production data, internal table names, source-system identifiers, credentials, server information, and confidential business rules are excluded from this portfolio repository.
