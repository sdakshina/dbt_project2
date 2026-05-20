SELECT
    a.RAW:return_id::STRING AS return_id,
    a.RAW:order_id::STRING AS order_id,
    a.RAW:refund_status::STRING AS refund_status,
    f.VALUE:product_id::STRING AS product_id,
    f.VALUE:reason::STRING AS return_reason,
    a.FILE_NAME,
    current_timestamp() LOD_TS,
    a.USER_NAME
FROM {{ source('brnz_sara','STG_RETURNS_SARA') }}  a,
LATERAL FLATTEN(input => a.RAW:items) f