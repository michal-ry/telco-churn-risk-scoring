import logging
import os

from dotenv import load_dotenv

from telco_churn.config import (
    RANDOM_STATE,
    SQL_TABLE,
    TARGET_COLUMN,
    TEST_SIZE,
)
from telco_churn.paths import (
    TELCO_CUSTOMERS_CLEAN_PATH,
    TELCO_CUSTOMERS_TEST_PATH,
    TELCO_CUSTOMERS_TRAIN_PATH,
)
from telco_churn.data_preparation import (
    load_table_to_df,
    save_df_to_csv,
    train_test_data_split,
)
from telco_churn.toolkit_functions import (
    clean_columns,
)


logger = logging.getLogger(__name__)


def run_data_preparation_pipeline():
    """
    Load, clean, split, and save the Telco Customer Churn data.

    Loads the PostgreSQL table into a DataFrame, standardizes the column
    names, and saves the cleaned dataset. It then splits the data into
    training and test sets and saves both sets as CSV files.

    Returns:
        tuple[Path, Path]: Paths to the saved training and test datasets.
    """

    logger.info("Starting data preparation pipeline.")

    # Load table into a pandas DF using URL stored in .env
    load_dotenv()
    db_url = os.getenv("DB_URL")

    df = load_table_to_df(
        db_url=db_url,
        table_name=SQL_TABLE,
    )

    logger.info(
        "Data loaded successfully: %d rows, %d columns.",
        df.shape[0],
        df.shape[1],
    )

    # Create and save a clean dataframe that will be ready to train-test split
    df_clean = df.copy()
    df_clean = clean_columns(
        df=df_clean,
        deal_dups="rename",
    )
    save_df_to_csv(
        df=df_clean,
        path=TELCO_CUSTOMERS_CLEAN_PATH,
    )

    logger.info("Cleaned dataset saved successfully.")

    # Split and save clean_df into a training and test dataset.
    df_train, df_test = train_test_data_split(
        df=df_clean,
        test_size=TEST_SIZE,
        random_state=RANDOM_STATE,
        stratify_column=TARGET_COLUMN,
    )

    logger.info(
        "Data split successfully: %d training rows, %d test rows.",
        df_train.shape[0],
        df_test.shape[0],
    )

    df_train_path = save_df_to_csv(
        df=df_train,
        path=TELCO_CUSTOMERS_TRAIN_PATH,
    )
    df_test_path = save_df_to_csv(
        df=df_test,
        path=TELCO_CUSTOMERS_TEST_PATH,
    )

    logger.info("Training and test datasets saved successfully.")
    logger.info("Data preparation pipeline completed successfully.")

    return df_train_path, df_test_path