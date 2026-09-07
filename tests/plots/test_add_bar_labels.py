import matplotlib.pyplot as plt
import pandas as pd

from telco_churn.plots import add_bar_labels


def test_add_bar_labels_displays_expected_values():
    expected_labels = ["10.0%", "20.0%", "30.0%"]
    numbers = pd.Series([10, 20, 30])

    series_ax = numbers.plot(
        kind='bar'
    )
    add_bar_labels(axes=series_ax)

    labels = [text.get_text() for text in series_ax.texts]

    plt.close(series_ax.figure)

    assert labels == expected_labels
