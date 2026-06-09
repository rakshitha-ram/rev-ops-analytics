
  
    

  create  table "dbt"."public"."int_dim_opportunities__dbt_tmp"
  
  
    as
  
  (
    

with opportunities as (
    select
        opportunity_id,
        account_id,
        opportunity_created_at,
        opportunity_closed_at,
        opportunity_is_closed,
        opportunity_is_won,
        (CURRENT_DATE - DATE(opportunity_created_at)) as opportunity_age_days,
        (
            opportunity_closed_at - opportunity_created_at
        ) as opportunity_lifetime_days,
        ROW_NUMBER()
            over (
                partition by account_id
                order by opportunity_created_at
            )
        as opp_rank
    from "dbt"."public"."stg_opportunities"
),

accounts as (
    select
        account_id,
        account_company_name,
        account_country,
        account_state,
        account_city,
        account_industry,
        account_fleet_size,
        account_primary_contact_id
    from "dbt"."public"."stg_accounts"
),

contacts as (
    select
        account_id,
        contact_id,
        lead_id
    from "dbt"."public"."stg_contacts"
    where account_id is not null

),

leads as (
    select
        lead_id,
        lead_created_at,
        lead_converted_at
    from "dbt"."public"."stg_leads"
),

opportunity_summary as (
    select
        o.opportunity_id,
        o.opportunity_created_at,
        o.opportunity_closed_at,
        o.opportunity_is_closed,
        o.opportunity_is_won,
        o.opportunity_lifetime_days,
        o.opportunity_age_days,
        a.account_id,
        a.account_company_name,
        a.account_country,
        a.account_state,
        a.account_city,
        a.account_industry,
        a.account_fleet_size,
        l.lead_id,
        l.lead_created_at,
        l.lead_converted_at,
        (o.opp_rank = 1) as is_new_opportunity
    from opportunities as o
    left join accounts as a on o.account_id = a.account_id
    left join contacts as c on a.account_primary_contact_id = c.contact_id
    left join leads as l on c.lead_id = l.lead_id

)

select * from opportunity_summary
  );
  