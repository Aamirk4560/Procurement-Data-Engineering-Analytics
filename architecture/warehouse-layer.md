# Warehouse / Gold Layer

The Warehouse layer contains curated procurement data prepared for business reporting and analytics.

It sits between the transformed Silver layer and the Power BI semantic model.

## Data Flow

```text
Silver
   │
   ▼
Warehouse / Gold
   │
   ├── Fact Tables
   ├── Dimension Tables
   └── Business Logic
   │
   ▼
Semantic Model
   │
   ▼
Power BI
```

## Warehouse Responsibilities

The warehouse layer provides:

* Reporting-ready datasets
* Fact and dimension structures
* Business calculations
* Consistent KPI definitions
* Analytical relationships
* Data prepared for Power BI

## Fact Tables

Fact tables contain measurable procurement events and metrics.

Typical measures include:

* Quantity
* Purchase value
* Discount value
* Unit cost
* Transaction counts

Example conceptual structure:

```text
Fact_Procurement
-------------------------
business_key
item_id
business_unit
transaction_date
quantity
purchase_value
discount_value
unit_cost
purchase_type
```

## Dimension Tables

Dimension tables provide descriptive attributes used to analyze the facts.

Examples include:

```text
Dim_Item
-------------------------
item_id
item_description
category


Dim_Date
-------------------------
date
year
month
month_name
quarter
```

Dimensions allow users to analyze procurement metrics across different business perspectives.

## Fact-to-Dimension Relationships

The semantic model follows a dimensional modeling approach.

```text
             Dim_Date
                 │
                 │
Dim_Item ─── Fact_Procurement ─── Dim_Category
                 │
                 │
           Dim_BusinessUnit
```

This structure helps separate measurable transactional data from descriptive attributes.

## Business Logic

Business rules can be implemented before or within the reporting layer depending on the requirement.

Examples include:

* Procurement status
* Request matching
* Approval status
* Item movement classification
* KPI calculations
* Organizational filtering

The portfolio repository contains sanitized examples of these patterns.

## Data Preparation for Power BI

The warehouse provides a stable source for the semantic model.

Instead of placing all transformation logic inside Power BI, upstream processing handles data preparation while DAX focuses primarily on analytical calculations and user-driven filter context.

This separation helps improve maintainability and keeps responsibilities clear across the data platform.

## Performance Considerations

The architecture separates:

**Data engineering**

from:

**Business analytics**

Large-scale transformations and data preparation are handled upstream, while Power BI consumes curated datasets designed for reporting.

This reduces unnecessary transformation work inside the visualization layer.

## Security

Production table names, organizational identifiers, credentials, connection details, and confidential business logic are intentionally excluded from this portfolio repository.
