{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='shipment_id',
        on_schema_change='sync_all_columns'
    )
}}

select
   {{ dbt_utils.generate_surrogate_key(['SHIPMENT_ID','current_timestamp'])}} as ship_sk,
    SHIPMENT_ID,
    ORDER_ID,
    TRACKING_STATUS,
    TRACKING_TIMESTAMP,

    current_timestamp() as updated_at

from {{ ref('dbt_stg_shipments_sara') }}

{% if is_incremental() %}

where TRACKING_TIMESTAMP >
(
    select coalesce(max(TRACKING_TIMESTAMP),'1900-01-01')
    from {{ this }}
)

{% endif %}