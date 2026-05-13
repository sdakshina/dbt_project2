{%snapshot employee_scd_md5%}

{{
    config
    (
        strategy='check',
        unique_key='emp_id',
        check_cols=['md5_key']
    )
}}

select * from {{ref('employee_stg')}}

{%endsnapshot%}