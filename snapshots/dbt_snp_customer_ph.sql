{%snapshot dbt_snp_customer_ph%}
{{
    config(
        unique_key = ['CUSTOMER_ID','PHONE_TYPE'],
        strategy = 'check',
        check_cols = ['PHONE_NUMBER']
    )
}}

with dedup as (
select CUSTOMER_ID,PHONE_TYPE, PHONE_NUMBER, current_timestamp() as loaded_timestamp from {{ ref('dbt_stg_customer_sara') }}
qualify row_number() over (partition by customer_id,PHONE_TYPE order by LOD_TS desc) =1
)

select CUSTOMER_ID,PHONE_TYPE, PHONE_NUMBER, loaded_timestamp from dedup

{% endsnapshot %}

