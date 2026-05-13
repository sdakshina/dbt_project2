select *,
{{ dbt_utils.generate_surrogate_key(['empname', 'depart','salary','hr','manager_id']) }} as md5_key

 from {{source('dev','employee_dup')}}