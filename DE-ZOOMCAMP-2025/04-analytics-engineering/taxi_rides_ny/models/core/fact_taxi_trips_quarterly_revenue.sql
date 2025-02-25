{{ config(materialized="table") }}

with
    all_trips as (
        select
            upper(service_type) as taxi_type,
            pickup_quarter,
            pickup_year,
            sum(total_amount) as ttl_quarterly_revenue
        from `zoomcamp-sandbox.dbt_tanders16.fact_trips`
        group by service_type, pickup_quarter, pickup_year
    ),
    final as (
        select
            y2.taxi_type,
            y2.pickup_year as year,
            concat(y2.pickup_year, '/Q', y2.pickup_quarter) as quarter,
            sum(y2.ttl_quarterly_revenue) as y2_qtr_revn,
            sum(y1.ttl_quarterly_revenue) as y1_qtr_revn,
            round(
                sum(y2.ttl_quarterly_revenue) - sum(y1.ttl_quarterly_revenue), 3
            ) as yoy_qtr_revn_delta,
            round(
                (sum(y2.ttl_quarterly_revenue) - sum(y1.ttl_quarterly_revenue))
                / sum(y2.ttl_quarterly_revenue)
                * 100,
                3
            ) as yoy_qtr_revn_pct
        from all_trips as y1
        inner join
            all_trips as y2
            on y1.taxi_type = y2.taxi_type
            and y1.pickup_quarter = y2.pickup_quarter
            and (y1.pickup_year + 1) = y2.pickup_year
        group by 1, 2, 3
    )

select
    year,
    taxi_type,
    min_by(quarter, yoy_qtr_revn_pct) as best,
    max_by(quarter, yoy_qtr_revn_pct) as worst
from final
group by
    year,
    taxi_type
    -- order by year, taxi_type
    
