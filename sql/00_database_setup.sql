-- Database setup and validation queries

-- Purpose:
-- Validate the imported Telco Customer Churn CSV table 
-- before creating a clean final table for SQL analysis.

-- Source table:
-- churn
--
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