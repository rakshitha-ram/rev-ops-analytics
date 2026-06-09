
  
    

  create  table "dbt"."public"."int_dim_contacts__dbt_tmp"
  
  
    as
  
  (
    
select
    c.contact_id,
    c.contact_created_at,
    c.contact_job_title,
    c.contact_email,
    c.lead_id, -- join with lead table to get region at contact level
    a.account_id, -- join with account table to get region at account level
    a.account_company_name,
    l.lead_fleet_size,
    o.opportunity_id,
    o.opportunity_is_won,
    o.opportunity_is_closed
from "dbt"."public"."stg_contacts" as c
left join "dbt"."public"."stg_accounts" as a
    on c.account_id = a.account_id
left join "dbt"."public"."stg_leads" as l
    on c.lead_id = l.lead_id
left join "dbt"."public"."stg_opportunities" as o
    on c.account_id = o.account_id
  );
  