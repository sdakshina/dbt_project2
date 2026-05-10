{{
    config(
        materialized = 'view'
    )
}}


select * from {{source('dev','SRC_PRODUCT')}}