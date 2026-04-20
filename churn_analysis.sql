-- Customer Churn Analysis Project

-- 1. Total Customers

SELECT COUNT(*) AS total_customers 
FROM customer_churn;

-- 2. Churn Distribution

SELECT Churn, COUNT(*) AS count 
FROM customer_churn 
GROUP BY Churn;

-- 3. Churn Rate (Percentage of total)

SELECT 
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate_percentage
FROM customer_churn;

-- 4. Churn by Contract Type

SELECT Contract, 
       COUNT(*) AS total, 
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customer_churn 
GROUP BY Contract;

-- 5. Churn by Tenure Group

SELECT 
    CASE 
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure BETWEEN 12 AND 24 THEN '1-2 Years'
        ELSE '2+ Years'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customer_churn 
GROUP BY tenure_group;

-- 6. Monthly Charges Analysis

SELECT 
    CASE 
        WHEN MonthlyCharges < 30 THEN 'Low'
        WHEN MonthlyCharges BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_count
FROM customer_churn
GROUP BY charge_group;

-- 7. Payment Method Analysis

SELECT 
    PaymentMethod,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_count
FROM customer_churn
GROUP BY PaymentMethod;

-- 8. Multi-factor Analysis (Contract & Internet Service)

SELECT Contract, InternetService,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY Contract, InternetService
ORDER BY churn_rate DESC;

-- 9. High-risk Customers

SELECT customerID, tenure, MonthlyCharges 
FROM customer_churn
WHERE Churn = 'No' 
  AND MonthlyCharges > 70 
  AND tenure < 12;

-- 10. Ranking Contract Types by Churn

SELECT Contract, 
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count,
       RANK() OVER (ORDER BY SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) DESC) AS churn_rank
FROM customer_churn 
GROUP BY Contract;

