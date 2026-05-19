{% snapshot dbt_snp_sht_customer %}
{{
    config(
        unique_key ='customer_id',
        strategy = 'check',
        check_cols  = ['first_name', 'last_name', 'email', 'city', 'state', 'country'],
        target_schema='silver'
    )
}}

with dedup as ( 
select
customer_id,
first_name,
last_name,
email,
city,
state,
country,
current_timestamp() as loaded_timestamp from  {{ ref('dbt_stg_customer_sara') }}
qualify row_number()over(partition by customer_id order by lod_ts desc ) =1)

select 
customer_id, first_name, last_name, email, city, state, country, loaded_timestamp from dedup

{% endsnapshot %}