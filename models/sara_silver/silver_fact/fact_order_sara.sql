{{ 
    config(materialized='incremental')
}}


select distinct
 {{ dbt_utils.generate_surrogate_key([
'o.order_id',
'o.item_product_id'
]) }} as order_fact_sk,
o.order_id,
c.cust_key,
p.product_skey,
s.ship_sk,
to_number(to_char(o.order_date,'YYYYMMDD')) as order_date_sk,
o.item_quantity,
o.item_price,
(o.item_quantity * o.item_price) as gross_amount,
(o.item_quantity * o.item_price) as net_amount,
o.status,
current_timestamp() as loaded_timestamp
from {{ ref('dbt_stg_order_sara') }} AS  o
left join {{ ref('dim_customer_sara') }} AS c
on o.customer_id = c.customer_id and c.active_flag='Y'
and o.order_date >= to_CHAR(c.start_date,'YYYY-MM-DD')
and o.order_date < to_date(coalesce(c.end_date,'9999-12-31'))
left join {{ ref('dim_product_sara') }} p
on o.item_product_id = p.product_id and p.active='Y' 
and o.order_date >= to_char(p.start_time,'YYYY-MM-DD')
and o.order_date < to_date(coalesce(P.end_time,'9999-12-31'))
left join {{ ref('dim_shipment_sara') }} s
on o.order_id = s.order_id