SELECT
    a.RAW:payment_id::STRING AS payment_id,
    a.RAW:order_id::STRING AS order_id,
    a.RAW:amount::NUMBER AS amount,
    a.RAW:payment_method::STRING AS payment_method,
    a.RAW:payment_status::STRING AS payment_status,
    f.VALUE:txn_id::STRING AS txn_id,
    f.VALUE:bank::STRING AS bank,
    f.VALUE:timestamp::TIMESTAMP AS txn_timestamp,
    a.FILE_NAME,
    current_timestamp() LOD_TS,
    a.USER_NAME
FROM {{ source('brnz_sara','STG_PAYMENTS_SARA') }} a,
LATERAL FLATTEN(input => a.RAW:transactions) f