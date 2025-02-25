{{ config(materialized="table") }}

select distinct extract(quarter from pickup_datetime) as qtr
from
    (
        select pickup_datetime
        from {{ ref("stg_green_tripdata") }}
        union all
        select pickup_datetime
        from {{ ref("stg_yellow_tripdata") }}
    )
