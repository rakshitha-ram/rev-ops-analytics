# Revenue Operations Analytics Model (dbt)

## Overview

This project builds a dbt-based analytics model for Revenue Operations (RevOps) data. It transforms raw CRM-style data into structured datasets for analysis and reporting.

---

## Data

The project uses four CSV datasets loaded as dbt seeds:

- leads
- contacts
- accounts
- opportunities

---

## Data Model

The data represents a simplified CRM workflow:

- Leads are created from multiple sources
- Leads may convert into contacts, accounts, and opportunities
- Opportunities progress through a pipeline and are marked as open/closed and won/lost

---

## Transformations

The dbt project includes the following layers:

### Seeds
- Load raw CSV files as source tables

### Staging Models
- Standardize column names
- Clean and format data types
- Prepare raw data for modeling

### Intermediate Models
- Join leads, contacts, accounts, and opportunities
- Deduplicate and standardize relationships
- Build unified datasets for analysis

### Mart Models
- Create analytics-ready tables for reporting:
  - Lead conversion metrics by time grain (day, week, month)
  - Lead source performance analysis
  - Opportunity outcome analysis
  - Account-level summaries

---

## Outputs

The final models support analysis of:

- Lead conversion trends over time
- Conversion performance by lead source
- Opportunity win/loss outcomes
- Funnel progression across CRM objects

---

## Tools Used

- dbt
- SQL
- CSV seed data