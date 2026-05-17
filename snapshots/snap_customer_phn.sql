{%snapshot snap_customer_phn%}

{{
    config
    (
        unique_key=['customer_id','phone_type'],
        strategy='check',
        check_cols=['phone']
    )
}}


with de_dupliate_customer_phn as
(

    select customer_id,phone,phone_type,time
    from  {{ ref('customers_stg_dak') }} 
    qualify row_number() over(partition by customer_id,phone,phone_type order by time desc)=1

)

select * from de_dupliate_customer_phn



{%endsnapshot%}