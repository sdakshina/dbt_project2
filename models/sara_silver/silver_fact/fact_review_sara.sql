{{ 
    config(materialized='incremental')
}}

select {{ dbt_utils.generate_surrogate_key(['review_id']) }} as review_fact_sk,
r.review_id,
r.customer_id,
r.product_id,
r.rating,
r.comment,
r.review_date,
current_timestamp() as loaded_timestamp
from {{ ref('dbt_stg_reviews_sara')}} as r