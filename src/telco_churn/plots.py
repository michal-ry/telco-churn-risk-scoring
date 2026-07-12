from pathlib import Path

import matplotlib.pyplot as plt


def save_plot(path, file_name, extension='png', dpi=300):

    '''
    Function for saving plots.

    Args:
        path (str | Path): Path to the folder where the plot will be saved.
        file_name: Name of the saved plot file without extension.
        extension: File extension without a dot. Defaults to'png'.
        dpi: Plot resolution in dots per inch. Defaults to 300

    Returns:
        Path: full path to the saved file.

    Raises:
        TypeError: If path is not in a string or Path object.
        TypeError: If file_name or extension is not a string.
        TypeError: If dpi is not numerical.
        ValueError: If path, file_name or extension is an empty string.
        ValueError: If dpi is less than or equal to 0.

    Example:
        >>> save_plot(path='charts', file_name='total_charges_hist', extension='png', dpi=300)
    '''

    if not isinstance(path, (str, Path)):
        raise TypeError('path must be a string or Path object.')

    if isinstance(path, str) and not path.strip():
        raise ValueError('path cannot be an empty string.')

    if not isinstance(file_name, str):
        raise TypeError('file_name must be in a string format.')

    if not file_name.strip():
        raise ValueError('file_name cannot be an empty string.')

    if not isinstance(extension, str):
        raise TypeError('extension must be in a string format.')

    if not extension.strip():
        raise ValueError('extension cannot be an empty string.')
    
    if extension.startswith('.'):
        raise ValueError('extension cannot start with a dot.')

    if not isinstance(dpi, (int, float)):
        raise TypeError('dpi must be a number.')

    if dpi <= 0:
        raise ValueError('dpi must be higher than 0.')
    
    path = Path(path)

    path.mkdir(exist_ok=True, parents=True)

    full_path = path / f'{file_name}.{extension}'

    plt.savefig(full_path, format=extension, dpi=dpi)

    return full_path