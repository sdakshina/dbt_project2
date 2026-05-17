{{
    config
    (
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['customer_skey'],
        merge_update_columns=['end_time','active']
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
    dbt_updated_at as updated_tmsp,
    DBT_VALID_FROM as start_time,
    DBT_VALID_TO as end_time,
    case when DBT_VALID_TO is null then 'Y' else 'N' END active
 from {{ ref('snap_customer_detail_v1') }} as src
