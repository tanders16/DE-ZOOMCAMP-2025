{{ config(materialized="table") }}

select distinct format_timestamp("%Y/Q%Q", pickup_datetime) as year_qtr
from
    (
        select pickup_datetime
        from {{ ref("stg_green_tripdata") }}
        union all
        select pickup_datetime
        from {{ ref("stg_yellow_tripdata") }}
    )
