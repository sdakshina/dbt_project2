{{
    config
    (
        materialized='incremental'
    )
}}

select 
    {{ 
        dbt_utils.generate_surrogate_key(['customer_id', 'dbt_valid_from'])
    }} as customer_skey,
    customer_id,
    email,
    first_name,
    last_name,
    country,
    state,
    city,
    time as loaded_time,
    DBT_VALID_FROM as start_time,
    DBT_VALID_TO end_time,
    case when DBT_VALID_TO is null then 'Y' else 'N' END active
 from {{ ref('snap_customer_phn') }} as src

 {%if is_incremental()%}
 where src.time > (select max(time) from {{this}})
 {%endif%}