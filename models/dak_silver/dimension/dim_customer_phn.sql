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
        dbt_utils.generate_surrogate_key(['customer_id', 'phone_type','dbt_valid_from'])
    }} as customer_skey,
    customer_id,
    phone,
    phone_type,
    DBT_VALID_FROM as start_time,
    DBT_VALID_TO as end_time,
    case when DBT_VALID_TO is null then 'Y' else 'N' END active
 from {{ ref('snap_customer_phn') }} as src