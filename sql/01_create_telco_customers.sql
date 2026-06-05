-- Create final SQL analysis table

-- Purpose:
-- Create a clean final table for SQL analysis based on validation results.
-- Convert selected columns to numeric types: senior_citizen, tenure, monthly_charges, total_charges.
-- Convert empty total_charges values to 0 based on validation finding.

-- Source table:
-- churn

-- Final analysis table:
-- telco_customers


-- Drop existing final table to make this script re-runnable.

drop table if exists telco_customers;

-- Create clean final table for SQL analysis

create table telco_customers as
select
customer_id,
gender,
cast(senior_citizen as integer) as senior_citizen,
partner,
dependents,
cast(tenure as integer) as tenure,
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
payment_method,
cast(monthly_charges as numeric) as monthly_charges,
cast(
case
	when trim(total_charges) = '' and tenure = '0' then '0'
	else total_charges
end as numeric
) as total_charges,
churn
from churn;

-- Validation: compare row counts between raw and final table

select
(select count(*) from churn) as churn_rows,
(select count(*) from telco_customers) as telco_customers_rows,
((select count(*) from churn) - (select count(*) from telco_customers)) as row_count_diff;

-- Validation: verify that empty total_charges values were converted to 0

select
c.customer_id,
c.total_charges as churn_total_charges,
tc.total_charges as telco_customers_total_charges
from churn c
inner join telco_customers tc
on c.customer_id = tc.customer_id
where trim(c.total_charges) = '';

-- Validation: verify that converted columns have expected numeric data types

select
column_name,
data_type
from information_schema.columns
where
table_name = 'telco_customers' and
column_name in ('senior_citizen', 'tenure', 'monthly_charges', 'total_charges')
order by column_name;