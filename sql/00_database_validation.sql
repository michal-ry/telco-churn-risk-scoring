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
order by churn_unique;

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

-- 7. Check unique values in gender
-- Purpose: verify that gender contains only 'Female' and 'Male' values.

select
distinct gender as gender_unique
from churn
order by gender_unique;

-- 8. Check unique values in partner
-- Purpose: verify that partner contains only 'No' and 'Yes' values.

select
distinct partner as partner_unique
from churn
order by partner_unique;

-- 9. Check unique values in dependents
-- Purpose: verify that dependents contains only 'No' and 'Yes' values.

select
distinct dependents as dependents_unique
from churn
order by dependents_unique;

-- 10. Check unique values in phone_service
-- Purpose: verify that phone_service contains only 'No' and 'Yes' values.

select
distinct phone_service as phone_service_unique
from churn
order by phone_service_unique;

-- 11. Check unique values in multiple_lines
-- Purpose: verify that multiple_lines contains only 'No', 'No Phone service' and 'Yes' values.

select
distinct multiple_lines as multiple_lines_unique
from churn
order by multiple_lines_unique;

-- 12. Check unique values in internet_service
-- Purpose: verify that internet_service contains only 'DSL', 'Fiber optic' and 'No' values.

select
distinct internet_service as internet_service_unique
from churn
order by internet_service_unique;

-- 13. Check unique values in online_security
-- Purpose: verify that online_security contains only 'No', 'No internet service' and 'Yes' values.

select
distinct online_security as online_security_unique
from churn
order by online_security_unique;

-- 14. Check unique values in online_backup
-- Purpose: verify that online_backup contains only 'No', 'No internet service' and 'Yes' values.

select
distinct online_backup as online_backup_unique
from churn
order by online_backup_unique;

-- 15. Check unique values in device_protection
-- Purpose: verify that device_protection contains only 'No', 'No internet service' and 'Yes' values.

select
distinct device_protection as device_protection_unique
from churn
order by device_protection_unique;

-- 16. Check unique values in tech_support
-- Purpose: verify that tech_support contains only 'No', 'No internet service' and 'Yes' values.

select
distinct tech_support as tech_support_unique
from churn
order by tech_support_unique;

-- 17. Check unique values in streaming_tv
-- Purpose: verify that streaming_tv contains only 'No', 'No internet service' and 'Yes' values.

select
distinct streaming_tv as streaming_tv_unique
from churn
order by streaming_tv_unique;

-- 18. Check unique values in streaming_movies
-- Purpose: verify that streaming_movies contains only 'No', 'No internet service' and 'Yes' values.

select
distinct streaming_movies as streaming_movies_unique
from churn
order by streaming_movies_unique;

-- 19. Check unique values in contract
-- Purpose: verify that contract contains only 'Month-to-month', 'One year' and 'Two year' values.

select
distinct contract as contract_unique
from churn
order by contract_unique;

-- 20. Check unique values in paperless_billing
-- Purpose: verify that paperless_billing contains only 'No' and 'Yes' values.

select
distinct paperless_billing as paperless_billing_unique
from churn
order by paperless_billing_unique;

-- 21. Check unique values in payment_method
-- Purpose: verify that payment_method contains only:
-- 'Bank transfer (automatic)', 'Credit card (automatic)', 'Electronic check' and 'Mailed check' values.

select
distinct payment_method as payment_method_unique
from churn
order by payment_method_unique;