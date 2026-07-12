import re

import pytest

from telco_churn.data_preparation import load_table_to_df


def test_db_url_none_error():

    db_url = None
    table_name = 'telco_customers'
    expected_message = "db_url cannot be None."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_db_url_non_string_error():

    db_url = 5
    table_name = 'telco_customers'
    expected_message = "db_url must be a string."

    with pytest.raises(TypeError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_db_url_empty_string_error():

    db_url = ""
    table_name = 'telco_customers'
    expected_message = "db_url cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_db_url_whitespace_string_error():

    db_url = "  "
    table_name = 'telco_customers'
    expected_message = "db_url cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_table_name_none_error():

    db_url = 'URL'
    table_name = None
    expected_message = "table_name cannot be None."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_table_name_non_string_error():

    db_url = 'URL'
    table_name = 11
    expected_message = "table_name must be a string."

    with pytest.raises(TypeError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_table_name_empty_string_error():

    db_url = "URL"
    table_name = ''
    expected_message = "table_name cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)


def test_table_name_whitespace_string_error():

    db_url = "URL"
    table_name = '  '
    expected_message = "table_name cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_table_to_df(db_url=db_url, table_name=table_name)