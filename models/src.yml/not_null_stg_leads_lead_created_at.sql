select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select lead_created_at
from "dbt"."public"."stg_leads"
where lead_created_at is null



      
    ) dbt_internal_test