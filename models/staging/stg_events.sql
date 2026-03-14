with source as (

    select * from {{ source('product_analytics', 'raw_events') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['user_id', 'event_name', 'event_timestamp']) }} as event_id,
        user_id,
        event_name,
        cast(event_timestamp as timestamp) as event_timestamp,
        page_url,
        session_id
    from source

)

select * from renamed
