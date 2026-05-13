SELECT
    a.VAR_DATA:payment_id::STRING AS payment_id,
    a.VAR_DATA:order_id::STRING AS order_id,
    a.VAR_DATA:amount::NUMBER AS amount,
    a.VAR_DATA:payment_method::STRING AS payment_method,
    a.VAR_DATA:payment_status::STRING AS payment_status,
    f.VALUE:txn_id::STRING AS txn_id,
    f.VALUE:bank::STRING AS bank,
    f.VALUE:timestamp::TIMESTAMP AS txn_timestamp
FROM {{source('bronze','PAYMENTS_RAW_DAK')}} a,
LATERAL FLATTEN(input => a.VAR_DATA:transactions) f;