# Bronze Layer — Data Ingestion

The Bronze layer acts as the initial staging layer for incoming procurement data.

Its primary purpose is to ingest source data and make it available for downstream transformation while retaining the information required for processing and traceability.

## Ingestion Flow

```text
Source Files
     │
     ▼
File Detection / Ingestion
     │
     ▼
Bronze Lakehouse
     │
     ▼
PySpark Transformation
```

## Bronze Layer Responsibilities

The Bronze layer is responsible for:

* Receiving incoming source data
* Staging raw records
* Preserving source information
* Supporting downstream transformations
* Maintaining processing metadata
* Providing input for the Silver layer

## Daily Processing Pattern

The pipeline processes incoming data on a recurring basis.

A simplified flow is:

```text
New Source Data
      │
      ▼
Bronze Load
      │
      ▼
Validation
      │
      ▼
Transformation
      │
      ▼
Silver Processing
```

The Bronze layer can be treated as a short-term staging area, while the Silver layer contains the progressively cleaned and transformed dataset.

## Source File Handling

Incoming files may contain procurement records for different organizational units or processing scopes.

The portfolio implementation intentionally does not reproduce production file names, paths, or source-system identifiers.

## Processing Metadata

Execution metadata can be associated with incoming records to support:

* Processing-time tracking
* Source-file identification
* Incremental processing
* Troubleshooting
* Data lineage

Examples of metadata concepts include:

```text
Execution Timestamp
Source File Key
Business Key
Processing Status
```

## Data Retention

The Bronze layer can be maintained as a short-term staging layer while the transformed Silver layer provides the persistent analytical dataset.

This separation helps keep ingestion and transformation responsibilities independent.

## Design Principle

The Bronze layer should remain focused on **ingestion and staging**.

Business transformations and analytical rules are applied in downstream processing rather than unnecessarily complicating the initial ingestion layer.

## Security

Production source files, internal paths, credentials, server information, and confidential organizational data are intentionally excluded from this portfolio repository.
