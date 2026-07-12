import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

def load_table_to_df(db_url, table_name):

    """
    Load table or view from a SQL database and return pandas DataFrame.
    
    Args:
        db_url: SQLAlchemy database URL.
        table_name (str): Name of the SQL table or view to load.

    Returns:
        pd.DataFrame: DataFrame containing data from the selected table or view.

    Raises:
        ValueError: If `db_url` or `table_name` is None or empty.
        TypeError: If `db_url` or `table_name` is not a string.
    """

    if db_url is None:
        raise ValueError("db_url cannot be None.")
    
    if not isinstance(db_url, str):
        raise TypeError("db_url must be a string.")
    
    if db_url.strip() == "":
        raise ValueError("db_url cannot be an empty string.")
    
    if table_name is None:
        raise ValueError("table_name cannot be None.")
    
    if not isinstance(table_name, str):
        raise TypeError("table_name must be a string.")
    
    if table_name.strip() == "":
        raise ValueError("table_name cannot be an empty string.")

    engine = create_engine(db_url)
    query = f"SELECT * FROM {table_name}"

    return pd.read_sql(query, engine)

def save_df_to_csv(df, path):

    '''
    Save a pandas DataFrame to a CSV file.

    Args:
        df (pd.DataFrame): pandas DataFrame to save.
        path (str | Path): Full path to the target CSV file.

    Returns:
        Path: Full path to the saved CSV file.

    Raises:
        TypeError: If df is not a pandas DataFrame.
        TypeError: If path is not a string or Path object.
        ValueError: If path is an empty string.
        ValueError: If path does not end with the `.csv` extension.

    Example:
        >>> save_df_to_csv(df=df, path='data/processed/clean_df.csv')
        Path('data/processed/clean_df.csv')
    '''

    if not isinstance(df, pd.DataFrame):
        raise TypeError('df input must be a pandas DataFrame.')
    
    if not isinstance(path, (str, Path)):
        raise TypeError('path must be a string or Path object.')

    if isinstance(path, str) and not path.strip():
        raise ValueError('path cannot be an empty string.')
    
    path = Path(path)
    
    if path.suffix != '.csv':
        raise ValueError('path must end with a `.csv` extension.')

    path.parent.mkdir(exist_ok=True, parents=True)

    df.to_csv(path, index=False)

    return path