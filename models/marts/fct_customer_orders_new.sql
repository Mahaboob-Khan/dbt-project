with

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

customers as (

    select * from {{ ref('stg_jaffle_shop__customers') }}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

paid_orders as (

    select * from {{ ref('int_orders') }}

),

final as (
    select
        paid_orders.order_id,
        paid_orders.customer_id,
        paid_orders.order_date as order_placed_at,
        paid_orders.order_status,
        paid_orders.order_value_dollars as total_amount_paid,
        paid_orders.payment_finalized_date,
        customers.givenname as customer_first_name,
        customers.surname as customer_last_name,

        -- sales transaction sequence
        row_number() over (order by paid_orders.order_id) as transaction_seq,

        -- customer sales sequence
        row_number() over (partition by paid_orders.customer_id order by paid_orders.order_id) as customer_sales_seq,

        -- new vs returning customer
        case 
            when (
            rank() over (
                partition by paid_orders.customer_id
                order by paid_orders.order_date, paid_orders.order_id
                ) = 1
            ) then 'new'
        else 'return' end as nvsr,

        -- customer lifetime value
        sum(paid_orders.order_value_dollars) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_date
            ) as customer_lifetime_value,

        -- first day of sale
        first_value(order_date) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_date
            ) as fdos
    from paid_orders
    left join customers on paid_orders.customer_id = customers.customer_id
)

-- Simple Select Statment

select * from final