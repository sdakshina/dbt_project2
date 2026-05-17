{{ 
    config(materialized='incremental')
}}


select
{{ dbt_utils.generate_surrogate_key([
'o.order_id',
'o.product_id'
]) }} as order_fact_sk,
o.order_id,
c.customer_skey,
p.product_skey,
pm.payment_method_sk,
s.shipment_sk,
to_number(to_char(o.order_date,'YYYYMMDD')) as order_date_sk,
o.quantity,
o.price,
-- o.discount_amount,
-- o.tax_amount,
(o.quantity * o.price) as gross_amount,
(o.quantity * o.price) as net_amount,
o.status,
current_timestamp() as loaded_timestamp
from {{ ref('orders_stg_dak') }} AS  o
left join {{ ref('dim_customer') }} AS c
on o.customer_id = c.customer_id and c.active='Y'
and o.order_date >= to_CHAR(c.start_time,'YYYY-MM-DD')
and o.order_date < to_date(coalesce(c.end_time,'9999-12-31'))
left join {{ ref('dim_products_dak') }} p
on o.product_id = p.product_id and p.active='Y'
and o.order_date >= to_char(p.start_time,'YYYY-MM-DD')
and o.order_date < to_date(coalesce(P.end_time,'9999-12-31'))
left join {{ ref('dim_payments') }} pm
on o.method = pm.payment_method
left join {{ ref('dim_shipments') }} s
on o.order_id = s.order_id