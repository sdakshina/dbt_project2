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
from {{ ref('dbt_stg_payaments_sara')}} as p
left join {{ ref('dbt_stg_order_sara') }} AS c
on p.order_id=c.order_id
