# SQL Insights

## Dataset Overview

Total number of rows: 7043

Unique customer_id: 7043

Each row represents one customer.

## Target Distribution

Churn No: 73.46% (5174 customers)

Churn Yes: 26.54% (1869 customers)

The target shows a moderate class imbalance, with non-churn customers as the majority class.

A stratified train-test split will be used to preserve a similar churn distribution in both datasets.

## Churn Rate Analysis

#### Baseline churn rate: 26.54%

### Senior Citizen

Senior citizens have a much higher churn rate: 41.68% (+15.14 pp vs baseline), compared with non-senior citizens at 23.61% (-2.93 pp vs baseline).

### Internet Service

Customers with fiber optic internet show a much higher churn rate: 41.89% (+15.36 pp vs baseline). Customers with DSL have a lower churn rate compared with the baseline: 18.96% (-7.58 pp vs baseline).

Customers without internet service have the lowest churn rate: 7.40% (-19.13 pp vs baseline).

### Tech Support

Customers without tech support are associated with a higher churn rate: 41.64% (+15.10 pp vs baseline).

Customers with tech support have a lower churn rate than the overall baseline: 15.17% (-11.37 pp vs baseline).

### Dependents

Customers with dependents have a much lower churn rate: 15.45% (-11.09 pp vs baseline), compared with customers without dependents at 31.28% (+4.74 pp vs baseline).

### Contract

Contract type is strongly associated with churn rate. Customers with month-to-month contracts have the highest churn rate, while customers with longer contracts churn much less:
- Month-to-month: 42.71% (+16.17 pp vs baseline)
- One year: 11.27% (-15.27 pp vs baseline)
- Two year: 2.83% (-23.71 pp vs baseline)

### Payment Method

Customers using electronic check show the highest churn rate: 45.29% (+18.75 pp vs baseline), compared with other payment methods.

Customers using other payment methods churn below the overall baseline. This includes mailed check, bank transfer (automatic), and credit card (automatic).

### Key Takeaways

The strongest churn rate differences were observed for payment method, contract type, internet service, senior citizen and tech support.

Customers with electronic check, month-to-month contracts, fiber optic internet, without tech support or those that are in a senior citizen group showed churn rates far above the overall baseline.

## Financial Impact Analysis

### Contract Type

Month-to-month customers are one of the most financially important high-churn groups. They combine a high churn rate of 42.71% with the largest churned customer count: 1655 customers.

With a median monthly charge of $73.25, this group represents an estimated monthly revenue at risk of approximately $121,228.75.

### Internet Service

Customers with fiber optic internet represent another important high-churn group. They combine a high churn rate of 41.89% with 1297 churned customers and a high median monthly charge of $91.67.

Their estimated monthly revenue at risk is approximately $118,895.99.

### Dependents

Another group with high financial impact is customers without dependents. Although their churn rate is lower than in the previous groups at 31.28%, there are a total of 1543 churned customers in this group.

With a median monthly charge of $73.90, their estimated monthly revenue at risk is approximately $114,027.70.

### Tech Support

Another group worth mentioning is customers without tech support. This group has 1446 churned customers and a churn rate of 41.64%.

With a median monthly charge of $78.05, this group is associated with an estimated monthly revenue at risk of approximately $112,860.30.

### Key takeaway

Overall, month-to-month customers, fiber optic customers, customers without dependents, and customers without tech support represent the highest estimated monthly revenue at risk among the analyzed high-churn groups.