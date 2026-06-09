select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select contact_email
from "dbt"."public"."int_dim_contacts"
where contact_email is null



      
    ) dbt_internal_test