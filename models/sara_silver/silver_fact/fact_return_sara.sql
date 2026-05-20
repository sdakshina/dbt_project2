{{ 
    config(materialized='incremental')
}}

select
distinct 
{{ dbt_utils.generate_surrogate_key([
'return_id'
]) }} as return_fact_sk,
r.return_id,
r.order_id,
c.customer_id,
r.product_id,
r.refund_status,
r.return_reason,
current_timestamp() as loaded_timestamp
from {{ ref('dbt_stg_returns_sara')}} as r
left join {{ ref('dbt_stg_order_sara') }} AS c
on r.order_id=c.order_id