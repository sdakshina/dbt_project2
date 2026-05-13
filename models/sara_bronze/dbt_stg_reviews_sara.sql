SELECT
    a.RAW:review_id::STRING AS review_id,
    a.RAW:product_id::STRING AS product_id,
    a.RAW:customer_id::INT AS customer_id,
    a.RAW:rating::INT AS rating,
    a.RAW:review_date::DATE AS review_date,
    f.VALUE::STRING AS comment,
    a.FILE_NAME,
    current_timestamp() LOD_TS,
    a.USER_NAME
FROM {{ source('brnz_sara','STG_REVIEWS_SARA') }}  a,
LATERAL FLATTEN(input => a.RAW:comments) f
