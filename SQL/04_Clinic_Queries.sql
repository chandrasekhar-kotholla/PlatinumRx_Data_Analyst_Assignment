## Find the revenue we got from each sales channel in a given year 

SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;


## Find top 10 the most valuable customers for a given year 

SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


##  Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year

WITH revenue AS (
    SELECT cid,
           MONTH(datetime) AS month,
           SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, month
),
expense AS (
    SELECT cid,
           MONTH(datetime) AS month,
           SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, month
)
SELECT r.cid,
       r.month,
       r.total_revenue,
       COALESCE(e.total_expense, 0) AS total_expense,
       (r.total_revenue - COALESCE(e.total_expense,0)) AS profit,
       CASE 
           WHEN (r.total_revenue - COALESCE(e.total_expense,0)) > 0 
           THEN 'profitable'
           ELSE 'not-profitable'
       END AS status
FROM revenue r
LEFT JOIN expense e 
ON r.cid = e.cid AND r.month = e.month;


##  For each city find the most profitable clinic for a given month

WITH sales AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE MONTH(datetime)=9 AND YEAR(datetime)=2021
    GROUP BY cid
),
exp AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE MONTH(datetime)=9 AND YEAR(datetime)=2021
    GROUP BY cid
),
profit_calc AS (
    SELECT c.city,
           s.cid,
           (s.revenue - COALESCE(e.expense,0)) AS profit
    FROM sales s
    LEFT JOIN exp e ON s.cid = e.cid
    JOIN clinics c ON s.cid = c.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) rnk
    FROM profit_calc
)
SELECT city, cid, profit
FROM ranked
WHERE rnk = 1;


 ## For each state find the second least profitable clinic for a given month 

WITH sales AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE MONTH(datetime)=9 AND YEAR(datetime)=2021
    GROUP BY cid
),
exp AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE MONTH(datetime)=9 AND YEAR(datetime)=2021
    GROUP BY cid
),
profit_calc AS (
    SELECT c.state,
           s.cid,
           (s.revenue - COALESCE(e.expense,0)) AS profit
    FROM sales s
    LEFT JOIN exp e ON s.cid = e.cid
    JOIN clinics c ON s.cid = c.cid
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profit_calc
)
SELECT state, cid, profit
FROM ranked
WHERE rnk = 2;
