{{
    config(
        materialized = 'view'
    )
}}

with src as (select *, {{dbt_utils.generate_surrogate_key(['PRODUCT_NAME', 'CATEGORY', 'PRICE', 'STOCK_QTY'])}} as check_sum
 from {{source('dev','SRC_PRODUCT')}}),
dedup as (
    select *, row_number()over(partition by check_sum order by updated_ts) rn from src)

select product_id, product_name, category, stock_qty, price, created_date, updated_ts,check_sum
from dedup where rn =1