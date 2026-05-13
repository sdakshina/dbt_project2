SELECT
    a.VAR_DATA:review_id::STRING AS review_id,
    a.VAR_DATA:customer_id::INT AS customer_id,
    a.VAR_DATA:product_id::STRING AS product_id,
    a.VAR_DATA:rating::INT AS rating,
    a.VAR_DATA:review_date::DATE AS review_date,
    f.VALUE::STRING AS comment
FROM {{source('bronze','REVIEWS_RAW_DAK')}} a,
LATERAL FLATTEN(input => a.VAR_DATA:comments) f