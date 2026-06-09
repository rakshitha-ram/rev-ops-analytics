
  
    

  create  table "dbt"."public"."stg_contacts__dbt_tmp"
  
  
    as
  
  (
    

with ranked_contacts as (
    select
        id as contact_id,
        job_title as contact_job_title,
        email as contact_email,
        account_id,
        lead_id,
        cast(created_at as date) as contact_created_at,
        -- we want 1-1 mapping for lead and contact id
        row_number() over (
            partition by lead_id
            order by created_at desc
        ) as contact_rank
    from "dbt"."public"."contacts"
    where
        id is not null
        and email not like '%test%'
        and email is not null
)

select
    contact_id,
    contact_job_title,
    contact_email,
    account_id,
    lead_id,
    contact_created_at
from ranked_contacts
where contact_rank = 1
  );
  