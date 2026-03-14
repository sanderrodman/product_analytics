with source as (

    select * from {{ source('product_analytics', 'raw_users') }}

),

renamed as (

    select
        user_id,
        lower(trim(email)) as email,
        cast(signup_date as date) as signup_date,
        lower(trim(plan_type)) as plan_type
    from source

)

select * from renamed
