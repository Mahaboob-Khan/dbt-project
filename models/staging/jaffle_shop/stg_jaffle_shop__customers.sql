with

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

customers as (

    select

        id as customer_id,
        last_name as surname,
        first_name as givenname,
        initcap(trim(first_name)) || ' ' || initcap(trim(last_name)) as full_name

    from
        source

)

select * from customers