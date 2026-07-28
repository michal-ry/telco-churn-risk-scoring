import logging

from telco_churn.pipeline import run_data_preparation_pipeline


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format=(
            "%(asctime)s | %(levelname)s | %(name)s | "
            "%(message)s"
        ),
        datefmt="%d-%m-%Y %H:%M:%S",
    )
    run_data_preparation_pipeline()