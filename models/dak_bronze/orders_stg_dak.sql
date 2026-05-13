select var_data:customer_id::number as customer_id,
        var_data:order_id::string as order_id,
        f1.value:product_id::string as product_id,
        f1.value:quantity::number as quantity,
        f1.value:price::decimal as price,

    var_data:order_date::date as order_date,
        var_data:shipping.address.city::string as city,
        var_data:shipping.address.state::string as state,

    var_data:shipping.method::string as method,
    var_data:status::string as status

    from {{source('bronze','ORDERS_RAW_DAK')}},
    lateral flatten(input=>var_data:items)f1;