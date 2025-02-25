{{ config(materialized="table") }}

with
    base as (
        select
            upper(service_type) as taxi_type,
            pickup_month as month,
            pickup_year as year,
            percentile_cont(fare_amount, 0.97) over (
                partition by service_type, pickup_month, pickup_year
            ) as p97,
            percentile_cont(fare_amount, 0.95) over (
                partition by service_type, pickup_month, pickup_year
            ) as p95,
            percentile_cont(fare_amount, 0.90) over (
                partition by service_type, pickup_month, pickup_year
            ) as p90
        from `zoomcamp-sandbox.dbt_tanders16.fact_trips`
        where
            fare_amount > 0
            and trip_distance > 0
            and upper(payment_type_description) in ('CASH', 'CREDIT CARD')
    )

select
    base.taxi_type,
    base.month,
    base.year,
    any_value(base.p97) as p97_fare_amt,
    any_value(base.p95) as p95_fare_amt,
    any_value(base.p90) as p90_fare_amt
from base
group by base.taxi_type, base.month, base.year
