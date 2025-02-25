# Module 4 Homework: Analytics Engineering


### Question 1: Understanding dbt model resolution

Provided you've got the following sources.yaml
```yaml
version: 2

sources:
  - name: raw_nyc_tripdata
    database: "{{ env_var('DBT_BIGQUERY_PROJECT', 'dtc_zoomcamp_2025') }}"
    schema:   "{{ env_var('DBT_BIGQUERY_SOURCE_DATASET', 'raw_nyc_tripdata') }}"
    tables:
      - name: ext_green_taxi
      - name: ext_yellow_taxi
```

with the following env variables setup where `dbt` runs:
```shell
export DBT_BIGQUERY_PROJECT=myproject
export DBT_BIGQUERY_DATASET=my_nyc_tripdata
```

**What does this .sql model compile to?**
```sql
select * 
from {{ source('raw_nyc_tripdata', 'ext_green_taxi' ) }}
```

Compiled test raw model folder with associated schema.yml and ext_green_taxi.sql files.
Compiled to review rendered values.

![Screenshot 2025-02-24 at 6 36 23 PM](https://github.com/user-attachments/assets/e113e12a-8f9b-4d0b-abb3-fe1577edfbd2)

**Result:**
- `select * from dtc_zoomcamp_2025.raw_nyc_tripdata.ext_green_taxi`



### Question 2: dbt Variables & Dynamic Models

Say you have to modify the following dbt_model (`fct_recent_taxi_trips.sql`) to enable Analytics Engineers to dynamically control the date range. 

- In development, you want to process only **the last 7 days of trips**
- In production, you need to process **the last 30 days** for analytics

```sql
select *
from {{ ref('fact_taxi_trips') }}
where pickup_datetime >= CURRENT_DATE - INTERVAL '30' DAY
```

**What would you change to accomplish that in a such way that command line arguments takes precedence over ENV_VARs, which takes precedence over DEFAULT value?**

Added appropriate WHERE clause to code and created a production environment variable to test assumption.

Added new WHERE clause to code
![Screenshot 2025-02-24 at 7 38 54 PM](https://github.com/user-attachments/assets/05ffa396-28c6-4542-b719-23eb07cebf44)

Added new production environment and variable
![Screenshot 2025-02-24 at 7 37 19 PM](https://github.com/user-attachments/assets/e3582b2b-8d43-4ea8-ae33-af2cb25e4315)

Built code to view resolved environment value (1)
![Screenshot 2025-02-24 at 7 41 17 PM](https://github.com/user-attachments/assets/74fdec78-3a4f-4fc7-ba49-ea96f4e3762e)

Ran code with --vars command line paramenter (got 9, command line value sent)
![Screenshot 2025-02-24 at 7 52 32 PM](https://github.com/user-attachments/assets/e1cf199c-e0df-4753-a9a0-5def8423b032)


**Result:**
- Update the WHERE clause to `pickup_datetime >= CURRENT_DATE - INTERVAL '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY`



### Question 3: dbt Data Lineage and Execution

Considering the data lineage below **and** that taxi_zone_lookup is the **only** materialization build (from a .csv seed file):

**Select the option that does _NOT_ apply for materializing `fct_taxi_monthly_zone_revenue`:**

Created test objects to reflect same lineage to test theories and prove all lines.

- `dbt run` (materialized fact table as is a full run of workflow)

![Screenshot 2025-02-24 at 9 56 46 PM](https://github.com/user-attachments/assets/9a45c238-379c-4cff-88e2-d1354e64ea35)


- `dbt run --select +models/core/dim_taxi_trips.sql+ --target prod`
(missed capturing image. but, materialized table as runs dim_taxi_trips.sql plus all ancestors and descendants [plus + parameter])


- `dbt run --select +models/core/fct_taxi_monthly_zone_revenue.sql`
(materializes fact table as running for self and all ancestors [plus + parameter option at front])

![Screenshot 2025-02-24 at 9 55 13 PM](https://github.com/user-attachments/assets/365d0404-d2b7-4a98-8a50-a8da22105a0f)


- `dbt run --select +models/core/` (materializes table as runs components in 'core' plus ancestors)

![Screenshot 2025-02-24 at 9 54 30 PM](https://github.com/user-attachments/assets/701857b3-a927-4f6e-8260-d43d9c987e6b)


- **`dbt run --select models/staging/+`** (initailly ran appropriately as required [seed] components existed. After removing seed generated dependencies in staging, test failed to run as skips staging and runs for descendants of staging.)

![Screenshot 2025-02-24 at 10 36 19 PM](https://github.com/user-attachments/assets/051d85c1-b911-4f38-bd0f-b6f1e34d3866)



### Question 4: dbt Macros and Jinja

Consider you're dealing with sensitive data (e.g.: [PII](https://en.wikipedia.org/wiki/Personal_data)), that is **only available to your team and very selected few individuals**, in the `raw layer` of your DWH (e.g: a specific BigQuery dataset or PostgreSQL schema), 

 - Among other things, you decide to obfuscate/masquerade that data through your staging models, and make it available in a different schema (a `staging layer`) for other Data/Analytics Engineers to explore

- And **optionally**, yet  another layer (`service layer`), where you'll build your dimension (`dim_`) and fact (`fct_`) tables (assuming the [Star Schema dimensional modeling](https://www.databricks.com/glossary/star-schema)) for Dashboarding and for Tech Product Owners/Managers

You decide to make a macro to wrap a logic around it:

```sql
{% macro resolve_schema_for(model_type) -%}

    {%- set target_env_var = 'DBT_BIGQUERY_TARGET_DATASET'  -%}
    {%- set stging_env_var = 'DBT_BIGQUERY_STAGING_DATASET' -%}

    {%- if model_type == 'core' -%} {{- env_var(target_env_var) -}}
    {%- else -%}                    {{- env_var(stging_env_var, env_var(target_env_var)) -}}
    {%- endif -%}

{%- endmacro %}
```

And use on your staging, dim_ and fact_ models as:
```sql
{{ config(
    schema=resolve_schema_for('core'), 
) }}
```

**That all being said, regarding macro above, _select all statements that are true to the models using it_**:
- Setting a value for  `DBT_BIGQUERY_TARGET_DATASET` env var is mandatory, or it'll fail to compile (no default set)
~~- Setting a value for `DBT_BIGQUERY_STAGING_DATASET` env var is mandatory, or it'll fail to compile~~
- When using `core`, it materializes in the dataset defined in `DBT_BIGQUERY_TARGET_DATASET` (first step in conditional logic)
- When using `stg`, it materializes in the dataset defined in `DBT_BIGQUERY_STAGING_DATASET`, or defaults to `DBT_BIGQUERY_TARGET_DATASET` (else condition)
- When using `staging`, it materializes in the dataset defined in `DBT_BIGQUERY_STAGING_DATASET`, or defaults to `DBT_BIGQUERY_TARGET_DATASET` (else condition)



## Serious SQL

Alright, in module 1, you had a SQL refresher, so now let's build on top of that with some serious SQL.

These are not meant to be easy - but they'll boost your SQL and Analytics skills to the next level.  
So, without any further do, let's get started...

You might want to add some new dimensions `year` (e.g.: 2019, 2020), `quarter` (1, 2, 3, 4), `year_quarter` (e.g.: `2019/Q1`, `2019-Q2`), and `month` (e.g.: 1, 2, ..., 12), **extracted from pickup_datetime**, to your `fct_taxi_trips` OR `dim_taxi_trips.sql` models to facilitate filtering your queries

_Created dimension tables and foreign keys as requested._



### Question 5: Taxi Quarterly Revenue Growth

1. Create a new model `fct_taxi_trips_quarterly_revenue.sql`
2. Compute the Quarterly Revenues for each year for based on `total_amount`
3. Compute the Quarterly YoY (Year-over-Year) revenue growth 
  * e.g.: In 2020/Q1, Green Taxi had -12.34% revenue growth compared to 2019/Q1
  * e.g.: In 2020/Q4, Yellow Taxi had +34.56% revenue growth compared to 2019/Q4

**Considering the YoY Growth in 2020, which were the yearly quarters with the best (or less worse) and worst results for green, and yellow**

Created new fact table as requested. Queried in BigQuery for result.

![Screenshot 2025-02-25 at 1 16 36 AM](https://github.com/user-attachments/assets/25e6ee48-0676-438d-86a0-d2adc9903ba6)


**Result:**
- green: {best: 2020/Q2, worst: 2020/Q1}, yellow: {best: 2020/Q2, worst: 2020/Q1}



### Question 6: P97/P95/P90 Taxi Monthly Fare

1. Create a new model `fct_taxi_trips_monthly_fare_p95.sql`
2. Filter out invalid entries (`fare_amount > 0`, `trip_distance > 0`, and `payment_type_description in ('Cash', 'Credit Card')`)
3. Compute the **continous percentile** of `fare_amount` partitioning by service_type, year and and month

**Now, what are the values of `p97`, `p95`, `p90` for Green Taxi and Yellow Taxi, in April 2020?**

Created fact table as requested. Created BigQuery query to filter data for April 2020. Noted best answer as p97 and p95 results for yellow were off by .5 each.

![Screenshot 2025-02-25 at 2 05 33 AM](https://github.com/user-attachments/assets/66664bb4-dd1a-4338-ae3c-4c75d6349bed)


**Result:**
- green: {p97: 55.0, p95: 45.0, p90: 26.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}



### Question 7: Top #Nth longest P90 travel time Location for FHV

Prerequisites:
* Create a staging model for FHV Data (2019), and **DO NOT** add a deduplication step, just filter out the entries where `where dispatching_base_num is not null`
* Create a core model for FHV Data (`dim_fhv_trips.sql`) joining with `dim_zones`. Similar to what has been done [here](../../../04-analytics-engineering/taxi_rides_ny/models/core/fact_trips.sql)
* Add some new dimensions `year` (e.g.: 2019) and `month` (e.g.: 1, 2, ..., 12), based on `pickup_datetime`, to the core model to facilitate filtering for your queries

Now...
1. Create a new model `fct_fhv_monthly_zone_traveltime_p90.sql`
2. For each record in `dim_fhv_trips.sql`, compute the [timestamp_diff](https://cloud.google.com/bigquery/docs/reference/standard-sql/timestamp_functions#timestamp_diff) in seconds between dropoff_datetime and pickup_datetime - we'll call it `trip_duration` for this exercise
3. Compute the **continous** `p90` of `trip_duration` partitioning by year, month, pickup_location_id, and dropoff_location_id

**For the Trips that _respectively_ started from `Newark Airport`, `SoHo`, and `Yorkville East`, in November 2019, what are _dropoff_zones_ with the 2nd longest p90 trip_duration ?**

Created fact table as requested. Created BigQuery query to rank dataset and filter to requested conditions.

![Screenshot 2025-02-25 at 10 19 20 AM](https://github.com/user-attachments/assets/0262d79d-1762-4ee3-a4b2-ea34044fb592)


**Result:**
- LaGuardia Airport, Chinatown, Garment District

