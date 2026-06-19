-- Customer segments analysis

-- Purpose:
-- Identify customer segments by combining high-impact churn features:
-- contract, internet service, dependents, and tech support.
-- Compare segment size, churn rate, median monthly charges,
-- and estimated monthly revenue at risk.

-- Source table:
-- telco_financial_impact_helper

-- Segment: contract + internet service

select
contract,
internet_service,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by contract, internet_service
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: month-to-month contract + fiber optic internet
-- Churned customers: 1162
-- Churn rate: 54.61%
-- Median monthly charge: $86.00
-- Estimated monthly revenue at risk: ~$99,932.00

-- Segment: contract + dependents

select
contract,
dependents,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by contract, dependents
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: month-to-month contract + no dependents
-- Churned customers: 1396
-- Churn rate: 45.24%
-- Median monthly charge: $74.37
-- Estimated monthly revenue at risk: ~$103,827.50

-- Segment: contract + tech support

select
contract,
tech_support,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by contract, tech_support
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: month-to-month contract + no tech support
-- Churned customers: 1350
-- Churn rate: 50.37%
-- Median monthly charge: $75.60
-- Estimated monthly revenue at risk: ~$102,060.00

-- Segment: internet service + dependents

select
internet_service,
dependents,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by internet_service, dependents
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: fiber optic internet + no dependents
-- Churned customers: 1095
-- Churn rate: 44.99%
-- Median monthly charge: $90.65
-- Estimated monthly revenue at risk: ~$99,261.75

-- Segment: internet service + tech support

select
internet_service,
tech_support,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by internet_service, tech_support
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: fiber optic internet + no tech support
-- Churned customers: 1101
-- Churn rate: 49.37%
-- Median monthly charge: $88.15
-- Estimated monthly revenue at risk: ~$97,053.15

-- Segment: dependents + tech support

select
dependents,
tech_support,
count(*) as customers_count,
sum(is_churned) as churn_count,
round(avg(is_churned) * 100, 2) as churn_rate_pct,
percentile_cont(0.5) within group (order by monthly_charges) as median_monthly_charges,
round(cast(sum(is_churned) * percentile_cont(0.5) within group (order by monthly_charges) as numeric), 2) as estimated_monthly_revenue_at_risk
from telco_financial_impact_helper
group by dependents, tech_support
having count(*) > 1000
order by estimated_monthly_revenue_at_risk desc;

-- Result:
-- Segment: no dependents + no tech support
-- Churned customers: 1220
-- Churn rate: 45.00%
-- Median monthly charge: $78.75
-- Estimated monthly revenue at risk: ~$96,075.00