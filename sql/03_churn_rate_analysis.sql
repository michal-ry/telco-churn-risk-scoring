-- Churn rate analysis

-- Purpose:
-- Analyze churn patterns across numeric and categorical features.
-- Compare numeric column averages and medians by churn status.
-- Calculate churn rate for each categorical feature group and compare it with the overall churn rate.
-- Identify customer segments with elevated churn risk.

-- Source table:
-- telco_customers

-- Create a view with baseline churn rate

create or replace view baseline_churn_rate as
select
avg(case
	when churn = 'Yes' then 1
	else 0
end) as overall_churn_rate
from telco_customers;

-- Baseline churn rate

select round(overall_churn_rate * 100, 2) as churn_rate_pct
from baseline_churn_rate;

-- Result: baseline churn rate: 26.54%

-- Numeric feature comparison by churn status

-- Tenure statistics for churn groups

select
churn,
count(*) as customers_count,
round(avg(tenure), 2) as tenure_avg,
percentile_cont(0.5) within group (order by tenure) as tenure_median
from telco_customers
group by churn
order by churn;

-- Monthly charges statistics for churn groups

select
churn,
count(*) as customers_count,
round(avg(monthly_charges), 2) as monthly_charges_avg,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median
from telco_customers
group by churn
order by churn;

-- Total charges statistics for churn groups

select
churn,
count(*) as customers_count,
round(avg(total_charges), 2) as total_charges_avg,
percentile_cont(0.5) within group (order by total_charges) as total_charges_median
from telco_customers
group by churn
order by churn;