{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'cust_key',
        merge_update_columns = ['end_Date','active_flag']
    )
}}    

    select {{ dbt_utils.generate_surrogate_key(['CUSTOMER_ID','DBT_VALID_FROM']) }} as cust_key,
CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, CITY, STATE, COUNTRY,
 DBT_SCD_ID,  DBT_VALID_FROM as start_date, DBT_VALID_TO as end_Date,
 case when DBT_VALID_TO is null then 'Y' else 'N' end as active_flag 
 from {{ ref('dbt_snp_sht_customer') }}