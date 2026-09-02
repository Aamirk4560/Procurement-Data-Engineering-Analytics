# Power BI — Procurement Analytics

This section documents the Power BI reporting layer of the Procurement project.

The Power BI layer consumes curated warehouse data and provides interactive procurement analytics for business users.

## Reporting Architecture

```text
Warehouse
    ↓
Semantic Model
    ↓
Power BI
    ↓
Interactive Reports
```

## Key Analytics

The reporting layer includes metrics and analysis such as:

* Total Quantity
* Total Purchase Value
* Total Discount
* Average Discount %
* Average Unit Cost
* Current Month analysis
* Previous Month analysis
* Current Year vs Previous Year
* YTD analysis
* Procurement by Purchase Type
* Top-N analysis
* Item movement analysis

## DAX Concepts

The project demonstrates practical use of:

* `CALCULATE`
* `FILTER`
* `SUM`
* `DIVIDE`
* `VALUES`
* `HASONEVALUE`
* `REMOVEFILTERS`
* `DATEADD`
* `DATESYTD`
* `SUMMARIZE`
* `TOPN`
* Time-intelligence patterns
* Dynamic filter context

## Semantic Model

The reporting model follows a fact/dimension approach.

Example:

```text
                ┌──────────────┐
                │  Dim Date    │
                └──────┬───────┘
                       │
                       │
┌──────────────┐       │       ┌──────────────┐
│  Dim Item    │───────┼───────│ Dim Category │
└──────────────┘       │       └──────────────┘
                       │
                ┌──────▼───────┐
                │ Fact         │
                │ Procurement  │
                └──────────────┘
```

## Security

The production solution included Row-Level Security (RLS) to restrict data according to organizational access rules.

The portfolio repository only documents the implementation approach and does not contain production security mappings or user information.

## Design Principles

The reporting layer focuses on:

* Reusable DAX measures
* Dynamic time intelligence
* Consistent KPI definitions
* Interactive filtering
* Top-N analysis
* Business-friendly visualization
* Secure access to reporting data

## Data Security

This repository contains only sanitized examples.

No production Power BI reports, confidential datasets, credentials, user mappings, or organizational security configurations are included.
