SELECT
    a.RAW:shipment_id::STRING AS shipment_id,
    a.RAW:order_id::STRING AS order_id,
    f.VALUE:status::STRING AS tracking_status,
    f.VALUE:timestamp::TIMESTAMP AS tracking_timestamp,
    a.FILE_NAME,
    current_timestamp() as LOD_TS,
    a.USER_NAME
FROM  {{ source('brnz_sara','STG_SHIPMENTS_SARA') }} a,
LATERAL FLATTEN(input => a.RAW:tracking_events) f