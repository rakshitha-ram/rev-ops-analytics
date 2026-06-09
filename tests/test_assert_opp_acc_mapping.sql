select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- tests/one_account_per_opportunity.sql
SELECT
    opportunity_id
FROM "dbt"."public"."stg_opportunities"
GROUP BY opportunity_id
HAVING COUNT(DISTINCT account_id) > 1
      
    ) dbt_internal_test