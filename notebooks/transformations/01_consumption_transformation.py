from pyspark.sql import functions as F
from pyspark.sql.window import Window

# ============================================================

# PSCMD - Consumption Data Transformation

# ============================================================

#

# Portfolio / sanitized implementation

#

# Purpose:

# Transform procurement consumption data from the Bronze

# layer into a cleansed and deduplicated Silver dataset.

#

# Technologies:

# Microsoft Fabric

# PySpark

# Delta Lake

#

# ============================================================

def transform_consumption(df):
"""
Transform and prepare consumption data for the Silver layer.

```
Processing includes:
    1. Basic data cleansing
    2. Data standardization
    3. Business-key generation
    4. Duplicate detection
    5. Record deduplication

Parameters
----------
df : pyspark.sql.DataFrame
    Bronze consumption dataset.

Returns
-------
pyspark.sql.DataFrame
    Transformed Silver-ready dataset.
"""

# ========================================================
# 1. Basic Data Cleansing
# ========================================================

df = df.dropDuplicates()

# Standardize string columns where applicable.
string_columns = [
    "item_id",
    "business_unit",
    "dept_id",
    "project",
    "program"
]

for column_name in string_columns:
    if column_name in df.columns:
        df = df.withColumn(
            column_name,
            F.trim(F.col(column_name))
        )


# ========================================================
# 2. Handle Null / Empty Business Identifiers
# ========================================================

for column_name in string_columns:
    if column_name in df.columns:
        df = df.withColumn(
            column_name,
            F.when(
                F.col(column_name).isNull(),
                ""
            ).otherwise(F.col(column_name))
        )


# ========================================================
# 3. Generate Business Hash Key
# ========================================================

# Business columns used to identify logically equivalent
# consumption records.

business_columns = [
    "item_id",
    "business_unit",
    "dept_id",
    "project",
    "program"
]

available_business_columns = [
    column_name
    for column_name in business_columns
    if column_name in df.columns
]

if available_business_columns:

    df = df.withColumn(
        "business_key",
        F.md5(
            F.concat_ws(
                "||",
                *[
                    F.coalesce(
                        F.col(column_name).cast("string"),
                        F.lit("")
                    )
                    for column_name in available_business_columns
                ]
            )
        )
    )


# ========================================================
# 4. Remove Invalid / Unwanted Records
# ========================================================

# Example portfolio rule.
#
# Production-specific filtering rules should be maintained
# according to the organization's business requirements.

if all(
    column_name in df.columns
    for column_name in [
        "business_unit",
        "dept_id",
        "project",
        "program"
    ]
):

    df = df.filter(
        ~(
            (F.col("business_unit") == "EXAMPLE_UNIT")
            & (F.col("dept_id") == "00000")
            & (F.col("project") == "00000")
            & (F.col("program") == "0000")
        )
    )


# ========================================================
# 5. Deduplicate Using Latest Processing Record
# ========================================================

if "business_key" in df.columns and "EXEC_DTT" in df.columns:

    window_spec = (
        Window
        .partitionBy("business_key")
        .orderBy(
            F.col("EXEC_DTT").desc()
        )
    )

    df = (
        df
        .withColumn(
            "row_number",
            F.row_number().over(window_spec)
        )
        .filter(F.col("row_number") == 1)
        .drop("row_number")
    )


# ========================================================
# 6. Final Data Quality Check
# ========================================================

if "item_id" in df.columns:

    df = df.filter(
        F.col("item_id").isNotNull()
    )


return df
```

# ============================================================

# Example Usage

# ============================================================

# bronze_df = spark.read.format("delta").table(

# "bronze_consumption"

# )

# silver_df = transform_consumption(bronze_df)

# silver_df.write \

# .format("delta") \

# .mode("append") \

# .saveAsTable("silver_consumption")
