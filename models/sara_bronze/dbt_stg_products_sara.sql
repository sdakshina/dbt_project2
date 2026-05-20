SELECT
    a.RAW:product_id::STRING AS product_id,
    a.RAW:product_name::STRING AS product_name,
    a.RAW:price::NUMBER AS price,
    a.RAW:category.main::STRING AS main_category,
    a.RAW:category.sub::STRING AS sub_category,
    a.RAW:supplier.supplier_id::STRING AS supplier_id,
    a.RAW:supplier.supplier_name::STRING AS supplier_name,
    f.VALUE::STRING AS tag,
    a.FILE_NAME,
    current_timestamp() LOD_TS,
    a.USER_NAME
FROM {{ source('brnz_sara','STG_PRODUCTS_SARA') }} a,
LATERAL FLATTEN(input => a.RAW:tags) f