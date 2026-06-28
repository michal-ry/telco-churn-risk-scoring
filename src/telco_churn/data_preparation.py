import pandas as pd
from sqlalchemy import create_engine
import os

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

def save_dataframe_to_csv(df, path, file_name):

    '''
    Save a pandas DataFrame to a CSV file. 

    Args:
        df: pandas DataFrame to save.
        path: Path to the folder where the DataFrame will be saved.
        file_name: Name of the saved DataFrame file without extension.

    Returns:
        full_path: full path to the saved CSV file.

    Raises:
        TypeError: If df is not a pandas DataFrame.
        TypeError: If path or file_name is not a string.
        ValueError: If path or file_name is an empty string.
        ValueError: If file_name ends with a '.csv'.

    Example:
        >>> save_dataframe_to_csv(df=df, path='data/processed', file_name='clean_df')
        'data/processed/clean_df.csv'
    '''

    if not isinstance(df, pd.DataFrame):
        raise TypeError('df input must be a pandas DataFrame.')

    if not isinstance(path, str):
        raise TypeError('path must be in a string format.')

    if not path.strip():
        raise ValueError('path cannot be an empty string.')

    if not isinstance(file_name, str):
        raise TypeError('file_name must be in a string format.')

    if not file_name.strip():
        raise ValueError('file_name cannot be an empty string.')

    if file_name.endswith('.csv'):
        raise ValueError('file_name should not end with `.csv` extension.')
        
    os.makedirs(path, exist_ok=True)

    full_path = os.path.join(path, f'{file_name}.csv')

    df.to_csv(full_path, index=False)

    return full_path