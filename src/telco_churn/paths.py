from pathlib import Path


# Project root
PROJECT_ROOT = Path(__file__).resolve().parents[2]

# Data
PROCESSED_DATA_DIR = PROJECT_ROOT / 'data' / 'processed'
TELCO_CUSTOMERS_CLEAN_PATH = PROCESSED_DATA_DIR / 'telco_customers_clean.csv'
TELCO_CUSTOMERS_TRAIN_PATH = PROCESSED_DATA_DIR / 'telco_customers_train.csv'
TELCO_CUSTOMERS_TEST_PATH = PROCESSED_DATA_DIR / 'telco_customers_test.csv'

# Plots
FIGURES_DIR = PROJECT_ROOT / 'reports' / 'figures'
DATA_LOADING_VALIDATION_FIGURES_DIR = FIGURES_DIR / 'data_loading_validation'
TRAIN_TEST_SPLIT_FIGURES_DIR = FIGURES_DIR / 'train_test_split'