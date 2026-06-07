-- Data Overview

-- Purpose:
-- Explore the structure of the final analysis table,
-- review the target distribution,
-- and summarize individual numeric and categorical columns.

-- Source table:
-- telco_customers

-- General overveiew

-- Columns and data types
select
column_name,
data_type
from information_schema.columns
where table_name = 'telco_customers'
order by column_name;

-- Dataset row count and customer_id uniqueness
select
count(*) as rows_count,
count(distinct customer_id) as customer_id_unique_count,
(count(*) - count(distinct customer_id)) as duplicate_rows_count
from telco_customers;

-- Target: churn

-- Churn clients per group yes/no
select
churn,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by churn
order by churn;

-- Numeric columns

-- senior_citizen
select
senior_citizen,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by senior_citizen
order by customers_count desc;

-- tenure
select
min(tenure) as tenure_min,
max(tenure) as tenure_max,
max(tenure) - min(tenure) as tenure_range,
round(avg(tenure), 2) as tenure_avg,
percentile_cont(0.5) within group (order by tenure) as tenure_median,
round(stddev_pop(tenure), 2) as tenure_std,
percentile_cont(0.25) within group (order by tenure) as tenure_q1,
percentile_cont(0.75) within group (order by tenure) as tenure_q3,
percentile_cont(0.75) within group (order by tenure) - percentile_cont(0.25) within group (order by tenure) as tenure_iqr
from telco_customers;

-- monthly_charges
select
min(monthly_charges) as monthly_charges_min,
max(monthly_charges) as monthly_charges_max,
max(monthly_charges) - min(monthly_charges) as monthly_charges_range,
round(avg(monthly_charges), 2) as monthly_charges_avg,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
round(stddev_pop(monthly_charges), 2) as monthly_charges_std,
percentile_cont(0.25) within group (order by monthly_charges) as monthly_charges_q1,
percentile_cont(0.75) within group (order by monthly_charges) as monthly_charges_q3,
percentile_cont(0.75) within group (order by monthly_charges) - percentile_cont(0.25) within group (order by monthly_charges) as monthly_charges_iqr
from telco_customers;

-- total_charges
select
min(total_charges) as total_charges_min,
max(total_charges) as total_charges_max,
max(total_charges) - min(total_charges) as total_charges_range,
round(avg(total_charges), 2) as total_charges_avg,
percentile_cont(0.5) within group (order by total_charges) as total_charges_median,
round(stddev_pop(total_charges), 2) as total_charges_std,
percentile_cont(0.25) within group (order by total_charges) as total_charges_q1,
percentile_cont(0.75) within group (order by total_charges) as total_charges_q3,
percentile_cont(0.75) within group (order by total_charges) - percentile_cont(0.25) within group (order by total_charges) as total_charges_iqr
from telco_customers;

-- Categorical columns

-- gender
select
gender,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by gender
order by customers_count desc;

-- partner
select
partner,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by partner
order by customers_count desc;

-- dependents
select
dependents,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by dependents
order by customers_count desc;

-- phone_service
select
phone_service,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by phone_service
order by customers_count desc;

-- multiple_lines
select
multiple_lines,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by multiple_lines
order by customers_count desc;

-- internet_service
select
internet_service,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by internet_service
order by customers_count desc;

-- online_security
select
online_security,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by online_security
order by customers_count desc;

-- online_backup
select
online_backup,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by online_backup
order by customers_count desc;

-- device_protection
select
device_protection,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by device_protection
order by customers_count desc;

-- tech_support
select
tech_support,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by tech_support
order by customers_count desc;

-- streaming_tv
select
streaming_tv,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by streaming_tv
order by customers_count desc;

-- streaming_movies
select
streaming_movies,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by streaming_movies
order by customers_count desc;

-- contract
select
contract,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by contract
order by customers_count desc;

-- paperless_billing
select
paperless_billing,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by paperless_billing
order by customers_count desc;

-- payment_method
select
payment_method,
count(*) as customers_count,
round(cast(count(*) as numeric) / (select count(*) from telco_customers) * 100, 2) as customers_pct
from telco_customers
group by payment_method
order by customers_count desc;