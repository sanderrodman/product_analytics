with source as (

    select * from {{ source('product_analytics', 'raw_orders') }}

),

renamed as (

    select
        order_id,
        user_id,
        cast(amount as double) as order_amount,
        upper(trim(currency)) as currency,
        cast(order_date as date) as order_date,
        lower(trim(status)) as order_status
    from source

)

select * from renamed
