with events as (

    select * from {{ ref('stg_events') }}

),

daily_activity as (

    select
        user_id,
        cast(event_timestamp as date) as activity_date,
        count(*) as total_events,
        count(distinct session_id) as total_sessions,
        count(case when event_name = 'page_view' then 1 end) as page_views,
        count(case when event_name = 'button_click' then 1 end) as button_clicks
    from events
    group by user_id, cast(event_timestamp as date)

)

select
    {{ dbt_utils.generate_surrogate_key(['user_id', 'activity_date']) }} as activity_id,
    user_id,
    activity_date,
    total_events,
    total_sessions,
    page_views,
    button_clicks
from daily_activity
