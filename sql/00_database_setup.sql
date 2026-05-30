-- Database setup and validation queries

-- Purpose:
-- Validate the imported Telco Customer Churn CSV table 
-- before creating a clean final table for SQL analysis.

-- Source table:
-- churn

-- Final analysis table:
-- telco_customers


-- 1. Check customer_id uniqueness
-- Purpose: verify that each row represents one unique customer.

select
count(*) as total_rows,
count(distinct customer_id) as customer_id_unique,
count(*) - count(distinct customer_id) as duplicate_rows_count
from churn;

-- 2. Check unique values in churn
-- Purpose: verify that churn contains only 'Yes' and 'No' values.

select
distinct churn as churn_unique
from churn
group by churn_unique;

-- 3. Check senior_citizen values
-- Purpose: Make sure that column values are ready to convert to integer:
--          Unique values should be '0' and '1'.

select
distinct senior_citizen as senior_citizen_unique
from churn
order by senior_citizen_unique;

-- 4. Check tenure values
-- Purpose: Make sure that column values are ready to convert to integer:
--          values should not be empty,
--          values should represent whole numbers only.

select
(select
count(*) as empty_strings_count
from churn
where trim(tenure) = '') as tenure_empty_strings_total,
(select
count(*) as not_integer_values_count
from churn
where trim(tenure) !~ '^[0-9]+$' 
and trim(tenure) <> '') as tenure_not_integer_values_total;

-- 5. Check monthly_charges values
-- Purpose: Make sure that column values are ready to convert to numeric type:
--          values should not be empty,
--          values should represent whole or decimal numbers only.

select
(select
count(*) as empty_strings_count
from churn
where trim(monthly_charges) = '') as monthly_charges_empty_strings_total,
(select
count(*) as not_numeric_values_count
from churn
where trim(monthly_charges) !~ '^[0-9]+(\.[0-9]+)?$'
and trim(monthly_charges) <> '') as monthly_charges_not_numeric_values_total;

-- 6. Check total_charges values
-- Purpose: Make sure that column values are ready to convert to numeric type:
--          values should not be empty,
--          values should represent whole or decimal numbers only.

select
(select
count(*) as empty_strings_count
from churn
where trim(total_charges) = '') as total_charges_empty_strings_total,
(select
count(*) as not_numeric_values_count
from churn
where trim(total_charges) !~ '^[0-9]+(\.[0-9]+)?$'
and trim(total_charges) <> '') as total_charges_not_numeric_values_total;

-- Finding: total_charges contains 11 empty strings.
-- Next check: verify whether empty total_charges occurs only when tenure = '0'.

select
(select
count(*) as empty_strings_count
from churn
where trim(total_charges) = '') as total_charges_empty_strings_total,
(select
count(*) as empty_strings_with_zero_tenure_count
from churn
where trim(total_charges) = ''
and trim(tenure) = '0'
) as total_charges_empty_strings_with_zero_tenure_total,
(select
count(*) as total_charges_with_non_zero_tenure_count
from churn
where trim(total_charges) = ''
and trim(tenure) <> '0') as total_charges_empty_strings_with_non_zero_tenure_total;

-- Finding: total_charges empty strings occur only when tenure = '0'.
-- Decision: convert empty total_charges values to 0 when creating the final telco_customers table.