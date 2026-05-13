{%snapshot employee_scd_timestamp_dakshina%}

{{
    config
    (
        unique_key='emp_id',
        strategy='timestamp',
        updated_at='source_loaded_at',
        invalidate_hard_deletes=true,
        schema='DEV'
    )
}}

select * from {{source('dev','employee_dup')}}


{%endsnapshot%}