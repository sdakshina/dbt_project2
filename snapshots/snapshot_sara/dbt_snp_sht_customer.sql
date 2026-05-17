{% snapshot dbt_snp_sht_cusotmer %}
{{
    config(
        unique_key ='customer_id',
        strategy = 'check',
        check_cols  = ['first_name', 'last_name', 'email', 'city', 'state', 'country']
    )
}}

select
customer_id,
first_name,
last_name,
email,
city,
state,
country,
current_timestamp() as loaded_timestamp from  {{ ref('dbt_stg_customer_sara') }}
{% endsnapshot %}