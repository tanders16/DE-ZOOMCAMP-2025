{{ config(materialized="table") }}

select distinct extract(year from pickup_datetime) as year
from
    (
        select pickup_datetime
        from {{ ref("stg_green_tripdata") }}
        union all
        select pickup_datetime
        from {{ ref("stg_yellow_tripdata") }}
    )
