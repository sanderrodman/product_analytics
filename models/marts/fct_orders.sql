with orders as (

    select * from {{ ref('stg_orders') }}

),

users as (

    select * from {{ ref('stg_users') }}

)

select
    o.order_id,
    o.user_id,
    u.email as user_email,
    u.plan_type,
    o.order_amount,
    o.currency,
    o.order_date,
    o.order_status
from orders o
left join users u on o.user_id = u.user_id
