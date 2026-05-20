{{ 
    config(materialized='table')
}}

select 
{{ dbt_utils.generate_surrogate_key(['payment_method'])}} as payment_method_sk,
payment_method,
BANK

from {{ ref('payments_stg_dak')}}