{{ 
    config(materialized='table')
}}
select
c.customer_id,
c.first_name,
c.last_name,
c.city,
c.state,
c.country,
count(distinct f.order_id) as total_orders,
count(distinct f.quantity) as total_products,
sum(f.net_amount) as total_spend,
avg(r.rating) as avg_rating,
max(d.full_date) as last_order_date,
count(distinct rt.return_id) as total_returns
from {{ ref('dim_customer') }} c
left join {{ ref('fact_orders')}} f
on c.customer_skey = f.customer_skey
left join {{ ref('fact_reviews') }} r
on c.customer_id = r.customer_id
left join {{ ref('fact_returns') }} rt
on c.customer_id = rt.customer_id
left join {{ ref('dim_date') }} d
on f.order_date_sk = d.date_sk
where c.active = 'Y'
group by 1,2,3,4,5,6