select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      with source_leads as (
    select count(lead_id) as s_leads
    from "dbt"."public"."stg_leads"
),

dim_leads as (
    select count(lead_id) as d_leads
    from "dbt"."public"."int_dim_leads"
)

select 
    s_leads,
    d_leads
from source_leads, dim_leads
where s_leads != d_leads
      
    ) dbt_internal_test