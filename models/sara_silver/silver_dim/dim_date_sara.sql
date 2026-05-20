{{ config(materialized='table')
}}
with date_spine as (
{{ dbt_utils.date_spine(
datepart="day",
start_date="cast('2024-01-01' as date)",
end_date="cast('2030-12-31' as date)"
) }}
)
select
to_number(to_char(date_day,'YYYYMMDD')) as date_sk,
date_day as full_date,
year(date_day) as year,
quarter(date_day) as quarter,
month(date_day) as month,
day(date_day) as day,
week(date_day) as week,
dayname(date_day) as day_name,
current_timestamp() as loaded_timestamp
from date_spine