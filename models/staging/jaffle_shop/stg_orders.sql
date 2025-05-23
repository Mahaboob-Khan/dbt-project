{{
    config(
        required_tests = None
    )
}}

with

orders as ( 

    select * from {{ source('jaffle_shop', 'orders') }}

),

final as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        datediff('day', order_date, {{ dbt.current_timestamp() }}) as days_since_ordered,
        status like '%pending%' as is_status_pending,
        case
            when status like '%return%' then 'returned'
            when status like '%shipped_pending%' then 'yet_to_be_shipped'
            when status like '%pending%' then 'placed'
            else status
        end as status
    from
        orders

)

select * from final