# Revenue Operations Analytics Platform

## Overview

This project simulates the work of an Analytics Engineer at a high-growth B2B SaaS company.

The goal is to build a modern Revenue Operations analytics platform that provides Marketing, Sales, Customer Success, and Leadership with a single source of truth for business metrics.

The project demonstrates an end-to-end analytics workflow using BigQuery, dbt, Looker, Hightouch, and modern data modeling practices.

---

# Business Scenario

## Company

NimbusCRM

NimbusCRM is a B2B SaaS company that provides customer relationship management software for small and medium-sized businesses through a monthly subscription model.

The company has experienced rapid growth but struggles with inconsistent reporting across departments.

Different teams calculate revenue, pipeline, and conversion metrics differently, making it difficult for leadership to make informed decisions.

The objective of this project is to centralize business metrics into a trusted analytics platform.

---

# Stakeholders

This platform is designed for:

- CEO
- CRO (Chief Revenue Officer)
- VP Marketing
- Sales Managers
- Sales Representatives
- Customer Success Managers
- Finance Team

---

# Business Questions

## Marketing

- Which marketing channels generate the highest quality leads?
- Which campaigns create the most sales pipeline?
- What is the lead-to-opportunity conversion rate?
- What is the customer acquisition cost (CAC)?
- Which industries respond best to marketing campaigns?

## Sales

- Which sales representatives close the most revenue?
- Where do opportunities stall within the sales funnel?
- What is the average sales cycle?
- What is the current pipeline coverage?
- What are the most common lost reasons?

## Customer Success

- Which customers have the highest product engagement?
- Which accounts are at risk of churn?
- Which customers are candidates for expansion opportunities?

## Executive Leadership

- Monthly Recurring Revenue (MRR)
- Annual Recurring Revenue (ARR)
- Pipeline Growth
- Win Rate
- Forecast Accuracy
- Revenue by Industry
- Revenue by Customer Segment
- Revenue by Region

---

# Success Metrics

## Marketing KPIs

- Leads
- Marketing Qualified Leads (MQL)
- Sales Qualified Leads (SQL)
- Lead Conversion Rate
- Cost per Lead (CPL)
- Customer Acquisition Cost (CAC)

## Sales KPIs

- Pipeline Value
- Pipeline Coverage
- Win Rate
- Sales Cycle Length
- Opportunity Conversion Rate
- Average Deal Size

## Customer Success KPIs

- Customer Health Score
- Product Adoption
- Expansion Revenue
- Churn Rate

## Revenue KPIs

- Monthly Recurring Revenue (MRR)
- Annual Recurring Revenue (ARR)
- Net Revenue Retention (NRR)
- Gross Revenue
- Average Revenue per Account (ARPA)

---

# Technology Stack

| Layer | Technology |
|--------|------------|
| Data Warehouse | BigQuery |
| Data Transformation | dbt |
| Version Control | Git & GitHub |
| Data Visualization | Looker |
| Reverse ETL | Hightouch (simulated) |
| Data Ingestion | Simulated Fivetran |
| Documentation | dbt Docs & Markdown |

---

# High-Level Architecture

```
CRM System
Marketing Platform
Billing System
Product Usage Events

        │
        ▼

Raw Data (BigQuery)

        │
        ▼

dbt Staging Models

        │
        ▼

Intermediate Business Models

        │
        ▼

Fact & Dimension Models

        │
        ▼

Looker Dashboards

        │
        ▼

Hightouch Reverse ETL

        │
        ▼

CRM / Sales Tools
```

---

# Planned Data Models

## Staging

- stg_leads
- stg_contacts
- stg_accounts
- stg_opportunities
- stg_campaigns
- stg_subscriptions
- stg_product_usage

## Intermediate

- int_lead_funnel
- int_pipeline
- int_account_health
- int_subscription_metrics

## Dimensions

- dim_accounts
- dim_date
- dim_sales_rep
- dim_campaign
- dim_industry

## Facts

- fct_pipeline
- fct_revenue
- fct_marketing
- fct_customer_health

---

# Dashboards

## Executive Dashboard

- ARR
- MRR
- Pipeline
- Forecast
- Win Rate
- Revenue Trends

## Marketing Dashboard

- Lead Funnel
- Campaign Performance
- Channel Attribution
- CAC
- Conversion Rates

## Sales Dashboard

- Pipeline by Stage
- Rep Performance
- Sales Cycle
- Deal Size
- Lost Reasons

## Customer Success Dashboard

- Customer Health
- Product Adoption
- Expansion Opportunities
- Churn Risk

---

# Project Goals

By completing this project, I will demonstrate:

- Analytics Engineering using dbt
- Dimensional Data Modeling
- SQL transformation best practices
- BigQuery data warehousing
- Data quality testing
- Dashboard development in Looker
- Reverse ETL concepts using Hightouch
- Business-focused analytics and storytelling
- Documentation and version control following modern data engineering practices