{{
    config(
        materialized = 'view'
    )
}}



with temp as
(select 'dd' as col)

select * from temp