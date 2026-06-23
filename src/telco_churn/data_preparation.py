import pandas as pd
from sqlalchemy import create_engine

def load_telco_customers_from_db(db_url):

    """
    Load telco customers table from a database.
    
    Arg:
        db_url: SQLAlchemy database URL.

    Returns:
        pd.DataFrame: DataFrame with telco customer data.

    Raise:
        ValueError: If db_url is None or empty.

    """

    if db_url is None or db_url.strip() == "":
        raise ValueError("db_url cannot be None or empty.")

    engine = create_engine(db_url)
    query = "SELECT * FROM telco_customers"

    return pd.read_sql(query, engine)