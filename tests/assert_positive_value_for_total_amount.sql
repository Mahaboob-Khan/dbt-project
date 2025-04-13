-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.
{{
    config(
        store_failures=true
    )
}}

select
  order_id,
  sum(payment_amount) as total_amount
from
    {{ ref('stg_stripe__payments') }}
group by
    order_id
having 
    (total_amount < 0)