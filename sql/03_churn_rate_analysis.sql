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

-- Churn rate categorical features

-- Gender

select
gender,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by gender
order by churn_rate_pct desc;

-- Senior Citizen

select
senior_citizen_converted,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by senior_citizen_converted
order by churn_rate_pct desc;

-- Result:
-- Senior citizen churn rate: 41.68% (+15.14 pp vs baseline)
-- Non-senior citizen churn rate: 23.61% (-2.93 pp vs baseline)

-- Partner

select
partner,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by partner
order by churn_rate_pct desc;

-- Result:
-- With partner churn rate: 19.66% (-6.87 pp vs baseline)
-- Without partner churn rate: 32.96% (+6.42 pp vs baseline)

-- Dependents

select
dependents,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by dependents
order by churn_rate_pct desc;

-- Result:
-- With dependents churn rate: 15.45% (-11.09 pp vs baseline)
-- Without dependents churn rate: 31.28% (+4.74 pp vs baseline)

-- Phone service

select
phone_service,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by phone_service
order by churn_rate_pct desc;

-- Multiple lines

select
multiple_lines,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by multiple_lines
order by churn_rate_pct desc;

-- Internet service

select
internet_service,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by internet_service
order by churn_rate_pct desc;

-- Result:
-- Fiber optic churn rate: 41.89% (+15.36 pp vs baseline)
-- DSL churn rate: 18.96% (-7.58 pp vs baseline)
-- No internet churn rate: 7.40% (-19.13 pp vs baseline)

-- Online security

select
online_security,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by online_security
order by churn_rate_pct desc;

-- Result:
-- No online security churn rate: 41.77% (+15.23 pp vs baseline)
-- With online security churn rate: 14.61% (-11.93 pp vs baseline)

-- Online backup

select
online_backup,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by online_backup
order by churn_rate_pct desc;

-- Result:
-- No online backup churn rate: 39.93% (+13.39 pp vs baseline)
-- With online backup churn rate: 21.53% (-5.01 pp vs baseline)

-- Device protection

select
device_protection,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by device_protection
order by churn_rate_pct desc;

-- Result:
-- No device protection churn rate: 39.13% (+12.59 pp vs baseline)
-- With device protection churn rate: 22.50% (-4.03 pp vs baseline)

-- Tech support

select
tech_support,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by tech_support
order by churn_rate_pct desc;

-- Result:
-- No tech support churn rate: 41.64% (+15.10 pp vs baseline)
-- With tech support churn rate: 15.17% (-11.37 pp vs baseline)

-- Streaming tv

select
streaming_tv,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by streaming_tv
order by churn_rate_pct desc;

-- Result:
-- No streaming tv churn rate: 33.52% (+6.99 pp vs baseline)
-- With streaming tv churn rate: 30.07% (+3.53 pp vs baseline)

-- Streaming movies

select
streaming_movies,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by streaming_movies
order by churn_rate_pct desc;

-- Result:
-- No streaming movies churn rate: 33.68% (+7.14 pp vs baseline)
-- With streaming movies churn rate: 29.94% (+3.40 pp vs baseline)

-- Contract

select
contract,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by contract
order by churn_rate_pct desc;

-- Result:
-- Month-to-month churn rate: 42.71% (+16.17 pp vs baseline)
-- One year churn rate: 11.27% (-15.27 pp vs baseline)
-- Two year churn rate: 2.83% (-23.71 pp vs baseline)

-- Paperless billing

select
paperless_billing,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by paperless_billing
order by churn_rate_pct desc;

-- Result:
-- With paperless billing churn rate: 33.57% (+7.03 pp vs baseline)
-- Without paperless billing churn rate: 16.33% (-10.21 pp vs baseline)

-- Payment method

select
payment_method,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(is_churned) * 100 - (select overall_churn_rate * 100 from baseline_churn_rate), 2) as churn_rate_diff_pp
from telco_categorical_churn_helper
group by payment_method
order by churn_rate_pct desc;

-- Result:
-- Electronic check churn rate: 45.29% (+18.75 pp vs baseline)
-- Mailed check churn rate: 19.11% (-7.43 pp vs baseline)
-- Bank transfer (automatic) churn rate: 16.71% (-9.83 pp vs baseline)
-- Credit card (automatic) churn rate: 15.24% (-11.29 pp vs baseline)