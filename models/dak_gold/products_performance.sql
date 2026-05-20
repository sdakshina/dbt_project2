{{ 
    config(materialized='table')
}}

select
p.product_id,
p.product_name,
p.main_category,
-- p.brand,
sum(f.quantity) as total_quantity_sold,
sum(f.net_amount) as total_sales,
avg(r.rating) as avg_rating,
count(distinct rt.return_id) as total_returns,
round(count(distinct rt.return_id)/nullif(count(distinct f.order_id),0)) as return_rate
from {{ ref('dim_products_dak') }} p
left join {{ ref('fact_orders') }} f
on p.product_skey = f.product_skey
left join {{ ref('fact_reviews') }} r
on p.product_id = r.product_id
left join {{ ref('fact_returns') }} rt
on p.product_id = rt.product_id
where p.active = 'Y'
group by 1,2,3