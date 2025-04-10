select
    payment_method,
    sum(payment_amount) as total_amount
from
    {{ ref('stg_stripe__payments') }}
where
    payment_status = 'success'
group by
    payment_method