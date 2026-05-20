  select var_data:customer_id::number as customer_id,
    var_data:email::varchar as email,
    var_data:name.first_name::varchar as first_name,
    var_data:name.last_name::varchar as last_name,
    var_data:address.country::varchar as country,
    var_data:address.state::varchar as state,
    var_data:address.city::varchar as city,
    a.value:number::number as phone,
    a.value:type::varchar as phone_type,
    var_data:created_at::timestamp as time
    from {{source('bronze','CUSTOMERS_RAW_DAK')}},
    lateral flatten(input=>var_data:phones)a