select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select account_id
from "dbt"."public"."int_dim_opportunities"
where account_id is null



      
    ) dbt_internal_test