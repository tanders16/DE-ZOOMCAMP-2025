{{ config(materialized="view") }}

with
    trip_data as (
        select *,
        from {{ source("staging", "fhv_tripdata") }}
        where dispatching_base_num is not null
    )

select
    dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }}
    as pickup_locationid,
    {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("integer")) }}
    as dropoff_locationid,
    sr_flag as sr_flag,
    affiliated_base_number as affiliated_base_num
from trip_data

-- dbt build --select <model.sql> --vars '{'is_test_run: false}'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}
