# SQL
SQL_TABLE = 'telco_customers'

# Columns
TARGET_COLUMN = 'churn'
ID_COLUMN = 'customer_id'
BINARY_COLUMN = 'senior_citizen'
CATEGORICAL_COLUMNS = (
    'gender',
    'partner',
    'dependents',
    'phone_service',
    'multiple_lines',
    'internet_service',
    'online_security',
    'online_backup',
    'device_protection',
    'tech_support',
    'streaming_tv',
    'streaming_movies',
    'contract',
    'paperless_billing',
    'payment_method',
)
NUMERICAL_COLUMNS = (
    'tenure',
    'monthly_charges',
    'total_charges',
)

# Train-test split
TEST_SIZE = 0.2
RANDOM_STATE = 42