{%snapshot employee_scd_dakshina%}

{{
    config
    (
        unique_key='emp_id',
        strategy='check',
        check_cols=['empname','depart'],
        invalidate_hard_deletes='True',
        target_schema='DEV'
         
    )
}}

select * from {{source('dev','employee_dup')}}


{%endsnapshot%}