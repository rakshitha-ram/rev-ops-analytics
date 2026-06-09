
  
    

  create  table "dbt"."public"."stg_leads__dbt_tmp"
  
  
    as
  
  (
    


with source as (
    select
        *,
        ROW_NUMBER() over (
            partition by id
            order by created_at
        ) as lead_rank
    --assuming that lead id has to be unique 

    from "dbt"."public"."leads"

)

select
    id as lead_id,
    first_name as lead_first_name,
    last_name as lead_last_name,
    job_title as lead_job_title,
    company as lead_company,
    LOWER(TRIM(email)) as lead_email,
    CAST(created_at as date) as lead_created_at,
    CAST(converted_at as date) as lead_converted_at,
    NULLIF(source, '') as lead_source,
    NULLIF(country, '') as lead_country,
    NULLIF(city, '') as lead_city,
    NULLIF(state, '') as lead_state,
    NULLIF(industry, '') as lead_industry,
    NULLIF(fleet_size, '') as lead_fleet_size
from source
where lead_rank = 1  -- To select the latest lead id 
-- and email is not null -- not adding since contacts table may have
and email not like '%test'
  );
  