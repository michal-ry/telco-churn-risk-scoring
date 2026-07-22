import pandas as pd
from pathlib import Path
from sklearn.model_selection import train_test_split
from sqlalchemy import create_engine


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
    """
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
    """

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


def train_test_data_split(df, test_size, random_state, stratify_column):
    """
    Split data into train and test sets.

    Args:
        df (pd.DataFrame): pandas DataFrame to split.
        test_size (float): Proportion of the DataFrame assigned to the test set.
                           Must satisfy 0 < test_size < 1.
        random_state (int): Seed used to make the split reproducible.
        stratify_column (str): Column used to preserve class proportions
                               during the split.

    Returns:
        df_train (pd.DataFrame): Data for training.
        df_test (pd.DataFrame): Data for tests.

    Raises:
        TypeError: If df is not a pandas DataFrame.
        ValueError: If df has zero rows.
        TypeError: If test_size is not a float.
        ValueError: If test_size is not in a range of 0 < test_size < 1.
        TypeError: If random_state is not an integer.
        TypeError: If stratify_column is not a string.
        ValueError: If stratify_column is not part of a given DataFrame.

    Example:
        >>> df_train, df_test = train_test_data_split(
        ...     df=clean_df,
        ...     test_size=0.2,
        ...     random_state=42,
        ...     stratify_column="churn",
        ... )
    """

    if not isinstance(df, pd.DataFrame):
        raise TypeError("df input must be a pandas DataFrame.")
    
    if df.shape[0] < 1:
        raise ValueError("df cannot have zero rows.")
    
    if not isinstance(test_size, float):
        raise TypeError("test_size must be a float.")
    
    if test_size <= 0:
        raise ValueError("test_size must be greater than zero.")
    
    if test_size >= 1:
        raise ValueError("test_size must be less than one.")

    if not isinstance(random_state, int):
        raise TypeError("random_state must be an integer.")
    
    if not isinstance(stratify_column, str):
        raise TypeError("stratify_column must be a string.")
    
    if stratify_column not in df.columns:
        raise ValueError("stratify_column must exist in the DataFrame.")
    
    df_train, df_test = train_test_split(
        df,
        test_size=test_size,
        random_state=random_state,
        stratify=df[stratify_column],
    )

    return df_train, df_test