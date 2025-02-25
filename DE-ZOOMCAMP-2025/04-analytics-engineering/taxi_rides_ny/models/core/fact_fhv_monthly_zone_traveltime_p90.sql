{{ config(materialized="table") }}


with
    trips as (
        select
            *,
            timestamp_diff(dropoff_datetime, pickup_datetime, second) as trip_duration
        from {{ ref("dim_fhv_trips") }}
    ),
    trip_duration_p90 as (
        select
            pickup_year,
            pickup_month,
            pickup_locationid,
            pickup_zone,
            dropoff_locationid,
            dropoff_zone,
            percentile_cont(trip_duration, 0.90) over (
                partition by
                    pickup_year, pickup_month, pickup_locationid, dropoff_locationid
            ) as p90_trip_duration
        from trips
    )

select
    t.pickup_year,
    t.pickup_month,
    t.pickup_locationid,
    t.pickup_zone,
    t.dropoff_locationid,
    t.dropoff_zone,
    any_value(t.p90_trip_duration) as p90_duration
from trip_duration_p90 t
group by 1, 2, 3, 4, 5, 6
