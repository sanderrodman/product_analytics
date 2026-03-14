-- Ensure no completed orders have negative amounts
select
    order_id,
    order_amount
from {{ ref('fct_orders') }}
where order_status = 'completed'
  and order_amount < 0
