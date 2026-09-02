# Data Pipelines

This directory documents the orchestration layer of the procurement data platform.

## Pipeline Architecture

The pipeline coordinates the movement and processing of data across the platform:

Source Files
→ Bronze Ingestion
→ Silver Transformation
→ Warehouse Load
→ Power BI Refresh
→ Monitoring & Notifications

## Pipeline Responsibilities

The orchestration layer is responsible for:

- Source file ingestion
- Pipeline sequencing
- Dependency management
- Notebook execution
- Incremental processing
- Data validation
- Warehouse loading
- Error handling
- Process logging
- Downstream refresh coordination

## Processing Pattern

A typical pipeline follows:

1. Detect or receive source data
2. Load data into the Bronze layer
3. Execute transformation logic
4. Apply incremental processing
5. Load the Warehouse / Gold layer
6. Validate the processed data
7. Refresh downstream reporting
8. Record execution status
9. Trigger notifications when required

## Production Note

The repository contains sanitized documentation and representative implementation patterns. Production connection details, credentials, enterprise endpoints, and proprietary pipeline definitions are intentionally excluded.
