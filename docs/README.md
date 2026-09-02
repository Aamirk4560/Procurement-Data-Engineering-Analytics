# Project Documentation

This directory contains supporting documentation for the Procurement data engineering and analytics project.

## Architecture

| Document                                                  | Description                                                            |
| --------------------------------------------------------- | ---------------------------------------------------------------------- |
| [Data Flow](../architecture/data-flow.md)                 | End-to-end movement of data through the platform                       |
| [Bronze Ingestion](../architecture/bronze-ingestion.md)   | Source ingestion and staging approach                                  |
| [Silver Processing](../architecture/silver-processing.md) | Data cleaning, deduplication, business keys and incremental processing |
| [Warehouse Layer](../architecture/warehouse-layer.md)     | Fact/dimension modeling and reporting preparation                      |

## Analytics

The Power BI documentation covers:

* Core procurement KPIs
* Time intelligence
* Current vs previous year analysis
* YTD analysis
* Top-N analysis
* Item movement classification
* Row-Level Security

See:

```text
../powerbi/
```

## Engineering

The repository also contains examples covering:

* PySpark transformations
* Delta incremental processing
* SQL warehouse logic
* Data-quality checks
* KPI queries
* ETL monitoring
* Automated notifications

## Repository Philosophy

The project is structured to demonstrate the complete lifecycle of an analytics data platform:

```text
Ingest
  ↓
Transform
  ↓
Validate
  ↓
Incrementally Load
  ↓
Model
  ↓
Analyze
  ↓
Secure
  ↓
Monitor
  ↓
Automate
```

The implementation examples are intentionally sanitized for public portfolio use.

No production credentials, confidential datasets, internal infrastructure details, or personally identifiable information are included.
