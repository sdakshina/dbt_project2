{% snapshot product_sn_tm %}
{{
    config(
        unique_key = 'product_id',
        strategy = 'timestamp',
        updated_at = 'updated_ts',
        invalidate_hard_deletes = true
    )
}}
 
SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    PRICE,
    STOCK_QTY,
    CREATED_DATE,
    UPDATED_TS FROM {{source('dev','SRC_PRODUCT') }}

{% endsnapshot %}