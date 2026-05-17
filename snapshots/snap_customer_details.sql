{%snapshot snap_customer_details%}

{{
    config
    (
        unique_key='customer_id',
        strategy='check',
        check_cols=['email','first_name','last_name','country','state','city']
    )
}}


with de_dupliate_customer as
(

    select customer_id,email,first_name,last_name,country,state,city,time 
    from  {{ ref('customers_stg_dak') }} 
    qualify row_number() over(partition by customer_id order by time desc)=1

)

select * from de_dupliate_customer



{%endsnapshot%}