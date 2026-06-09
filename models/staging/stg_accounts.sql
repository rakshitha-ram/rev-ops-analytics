
  
    

  create  table "dbt"."public"."stg_accounts__dbt_tmp"
  
  
    as
  
  (
    

with source as (
    select *
    from "dbt"."public"."accounts"

)

select
    id as account_id,
    company as account_company_name,
    country as account_country,
    state as account_state,
    city as account_city,
    industry as account_industry,
    fleet_size as account_fleet_size,
    max(primary_contact_id) as account_primary_contact_id
from source
group by
    id,
    company,
    country,
    state,
    city,
    industry,
    fleet_size
  );
  