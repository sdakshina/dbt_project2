{{ 
    config(materialized='table')
}}

select distinct
{{ dbt_utils.generate_surrogate_key([
'shipment_id'
]) }} as shipment_sk,
shipment_id,
order_id,
tracking_status,
event_timestamp
from {{ ref('shipments_stg_dak')
}}


