import pandas as pd
from sqlalchemy import create_engine

def load_telco_customers_from_db(db_url):

    """
    Load telco customers table from a database.
    
    Args:
        db_url: SQLAlchemy database URL.

    Returns:
        pd.DataFrame: DataFrame with telco customer data.

    Raises:
        ValueError: If db_url is None or empty.
        TypeError: If db_url is not a string.

    """

    if db_url is None:
        raise ValueError("db_url cannot be None.")
    
    if not isinstance(db_url, str):
        raise TypeError("db_url must be a string.")
    
    if db_url.strip() == "":
        raise ValueError("db_url cannot be an empty string.")

    engine = create_engine(db_url)
    query = "SELECT * FROM telco_customers"

    return pd.read_sql(query, engine)