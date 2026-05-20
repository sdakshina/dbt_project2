{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'cust_sk',
        merge_update_columns = ['end_Date','active_flag']
    )
}}

select  {{ dbt_utils.generate_surrogate_key(['customer_id','phone_type','DBT_VALID_FROM'])}} as cust_sk,
customer_id, phone_type, phone_number,  DBT_SCD_ID,  DBT_VALID_FROM as start_date, DBT_VALID_TO as end_Date,
 case when DBT_VALID_TO is null then 'Y' else 'N' end as active_flag 
 from {{ ref('dbt_snp_customer_ph') }}