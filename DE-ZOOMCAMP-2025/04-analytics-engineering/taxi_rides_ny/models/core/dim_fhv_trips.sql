{{ config(materialized="table") }}

select
    'FHV' as service_type,
    trips.dispatching_base_num,

    extract(month from trips.pickup_datetime) as pickup_month,
    extract(quarter from trips.pickup_datetime) as pickup_quarter,
    extract(year from trips.pickup_datetime) as pickup_year,
    format_timestamp("%Y/Q%Q", trips.pickup_datetime) as pickup_year_quarter,

    trips.pickup_datetime,
    trips.dropoff_datetime,
    trips.pickup_locationid,
    trips.dropoff_locationid,
    pu_zones.borough as pickup_borough,
    pu_zones.zone as pickup_zone,
    do_zones.borough as dropoff_borough,
    do_zones.zone as dropoff_zone,
    trips.sr_flag,
    trips.affiliated_base_num
from {{ ref("stg_fhv_tripdata") }} trips
inner join
    {{ ref("dim_zones") }} pu_zones
    on trips.pickup_locationid = pu_zones.locationid
    and pu_zones.borough != 'Unknown'
inner join
    {{ ref("dim_zones") }} do_zones
    on trips.dropoff_locationid = do_zones.locationid
    and do_zones.borough != 'Unknown'
