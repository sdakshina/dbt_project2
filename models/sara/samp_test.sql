{{
    config(
        materialized = 'table',
        database = 'xyz',
        schema = 'xyz'
        
    )
}}

select * from {{ source('dev','SRC_PRODUCT') }}