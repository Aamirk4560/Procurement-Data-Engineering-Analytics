from pyspark.sql import functions as F
from delta.tables import DeltaTable

# ============================================================

# PSCMD - Incremental Processing

# ============================================================

#

# Portfolio / sanitized implementation

#

# Purpose:

# Demonstrate an incremental Bronze -> Silver processing

# pattern using Delta Lake MERGE.

#

# ============================================================

def incremental_merge(
spark,
source_df,
target_table,
merge_key="business_key"
):
"""
Merge new and changed records from a source DataFrame
into an existing Delta target table.

```
Parameters
----------
spark : SparkSession
    Active Spark session.

source_df : pyspark.sql.DataFrame
    Newly processed source records.

target_table : str
    Target Delta table name.

merge_key : str
    Column used to identify matching records.
"""

# ========================================================
# 1. Validate Required Key
# ========================================================

if merge_key not in source_df.columns:
    raise ValueError(
        f"Required merge key '{merge_key}' was not found."
    )


# ========================================================
# 2. Remove Duplicate Source Records
# ========================================================

source_df = (
    source_df
    .dropDuplicates([merge_key])
)


# ========================================================
# 3. Access Target Delta Table
# ========================================================

target = DeltaTable.forName(
    spark,
    target_table
)


# ========================================================
# 4. MERGE Source Into Target
# ========================================================

(
    target.alias("target")
    .merge(
        source_df.alias("source"),
        f"target.{merge_key} = source.{merge_key}"
    )

    # Update an existing record when the same
    # business key is found.
    .whenMatchedUpdateAll()

    # Insert records that do not already exist.
    .whenNotMatchedInsertAll()

    .execute()
)
```

# ============================================================

# Example Usage

# ============================================================

# Example:

#

# bronze_df = (

# spark.read

# .format("delta")

# .table("bronze_consumption")

# )

#

# transformed_df = transform_consumption(bronze_df)

#

# incremental_merge(

# spark=spark,

# source_df=transformed_df,

# target_table="silver_consumption",

# merge_key="business_key"

# )
