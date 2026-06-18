-- Financial impact analysis

-- Purpose:
-- Compare monthly charges for features with the highest churn rate:
-- senior citizen, internet service, tech support, dependents, contract, payment method
-- Evaluate whether high-churn customer groups may also represent meaningful financial impact.

-- Source table:
-- telco_customers

-- Views

-- Financial impact analysis helper view

create or replace view telco_financial_impact_helper as
select
customer_id,
case
	when churn = 'Yes' then 1
	else 0
end as is_churned,
monthly_charges,
case
	when senior_citizen = 1 then 'Yes'
	else 'No'
end as senior_citizen_converted,
internet_service,
tech_support,
dependents,
contract,
payment_method
from telco_customers;

-- Monthly charges average overall

create or replace view telco_monthly_charges_avg_overall as
select
avg(monthly_charges) as avg_monthly_charges
from telco_financial_impact_helper;

-- Monthly charges median overall

create or replace view telco_monthly_charges_median_overall as
select
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges
from telco_financial_impact_helper;

-- Monthly charges: average and median result

-- Average 

select
round(avg_monthly_charges, 2) as avg_monthly_charges
from telco_monthly_charges_avg_overall;

-- Result: 64.76

-- Median

select
median_monthly_charges
from telco_monthly_charges_median_overall;

-- Result: 70.35

-- Contract

select
contract,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by contract
order by churn_rate_pct desc;

-- Result:
-- Contract type: month-to-month
-- Churn rate: 42.71%
-- Churned customers: 1655
-- Median monthly charges: $73.25
-- Estimated monthly revenue at risk: ~$121,228.75

-- Senior citizen

select
senior_citizen_converted,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by senior_citizen_converted
order by churn_rate_pct desc;

-- Result:
-- Senior citizen group
-- Churn rate: 41.68%
-- Churned customers: 476
-- Median monthly charges: $84.85
-- Estimated monthly revenue at risk: ~$40,388.60

-- Internet Service

select
internet_service,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by internet_service
order by churn_rate_pct desc;

-- Result:
-- Fiber optic
-- Churn rate: 41.89%
-- Churned customers: 1297
-- Median monthly charges: $91.67
-- Median monthly charges diff vs overall: +$21.32
-- Estimated monthly revenue at risk: ~$118,895.99

-- Tech support

select
tech_support,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by tech_support
order by churn_rate_pct desc;

-- Result:
-- No tech support
-- Churn rate: 41.64%
-- Churned customers: 1446
-- Median monthly charges: $78.05
-- Estimated monthly revenue at risk: ~$112,860.30

-- Dependents

select
dependents,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by dependents
order by churn_rate_pct desc;

-- Result:
-- Without dependents
-- Churn rate: 31.28%
-- Churned customers: 1543
-- Median monthly charges: $73.90
-- Estimated monthly revenue at risk: ~$114,027.70

-- Payment method

select
payment_method,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
round(avg(monthly_charges), 2) as monthly_charges_avg,
round(avg(monthly_charges) - (select avg_monthly_charges from telco_monthly_charges_avg_overall), 2) as avg_monthly_charges_diff_vs_overall,
percentile_cont(0.5) within group (order by monthly_charges) as monthly_charges_median,
percentile_cont(0.5) within group (order by monthly_charges) - (select median_monthly_charges from telco_monthly_charges_median_overall) as median_monthly_charges_diff_vs_overall
from telco_financial_impact_helper
group by payment_method
order by churn_rate_pct desc;

-- Result:
-- Method: Electronic check
-- Churn rate: 45.29%
-- Churned customers: 1071
-- Median monthly charges: $80.55
-- Estimated monthly revenue at risk: ~$86,269.05