{{ 
    config(materialized='incremental')
}}

select {{ dbt_utils.generate_surrogate_key(['review_id']) }} as review_fact_sk,
r.review_id,
r.customer_id,
r.product_id,
r.rating,
r.comments,
r.review_date,
current_timestamp() as loaded_timestamp
from {{ ref('reviews_stg_dak')}} as r