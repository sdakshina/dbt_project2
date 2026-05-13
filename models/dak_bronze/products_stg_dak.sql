SELECT
    a.VAR_DATA:product_id::STRING AS product_id,
    a.VAR_DATA:product_name::STRING AS product_name,
    a.VAR_DATA:price::NUMBER AS price,
    a.VAR_DATA:category.main::STRING AS main_category,
    a.VAR_DATA:category.sub::STRING AS sub_category,
    a.VAR_DATA:supplier.supplier_id::STRING AS supplier_id,
    a.VAR_DATA:supplier.supplier_name::STRING AS supplier_name,
    f.VALUE::STRING AS tag
FROM {{source('bronze','PRODUCTS_RAW_DAK')}} a,
LATERAL FLATTEN(input => a.VAR_DATA:tags) f;