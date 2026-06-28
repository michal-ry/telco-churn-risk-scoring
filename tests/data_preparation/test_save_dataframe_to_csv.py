import pandas as pd
import pytest
import re
import os
from telco_churn.data_preparation import save_dataframe_to_csv

def test_df_is_not_pandas_df_error():

    series = pd.Series(['one', 'two', 'three'])
    path = 'data/processed'
    file_name = 'df_clean'
    expected_error = 'df input must be a pandas DataFrame.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=series, path=path, file_name=file_name)

def test_path_is_not_string_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 11
    file_name = 'df_clean'
    expected_error = 'path must be in a string format.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=df, path=path, file_name=file_name)

def test_path_is_empty_string_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = ' '
    file_name = 'df_clean'
    expected_error = 'path cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=df, path=path, file_name=file_name)

def test_file_name_is_not_string_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 'data/processed'
    file_name = 11
    expected_error = 'file_name must be in a string format.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=df, path=path, file_name=file_name)

def test_file_name_is_empty_string_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 'data/processed'
    file_name = ' '
    expected_error = 'file_name cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=df, path=path, file_name=file_name)

def test_file_name_ends_with_csv_extension_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 'data/processed'
    file_name = 'df_clean.csv'
    expected_error = 'file_name should not end with `.csv` extension.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_dataframe_to_csv(df=df, path=path, file_name=file_name)

def test_save_dataframe_to_csv_successfully_saves_file_and_returns_path(tmp_path):

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = str(tmp_path)
    file_name = 'df_clean'
    expected_path = os.path.join(path, f'{file_name}.csv')

    df_path = save_dataframe_to_csv(df=df, path=path, file_name=file_name)

    assert df_path == expected_path
    assert os.path.exists(df_path)

    saved_df = pd.read_csv(df_path)

    pd.testing.assert_frame_equal(df, saved_df)