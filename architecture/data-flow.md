# PSCMD Data Flow

This document describes the end-to-end movement of procurement data through the platform.

## 1. Source Layer

Procurement data originates from source-system extracts and files.

The portfolio implementation represents these sources generically to avoid exposing proprietary system information.

```text
Source Systems / Files
          │
          ▼
```

## 2. Bronze Layer

Raw data is initially loaded into the Bronze layer.

The Bronze layer is used as a staging area and preserves the incoming data before transformation.

Key characteristics:

* Raw/staged data
* Initial ingestion
* Source-file processing
* Temporary staging
* Execution metadata

```text
Source
  │
  ▼
Bronze
```

## 3. Transformation Layer

PySpark transformations are applied to prepare the data for analytical processing.

Typical operations include:

* Duplicate removal
* String cleanup
* Null handling
* Business-key generation
* Data filtering
* Record deduplication
* Business-rule transformations

```text
Bronze
   │
   ▼
PySpark Transformations
   │
   ▼
Cleaned Dataset
```

## 4. Silver Layer

The transformed records are loaded into the Silver layer.

Incremental processing is used so that existing records can be updated while new records are inserted.

```text
                 ┌── Existing Record → Update
                 │
Transformed Data ─┤
                 │
                 └── New Record      → Insert
```

A business key is used to identify matching records.

## 5. Warehouse / Gold Layer

Curated data is made available through the warehouse/reporting layer.

This layer contains reporting-ready structures such as:

* Fact tables
* Dimension tables
* Business logic
* Aggregated metrics

```text
Silver
   │
   ▼
Warehouse
   │
   ├── Fact Tables
   ├── Dimension Tables
   └── Reporting Logic
```

## 6. Power BI Layer

Power BI consumes the curated warehouse data through a semantic model.

The reporting layer provides:

* Procurement KPIs
* Time intelligence
* Top-N analysis
* Item movement analysis
* Interactive filtering
* Row-Level Security

```text
Warehouse
    │
    ▼
Semantic Model
    │
    ▼
Power BI Reports
```

## 7. Monitoring & Automation

Pipeline execution is monitored through process logging.

Relevant execution information can then be used by the automation layer to generate notifications.

```text
ETL Execution
     │
     ▼
Process Log
     │
     ▼
Status Evaluation
     │
     ▼
Email Notification
```

## End-to-End Architecture

```text
┌───────────────────────┐
│   Source Systems      │
│      / Files          │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│        Bronze         │
│    Raw / Staging      │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│   PySpark Processing  │
│ Cleaning / Validation │
│ Business Key / Dedup  │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│        Silver         │
│ Incremental Processing│
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│ Warehouse / Gold      │
│ Facts + Dimensions    │
└───────────┬───────────┘
            │
            ▼
┌───────────────────────┐
│      Power BI         │
│ Semantic Model + DAX  │
└───────────────────────┘

        ┌───────────────────┐
        │ Monitoring &      │
        │ Automation        │
        └───────────────────┘
```

## Security Considerations

Production-specific implementation details are intentionally excluded.

The portfolio focuses on demonstrating the architecture, engineering patterns, and analytical workflow without exposing confidential organizational information.
