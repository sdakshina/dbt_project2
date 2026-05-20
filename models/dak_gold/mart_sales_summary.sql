
select
d.full_date,
p.main_category,
count(distinct f.order_id) as total_orders,
sum(f.quantity) as total_quantity,
sum(f.net_amount) as total_sales,
avg(f.net_amount) as avg_order_value,
count(distinct f.customer_skey) as total_customers
from {{ ref('fact_orders')}} f
left join {{ ref('dim_products_dak')}} p
on f.product_skey = p.product_skey
left join {{ ref('dim_date')}} d
on f.order_date_sk = d.date_sk
group by 1,2