import re

import pandas as pd
import pytest

from telco_churn.data_preparation import train_test_data_split


def test_df_is_not_pandas_df_error():
    series = pd.Series(["one", "two", "three"])

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"
    expected_error = "df input must be a pandas DataFrame."

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        train_test_data_split(
            df=series,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_df_with_zero_rows_error():
    df = pd.DataFrame(
        {
            'col_1': [],
            'col_2': [],
            'churn': [],
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"
    expected_error = "df cannot have zero rows."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_test_size_not_a_float_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 20
    random_state = 42
    stratify_column = "churn"
    expected_error = "test_size must be a float."

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_test_size_less_than_zero_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = -0.2
    random_state = 42
    stratify_column = "churn"
    expected_error = "test_size must be greater than zero."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_test_size_equal_to_one_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 1.0
    random_state = 42
    stratify_column = "churn"
    expected_error = "test_size must be less than one."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_test_size_equal_to_zero_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.0
    random_state = 42
    stratify_column = "churn"
    expected_error = "test_size must be greater than zero."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_test_size_higher_than_one_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 1.2
    random_state = 42
    stratify_column = "churn"
    expected_error = "test_size must be less than one."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_random_state_not_an_integer_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42.2
    stratify_column = "churn"
    expected_error = "random_state must be an integer."

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_stratify_column_not_a_string_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = ["churn"]
    expected_error = "stratify_column must be a string."

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_stratify_column_not_in_df_error():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "col_3": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"
    expected_error = "stratify_column must exist in the DataFrame."

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        train_test_data_split(
            df=df,
            test_size=test_size,
            random_state=random_state,
            stratify_column=stratify_column,
        )


def test_split_returns_dataframes_with_original_columns():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"

    df_train, df_test = train_test_data_split(
        df=df,
        test_size=test_size,
        random_state=random_state,
        stratify_column=stratify_column,
    )

    assert isinstance(df_train, pd.DataFrame)
    assert isinstance(df_test, pd.DataFrame)
    assert df_train.columns.equals(df.columns)
    assert df_test.columns.equals(df.columns)


def test_split_returns_expected_set_sizes():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"

    df_train, df_test = train_test_data_split(
        df=df,
        test_size=test_size,
        random_state=random_state,
        stratify_column=stratify_column,
    )

    assert df_test.shape[0] == df.shape[0] * test_size
    assert df_train.shape[0] == df.shape[0] * (1 - test_size)


def test_split_preserves_stratify_proportions():
    df = pd.DataFrame(
        {
            "col_1": range(1, 11),
            "col_2": range(11, 21),
            "churn": ["No", "Yes"] * 5,
        }
    )

    test_size = 0.2
    random_state = 42
    stratify_column = "churn"

    df_train_yes = 4
    df_train_no = 4
    df_test_yes = 1
    df_test_no = 1

    df_train, df_test = train_test_data_split(
        df=df,
        test_size=test_size,
        random_state=random_state,
        stratify_column=stratify_column,
    )

    assert df_train['churn'].value_counts()['Yes'] == df_train_yes
    assert df_train['churn'].value_counts()['No'] == df_train_no
    assert df_test['churn'].value_counts()['Yes'] == df_test_yes
    assert df_test['churn'].value_counts()['No'] == df_test_no