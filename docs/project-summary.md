# PSCMD — Project Summary

## Overview

PSCMD is an end-to-end procurement data engineering and analytics solution designed to transform source procurement data into reliable, reporting-ready information.

The solution combines data engineering, warehouse modeling, business logic, analytics, security, monitoring, and automation.

## Problem

Procurement data requires multiple processing stages before it can be reliably used for business analysis.

Key challenges addressed by the solution include:

* Raw source-data ingestion
* Data cleansing
* Duplicate records
* Incremental data processing
* Business-rule implementation
* Reporting data preparation
* KPI calculation
* Access control
* ETL monitoring
* Automated notifications

## Solution

The platform follows a layered architecture:

```text id="7j4n9s"
Source
  ↓
Bronze
  ↓
PySpark Transformation
  ↓
Silver
  ↓
Warehouse / Gold
  ↓
Power BI
```

Supporting services provide:

```text id="v6x0df"
Monitoring
    +
Automation
    +
Security
```

## Technology Stack

| Area            | Technology            |
| --------------- | --------------------- |
| Data Platform   | Microsoft Fabric      |
| Storage         | OneLake / Lakehouse   |
| Processing      | PySpark               |
| Querying        | SQL                   |
| Warehouse       | Fabric Data Warehouse |
| Analytics       | Power BI              |
| BI Calculations | DAX                   |
| Automation      | Power Automate        |
| Version Control | Git / GitHub          |

## Engineering Highlights

### Data Engineering

* Layered Bronze/Silver/Warehouse architecture
* PySpark-based transformations
* Business-key generation
* Deduplication using window functions
* Incremental Delta processing
* Data-quality validation

### Analytics

* Procurement KPI development
* Time-intelligence calculations
* YTD analysis
* Current vs previous year comparisons
* Dynamic Top-N analysis
* Item movement classification

### Security

* Mapping-based Row-Level Security
* Dynamic user filtering
* Controlled access to organizational data

### Operations

* ETL process logging
* Pipeline execution monitoring
* Automated email notifications
* Error/status communication

## Key Engineering Principles

The project emphasizes:

1. Separation of ingestion and transformation
2. Incremental processing instead of unnecessary full reloads
3. Reusable business logic
4. Data-quality validation
5. Secure analytical access
6. Operational visibility
7. Automation of repetitive monitoring tasks

## Portfolio Version

This GitHub repository is a sanitized representation of the project.

Production-specific information has intentionally been removed, including:

* Confidential datasets
* Internal server information
* Credentials
* Production file paths
* User/security mappings
* Personally identifiable information
* Proprietary organizational identifiers

The purpose of this repository is to demonstrate the engineering architecture, implementation patterns, and analytical capabilities of the solution.
