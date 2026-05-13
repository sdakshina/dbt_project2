SELECT
    a.VAR_DATA:return_id::STRING AS return_id,
    a.VAR_DATA:order_id::STRING AS order_id,
    a.VAR_DATA:refund_status::STRING AS refund_status,
    f.VALUE:product_id::STRING AS product_id,
    f.VALUE:reason::STRING AS reason
FROM {{source('bronze','RETURNS_RAW_DAK')}} a,
LATERAL FLATTEN(input => a.VAR_DATA:items) f;