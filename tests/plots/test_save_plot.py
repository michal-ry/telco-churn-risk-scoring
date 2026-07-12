import pytest
import re
from pathlib import Path

import matplotlib.pyplot as plt

from telco_churn.plots import save_plot


def test_path_not_a_string_or_object_error():

    path = 11
    file_name = 'test'
    expected_error = 'path must be a string or Path object.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name)

def test_path_empty_string_error():

    path = ' '
    file_name = 'test'
    expected_error = 'path cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name)

def test_file_name_not_a_string_error():

    path = 'test'
    file_name = 11
    expected_error = 'file_name must be in a string format.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name)

def test_file_name_empty_string_error():

    path = 'test'
    file_name = ' '
    expected_error = 'file_name cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name)

def test_extension_not_a_string_error():

    path = 'test'
    file_name = 'test'
    extension = 11
    expected_error = 'extension must be in a string format.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, extension=extension)

def test_extension_empty_string_error():

    path = 'test'
    file_name = 'test'
    extension = ' '
    expected_error = 'extension cannot be an empty string.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, extension=extension)

def test_extension_starts_with_dot_error():
    
    path = 'test'
    file_name = 'test'
    extension = '.png'
    expected_error = 'extension cannot start with a dot.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, extension=extension)

def test_dpi_not_a_number_error():

    path = 'test'
    file_name = 'test'
    dpi = '300'
    expected_error = 'dpi must be a number.'

    with pytest.raises(TypeError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, dpi=dpi)

def test_dpi_lower_than_zero_error():

    path = 'test'
    file_name = 'test'
    dpi = -300
    expected_error = 'dpi must be higher than 0.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, dpi=dpi)

def test_dpi_equal_zero_error():

    path = 'test'
    file_name = 'test'
    dpi = 0
    expected_error = 'dpi must be higher than 0.'

    with pytest.raises(ValueError, match=re.escape(expected_error)):
        save_plot(path=path, file_name=file_name, dpi=dpi)

def test_save_plot_with_string_input(tmp_path):

    plt.plot([1, 2, 3], [2, 4, 3])
    path = str(tmp_path)
    file_name = 'test_plot'
    expected_path = tmp_path / f'{file_name}.png'

    save_plot_path = save_plot(path=path, file_name=file_name)

    assert isinstance(save_plot_path, Path)
    assert save_plot_path == expected_path
    assert save_plot_path.exists()
    assert save_plot_path.stat().st_size > 0

    plt.close()