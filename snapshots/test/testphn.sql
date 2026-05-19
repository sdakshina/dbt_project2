{%snapshot snap_products%}

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

    select product_id,product_name,price,main_category,sub_category,supplier_id,loaded_time
    from  {{ ref('products_stg_dak') }}
    qualify row_number() over(partition by product_id,supplier_id order by loaded_time desc)=1

)

select * from de_dupliate_customer_phn



{%endsnapshot%}