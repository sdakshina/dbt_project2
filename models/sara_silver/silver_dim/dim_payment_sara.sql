{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='payment_id',
        on_schema_change='sync_all_columns'
    )
}}

select

    {{ dbt_utils.generate_surrogate_key(['PAYMENT_ID','current_timestamp']) }} as payment_sk,

    PAYMENT_ID,
    ORDER_ID,
    AMOUNT,
    PAYMENT_METHOD,
    PAYMENT_STATUS,
    TXN_ID,
    BANK,
    TXN_TIMESTAMP,

    current_timestamp() as updated_at

from {{ ref('dbt_stg_payaments_sara') }}

{% if is_incremental() %}

where TXN_TIMESTAMP >
(
    select coalesce(max(TXN_TIMESTAMP),'1900-01-01')
    from {{ this }}
)

{% endif %}