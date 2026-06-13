-- Churn rate analysis

-- Purpose:
-- Analyze churn patterns across numeric and categorical features.
-- Compare numeric column averages and medians by churn status.
-- Calculate churn rate for each categorical feature group and compare it with the overall churn rate.
-- Identify customer segments with elevated churn risk.

-- Source table:
-- telco_customers

-- Views

-- Baseline churn rate view

create or replace view baseline_churn_rate as
select
avg(case
	when churn = 'Yes' then 1
	else 0
end) as overall_churn_rate
from telco_customers;

-- Categorical churn analysis helper view
-- Info: column senior_citizen is converted to categorical using this pattern: 1 = 'Yes' and 0 = 'No'

create or replace view telco_categorical_churn_helper as
select
customer_id,
case
	when churn = 'Yes' then 1
	else 0
end as is_churned,
gender,
case 
	when senior_citizen = 1 then 'Yes'
	else 'No'
end as senior_citizen_converted,
partner,
dependents,
phone_service,
multiple_lines,
internet_service,
online_security,
online_backup,
device_protection,
tech_support,
streaming_tv,
streaming_movies,
contract,
paperless_billing,
payment_method
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