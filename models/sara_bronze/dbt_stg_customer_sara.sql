SELECT
    a.RAW:customer_id::INT AS customer_id,
    a.RAW:name.first_name::STRING AS first_name,
    a.RAW:name.last_name::STRING AS last_name,
    a.RAW:email::STRING AS email,
    a.RAW:address.city::STRING AS city,
    a.RAW:address.state::STRING AS state,
    a.RAW:address.country::STRING AS country,
    f.VALUE:type::STRING AS phone_type,
    f.VALUE:number::STRING AS phone_number,
    a.RAW:created_at::TIMESTAMP AS created_at,
    a.FILE_NAME,
    current_timestamp() as LOD_TS,
    a.USER_NAME
FROM {{ source('brnz_sara','STG_CUSTOMER_SARA') }} a,
LATERAL FLATTEN(input => a.RAW:phones) f