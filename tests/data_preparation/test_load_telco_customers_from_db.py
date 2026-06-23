import pytest
import re
from telco_churn.data_preparation import load_telco_customers_from_db

def test_db_url_none_error():

    db_url = None
    expected_message = "db_url cannot be None."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_telco_customers_from_db(db_url)

def test_db_url_non_string_error():

    db_url = 5
    expected_message = "db_url must be a string."

    with pytest.raises(TypeError, match=re.escape(expected_message)):
        load_telco_customers_from_db(db_url)

def test_db_url_empty_string_error():

    db_url = ""
    expected_message = "db_url cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_telco_customers_from_db(db_url)

def test_db_url_strip_empty_string_error():

    db_url = "  "
    expected_message = "db_url cannot be an empty string."

    with pytest.raises(ValueError, match=re.escape(expected_message)):
        load_telco_customers_from_db(db_url)