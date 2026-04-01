use newschema;
-- Overall churn rate
SELECT COUNT(CASE WHEN Churn='Yes' THEN 1 END)*100.0/COUNT(*) as overall FROM telco_churn;
-- Churn by contract type
SELECT Contract, AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) as ChurnRate
FROM telco_churn GROUP BY Contract;
-- Churn by Internet Services
SELECT 
  internetservice, 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND((SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) *1.0 / COUNT(*)) * 100, 3) AS churn_rate
FROM 
  telco_churn
GROUP BY 
  internetservice
ORDER BY 
  churn_rate DESC;
  -- Churn by Tenure Group
  SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Years'
        WHEN tenure <= 24 THEN '01-02 Years'
        WHEN tenure <= 36 THEN '02-03 Years'
        WHEN tenure <= 48 THEN '03-04 Years'
        WHEN tenure <= 60 THEN '04-05 Years'
        ELSE '+5 Years' 
    END AS Tenure_Range,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Count,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Churn_Rate_Pct
FROM telco_churn
GROUP BY 1
ORDER BY 1;
-- Streaming Tv affect
SELECT 
  streamingtv,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND((SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) *1.0 / COUNT(*)) * 100, 3) AS churn_rate
FROM 
  telco_churn
GROUP BY 
  streamingtv
ORDER BY 
  churn_rate DESC;
  
  -- payment method 
SELECT 
  paymentmethod, 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND((SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) *1.0 / COUNT(*)) * 100, 3) AS churn_rate
FROM 
  telco_churn
GROUP BY 
  paymentmethod
ORDER BY 
  churn_rate DESC;