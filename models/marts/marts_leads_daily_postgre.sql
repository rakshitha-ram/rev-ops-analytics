
  
    

  create  table "dbt"."public"."marts_leads_daily_postgre__dbt_tmp"
  
  
    as
  
  (
    


with date_spine as (
    select
        generate_series(
            date '2021-04-01',
            date '2022-04-01',
            interval '1 day'
        )::date as date_day
)
,

int_dim_leads as (
    select
        lead_id,
        lead_age_days,
        lead_source,
        lead_created_at,
        lead_converted_at,
        contact_id,
        opportunity_id,
        account_id,
        is_conv_sales
    from "dbt"."public"."int_dim_leads"
),

int_contacts as (
    select
        contact_id,
        is_primary_contact,
        contact_created_at
    from "dbt"."public"."int_dim_contacts"
),

int_accounts as (
    select 
        account_id,
        account_fleet_size,
        account_country,
        account_city,
        account_state
    from "dbt"."public"."int_dim_accounts"
),

int_opportunities as (
    select
        opportunity_id,
        opportunity_created_at,
        opportunity_closed_at,
        opportunity_is_won,
        opportunity_is_closed,
        account_id
    from "dbt"."public"."int_dim_opportunities"
),

-- Combine all date and id joins in one CTE
combined_with_date_spine as (
    select 
        DATE(d.date_day) as date_ref,
        l.lead_id,
        l.lead_source,
        l.lead_age_days,
        l.lead_created_at,
        l.lead_converted_at,
        a.account_id,  
        o.opportunity_id,
        o.opportunity_created_at,
        o.opportunity_closed_at,
        o.opportunity_is_won,
        o.opportunity_is_closed,
        c.contact_id,
        c.is_primary_contact,
        a.account_fleet_size,
        a.account_country,
        a.account_city,
        a.account_state,
        l.is_conv_sales,
        o_closed.opportunity_id as o_closed_opportunity_id,

        -- Time differences in days
         l.lead_converted_at - c.contact_created_at as time_to_convert_lead_to_contact,
         o.opportunity_created_at - c.contact_created_at as time_to_contact_lead_to_opportunity,
         o.opportunity_closed_at - o.opportunity_created_at as time_for_opportunity_close

    from date_spine d
    left join int_dim_leads l
        on DATE(l.lead_created_at) = DATE(d.date_day)
    left join int_opportunities o
        on DATE(o.opportunity_created_at) = d.date_day
    left join int_contacts c
        on DATE(c.contact_created_at) = d.date_day
    left join int_accounts a
        on a.account_id = l.account_id
    left join int_opportunities o_closed
        on DATE(o_closed.opportunity_closed_at) = d.date_day
        and o_closed.opportunity_is_won = true
        and o_closed.opportunity_is_closed = true
        and o_closed.account_id = l.account_id
),

--select * from combined_with_date_spine 

lead_summary_with_counts as (
    select
        date_ref,
        lead_created_at,
        lead_converted_at,
        opportunity_closed_at,
        opportunity_created_at,
        lead_source,
        account_id,
        account_fleet_size,
        account_country,
        account_city,
        account_state,
        

        -- Counts
        COUNT(DISTINCT lead_id) as total_lead_count,
        COUNT(DISTINCT CASE WHEN is_conv_sales = true THEN lead_id END) as total_closed_to_sales,
        COUNT(DISTINCT opportunity_id) as total_opportunity_count,
        COUNT(DISTINCT o_closed_opportunity_id) as total_closed_won_opportunity_count,
        COUNT(DISTINCT contact_id) as total_contact_count,

        -- Average durations
        AVG(time_to_convert_lead_to_contact) as avg_time_to_convert_lead_to_contact,
        AVG(time_to_contact_lead_to_opportunity) as avg_time_to_contact_lead_to_opportunity,
        AVG(time_for_opportunity_close) as avg_time_for_opportunity_close,

        -- Ratios
        CASE 
            WHEN COUNT(DISTINCT lead_id) = 0 THEN 0
            ELSE COUNT(DISTINCT CASE WHEN is_conv_sales = true THEN lead_id END)::float / COUNT(DISTINCT lead_id)
        END as lead_conversion_ratio,

        CASE 
            WHEN COUNT(DISTINCT lead_id) = 0 THEN 0
            ELSE COUNT(DISTINCT contact_id)::float / COUNT(DISTINCT lead_id)
        END as lead_to_contact_ratio,

        CASE 
            WHEN COUNT(DISTINCT contact_id) = 0 THEN 0
            ELSE COUNT(DISTINCT opportunity_id)::float / COUNT(DISTINCT contact_id)
        END as contact_to_opportunity_ratio,

        CASE 
            WHEN COUNT(DISTINCT opportunity_id) = 0 THEN 0
            ELSE COUNT(DISTINCT o_closed_opportunity_id)::float / COUNT(DISTINCT opportunity_id)
        END as closed_won_to_opportunity_ratio

    from combined_with_date_spine
    group by 
     date_ref,
        lead_created_at,
        lead_converted_at,
        opportunity_closed_at,
        opportunity_created_at,
        lead_source,
        account_id,
        account_fleet_size,
        account_country,
        account_city,
        account_state
       
       
)

select * 
from lead_summary_with_counts
  );
  