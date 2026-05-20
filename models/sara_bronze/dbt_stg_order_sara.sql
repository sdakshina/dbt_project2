select a.raw:order_id::string as order_id,
a.raw:customer_id:: int as customer_id,
a.raw:order_date :: date as order_date,
a.raw:status::string as status,
b.value:product_id :: string as item_product_id,
b.value:quantity:: int as item_quantity,
b.value:price:: int as item_price,
a.raw:shipping:address:city::string as ship_city,
a.raw:shipping:address:state::string as ship_state,
a.raw:shipping:method::string as ship_method,
    a.FILE_NAME,
    current_timestamp() as LOD_TS,
    a.USER_NAME
from {{ source('brnz_sara','STG_ORDERS_SARA') }} a,
lateral flatten(input => a.raw:items) b

