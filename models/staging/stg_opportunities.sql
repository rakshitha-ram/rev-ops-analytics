
  
    

  create  table "dbt"."public"."stg_opportunities__dbt_tmp"
  
  
    as
  
  (
    

with source as (
    select
        *,
        ROW_NUMBER() over (
            partition by id
            order by created_at
        ) as opp_rank
    from "dbt"."public"."opportunities"

)

select
    id as opportunity_id,
    account_id,
    is_closed as opportunity_is_closed,
    is_won as opportunity_is_won,
    country as opportunity_country,
    state as opportunity_state,
    city as opportunity_city,
    CAST(created_at as date) as opportunity_created_at,
    CAST(closed_at as date) as opportunity_closed_at
from source
where opp_rank = 1
  );
  