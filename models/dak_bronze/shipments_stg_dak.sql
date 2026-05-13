SELECT
    a.VAR_DATA:shipment_id::STRING AS shipment_id,
    a.VAR_DATA:order_id::STRING AS order_id,
    f.VALUE:status::STRING AS tracking_status,
    f.VALUE:timestamp::TIMESTAMP AS event_timestamp
FROM {{source('bronze','SHIPMENTS_RAW_DAK')}} a,
LATERAL FLATTEN(input => a.VAR_DATA:tracking_events) f