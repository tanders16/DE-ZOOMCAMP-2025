{{ config(materialized="table") }}

select distinct extract(month from pickup_datetime) as mnth
from
    (
        select pickup_datetime
        from {{ ref("stg_green_tripdata") }}
        union all
        select pickup_datetime
        from {{ ref("stg_yellow_tripdata") }}
    )
