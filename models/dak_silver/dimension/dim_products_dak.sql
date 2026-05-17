{{
    config
    (
        materialized='incremental'
    )
}}


select  {{ 
        dbt_utils.generate_surrogate_key(['product_id', 'dbt_valid_from'])
    }} as product_skey,
    product_id,product_name,price,main_category,sub_category,supplier_id,loaded_time,
    DBT_VALID_FROM as start_time,
    DBT_VALID_TO end_time,
    case when DBT_VALID_TO is null then 'Y' else 'N' END active
     from {{ ref('snap_products') }} src

{%if is_incremental()%}
where src.loaded_time >(select max(loaded_time) from {{this}})
{%endif%}