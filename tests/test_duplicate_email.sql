select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

select lead_email
from "dbt"."public"."stg_leads"
group by lead_email
having count(lead_id) > 5  -- At most, an email should appear across 5 lead sources
      
    ) dbt_internal_test