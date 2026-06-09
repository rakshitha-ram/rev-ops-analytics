
  
    

  create  table "dbt"."public"."int_dim_accounts__dbt_tmp"
  
  
    as
  
  (
    

with accounts as (
    select
        account_id,
        account_company_name,
        account_country,
        account_state,
        account_city,
        account_industry,
        account_fleet_size
    from "dbt"."public"."stg_accounts"
),

leads as (
    select
        account_id,
        count(distinct lead_id) as num_leads
    from "dbt"."public"."int_dim_leads"
    group by account_id
),

opportunities as (
    select
        account_id,
        count(distinct opportunity_id) as num_opportunities,
        sum(case when opportunity_is_closed then 1 else 0 end) as num_closed_opportunities,
        sum(case when opportunity_is_won then 1 else 0 end) as num_won_opportunities,
        sum(case when not opportunity_is_closed and not opportunity_is_won then 1 else 0 end) as num_potential_wins,
        avg(opportunity_lifetime_days) as avg_opportunity_lifetime_days
    from "dbt"."public"."int_dim_opportunities"
    group by account_id
)

select
    a.account_id,
    a.account_company_name,
    a.account_country,
    a.account_state,
    a.account_city,
    a.account_industry,
    a.account_fleet_size,
    l.num_leads,
    o.num_opportunities,
    o.num_closed_opportunities,
    o.num_won_opportunities,
    o.num_potential_wins,
    o.avg_opportunity_lifetime_days,
    --account_segment placeholder

    -- Win Rate %
    case 
        when o.num_opportunities > 0 then round(100.0 * o.num_won_opportunities / o.num_opportunities, 2)
        else null
    end as win_rate_pct,

    -- Potential Win Rate %
    case 
        when o.num_opportunities > 0 then round(100.0 * o.num_potential_wins / o.num_opportunities, 2)
        else null
    end as potential_win_rate_pct

from accounts a
left join leads l on a.account_id = l.account_id
left join opportunities o on a.account_id = o.account_id
  );
  