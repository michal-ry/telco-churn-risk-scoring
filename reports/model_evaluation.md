For every model evaluation I'm using four metrics:
- `accuracy`- the proportion of correctly classified customers across both classes
- `precision`- the proportion of customers classified as churners who actually churned
- `recall`- the proportion of actual churners identified by the model
- `F1`- a metric that combines precision and recall into a single score

The values below are mean scores calculated based on 5-fold cross-validation results.

The main metric that I will focus on is `recall`. 

List of models that I decided to train:
- `DummyClassifier`

## Results

### DummyClassifier

#### Metrics:
- `accuracy`: 0.2654
- `precision`: 0.2654
- `recall`: 1.0000
- `F1`: 0.4194

This model is configured to classify all customers as churners. This gives us a `recall` equal to `1.0000` as our model catches every customer who churned. This looks ideal but when we look at other metrics: `precision` of `0.2654` and `F1` of `0.4194` we see that focusing fully on recall is not a good idea. When using this model, retention offers may reach many customers who do not need them, potentially increasing contact costs and the cost of discounts.

DummyClassifier metrics gave us a baseline for comparison with other models.