with users as (

    select * from {{ ref('stg_users') }}

),

user_events as (

    select
        user_id,
        min(event_timestamp) as first_event_at,
        max(event_timestamp) as last_event_at,
        count(*) as total_events
    from {{ ref('stg_events') }}
    group by user_id

),

user_orders as (

    select
        user_id,
        count(*) as total_orders,
        sum(case when order_status = 'completed' then order_amount else 0 end) as lifetime_value,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from {{ ref('stg_orders') }}
    group by user_id

)

select
    u.user_id,
    u.email,
    u.signup_date,
    u.plan_type,
    ue.first_event_at,
    ue.last_event_at,
    coalesce(ue.total_events, 0) as total_events,
    coalesce(uo.total_orders, 0) as total_orders,
    coalesce(uo.lifetime_value, 0) as lifetime_value,
    uo.first_order_date,
    uo.last_order_date
from users u
left join user_events ue on u.user_id = ue.user_id
left join user_orders uo on u.user_id = uo.user_id
