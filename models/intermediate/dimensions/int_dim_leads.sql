
  
    

  create  table "dbt"."public"."int_dim_leads__dbt_tmp"
  
  
    as
  
  (
    

with leads as (
    select
        lead_id,
        lead_email,
        lead_created_at,
        lead_converted_at,
        lead_source,
        lead_country,
        lead_city,
        lead_state,
        lead_industry,
        lead_fleet_size
    from "dbt"."public"."stg_leads"
),

contacts as (
    select
        contact_id,
        contact_email,
        account_id,
        lead_id,
        contact_created_at
    from "dbt"."public"."stg_contacts"
),

opportunities as (
    select
        opportunity_id,
        account_id,
        opportunity_created_at,
        opportunity_closed_at,
        opportunity_is_closed,
        opportunity_is_won
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
        account_fleet_size
    from "dbt"."public"."stg_accounts"
),

lead_summary as (
    select
        l.lead_id,
        l.lead_source,
        l.lead_created_at,
        l.lead_converted_at,
        l.lead_email, 
        l.lead_country,
        l.lead_city,
        l.lead_state,
        l.lead_industry,
        l.lead_fleet_size,
        c.contact_id,
        c.contact_created_at,
        a.account_id,
        a.account_company_name,
        o.opportunity_id,
        o.opportunity_is_closed,
        o.opportunity_is_won    
    from leads as l
    -- one contact has only one lead
    left join contacts as c on c.lead_id= l.lead_id 
     -- one account has only one lead
    left join accounts as a on a.account_id=c.account_id
    -- one opportunity has only one account
    left join opportunities as o on c.account_id = o.account_id
   
)

select *
from lead_summary
  );
  