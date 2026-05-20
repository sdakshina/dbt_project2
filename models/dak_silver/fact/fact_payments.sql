{{ 
    config(materialized='incremental')
}}

select
distinct {{ dbt_utils.generate_surrogate_key(['payment_id']) }} as payment_fact_sk,
p.payment_id,
p.order_id,
c.customer_id,
p.amount,
p.payment_status,
p.payment_method,
p.txn_timestamp,
current_timestamp() as loaded_timestamp
from {{ ref('payments_stg_dak')}} as p
left join {{ ref('orders_stg_dak') }} AS c
on p.order_id=c.order_id
