from pathlib import Path
import re

import pandas as pd
import pytest

from telco_churn.data_preparation import save_df_to_csv


def test_df_is_not_pandas_df_error():

    series = pd.Series(['one', 'two', 'three'])
    path = 'data/processed/df_clean.csv'
    expected_error = 'df input must be a pandas DataFrame.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_df_to_csv(df=series, path=path)


def test_path_is_not_string_or_path_object_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 11
    expected_error = 'path must be a string or Path object.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_df_to_csv(df=df, path=path)


def test_path_is_empty_string_error():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = ' '
    expected_error = 'path cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_df_to_csv(df=df, path=path)


def test_path_without_csv_extension():

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    path = 'data/processed'
    expected_error = 'path must end with a `.csv` extension.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_df_to_csv(df=df, path=path)


def test_save_df_to_csv_with_path_input(tmp_path):

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    full_path = tmp_path / 'df_clean.csv'

    df_path = save_df_to_csv(df=df, path=full_path)

    assert isinstance(df_path, Path)
    assert df_path == full_path
    assert df_path.exists()
    
    saved_df = pd.read_csv(df_path)

    pd.testing.assert_frame_equal(df, saved_df)


def test_save_df_to_csv_with_string_input(tmp_path):

    df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
    full_path = tmp_path / 'clean_df.csv'
    full_path_str = str(full_path)

    df_path = save_df_to_csv(df=df, path=full_path_str)

    assert isinstance(df_path, Path)
    assert df_path == full_path
    assert df_path.exists()
    
    saved_df = pd.read_csv(df_path)

    pd.testing.assert_frame_equal(df, saved_df)