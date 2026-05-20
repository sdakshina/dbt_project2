select
c.customer_id,
c.first_name,
c.last_name,
c.city,
c.state,
c.country,
count(distinct f.order_id) as total_orders,
count(distinct f.item_quantity) as total_products,
sum(f.net_amount) as total_spend,
avg(r.rating) as avg_rating,
max(d.full_date) as last_order_date,
count(distinct rt.return_id) as total_returns
from {{ ref('dim_customer_sara') }} c
left join {{ ref('fact_order_sara')}} f
on c.cust_key = f.cust_key
left join {{ ref('fact_review_sara') }} r
on c.customer_id = r.customer_id
left join {{ ref('fact_return_sara') }} rt
on c.customer_id = rt.customer_id
left join {{ ref('dim_date_sara') }} d
on f.order_date_sk = d.date_sk
where c.active_flag = 'Y'
group by 1,2,3,4,5,6