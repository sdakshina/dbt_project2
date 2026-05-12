{% snapshot product_snapshot %}
{{
    config( 
        unique_key = 'product_id',
        strategy = 'check',
        check_cols = ['product_name','category','stock_qty', 'price'],
        invalidate_hard_deletes = true
    )
}}

select product_id, product_name, category, stock_qty, price, current_timestamp() as dw_bus_date 
from {{source('dev','SRC_PRODUCT')}}

{% endsnapshot %}