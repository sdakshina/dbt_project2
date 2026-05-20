{% snapshot dbt_snp_product %}

{{
    config
    (
        unique_key=['product_id'],
        strategy='check',
        check_cols=['product_name','main_category','sub_category','SUPPLIER_ID','price']
    )
}}


with de_dupliate_customer_phn as
(

    select product_id,product_name,price,main_category,sub_category,supplier_id,lod_ts
    from  {{ ref('dbt_stg_products_sara') }}
    qualify row_number() over(partition by product_id,supplier_id order by lod_ts desc)=1

)

select * from de_dupliate_customer_phn

{% endsnapshot %}