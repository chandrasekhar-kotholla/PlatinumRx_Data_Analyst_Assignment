## Find the revenue we got from each sales channel in a given year
       
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2023
GROUP BY sales_channel
ORDER BY total_revenue DESC;


## Find top 10 the most valuable customers for a given year 

SELECT 
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2023
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


## Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year

WITH revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE datetime >= '2023-01-01'
      AND datetime < '2024-01-01'
    GROUP BY MONTH(datetime)
),
expense_cte AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE datetime >= '2023-01-01'
      AND datetime < '2024-01-01'
    GROUP BY MONTH(datetime)
)
SELECT 
    r.month,
    r.total_revenue,
    COALESCE(e.total_expense, 0) AS total_expense,
    (r.total_revenue - COALESCE(e.total_expense, 0)) AS profit,
    CASE 
        WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0 
            THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
LEFT JOIN expense_cte e 
    ON r.month = e.month
ORDER BY r.month;


## For each city find the most profitable clinic for a given month 
WITH revenue AS (
    SELECT 
        cid,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE datetime >= '2023-06-01'
      AND datetime < '2023-07-01'
    GROUP BY cid
),
expense_cte AS (
    SELECT 
        cid,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE datetime >= '2023-06-01'
      AND datetime < '2023-07-01'
    GROUP BY cid
),
profit AS (
    SELECT 
        c.city,
        c.cid,
        COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) AS profit
    FROM clinics c
    LEFT JOIN revenue r ON c.cid = r.cid
    LEFT JOIN expense_cte e ON c.cid = e.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY city 
               ORDER BY profit DESC
           ) AS rnk
    FROM profit
)
SELECT city, cid, profit
FROM ranked
WHERE rnk = 1;


##  For each state find the second least profitable clinic for a given month 

WITH revenue AS (
    SELECT 
        cid,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE datetime >= '2023-06-01'
      AND datetime < '2023-07-01'
    GROUP BY cid
),
expense_cte AS (
    SELECT 
        cid,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE datetime >= '2023-06-01'
      AND datetime < '2023-07-01'
    GROUP BY cid
),
profit AS (
    SELECT 
        c.state,
        c.cid,
        COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) AS profit
    FROM clinics c
    LEFT JOIN revenue r ON c.cid = r.cid
    LEFT JOIN expense_cte e ON c.cid = e.cid
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY state 
               ORDER BY profit ASC
           ) AS rnk
    FROM profit
)
SELECT state, cid, profit
FROM ranked
WHERE rnk = 2;
