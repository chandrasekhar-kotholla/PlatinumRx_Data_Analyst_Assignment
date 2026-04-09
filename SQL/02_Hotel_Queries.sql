## For every user in the system, get the user_id and last booked room_no 

SELECT 
    u.user_id,
    b.room_no
FROM users u
LEFT JOIN (
    SELECT 
        user_id,
        room_no,
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY booking_date DESC, booking_id DESC
        ) AS rn
    FROM bookings
) b 
ON u.user_id = b.user_id 
AND b.rn = 1
ORDER BY u.user_id;


##Get booking_id and total billing amount of every booking created in November, 2021 

SELECT 
    b.booking_id,
    SUM(i.item_rate * bc.item_quantity) AS total_amount
FROM bookings b
JOIN booking_commercials bc 
    ON b.booking_id = bc.booking_id
JOIN items i 
    ON bc.item_id = i.item_id
WHERE b.booking_date >= '2023-04-01'
  AND b.booking_date < '2023-05-01'
GROUP BY b.booking_id
ORDER BY b.booking_id;


## Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount > 1000
    
SELECT 
    bc.bill_id,
    SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2023-04-01'
  AND bc.bill_date < '2023-05-01'
GROUP BY bc.bill_id
HAVING SUM(i.item_rate * bc.item_quantity) > 1000
ORDER BY bill_amount DESC;


## Determine the most ordered and least ordered item of each month of year 2021

WITH item_totals AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        i.item_name,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    JOIN items i 
        ON bc.item_id = i.item_id
    GROUP BY MONTH(bc.bill_date), i.item_name
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS max_rank,
           RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS min_rank
    FROM item_totals
)
SELECT 
    month,
    item_name,
    total_qty,
    CASE 
        WHEN max_rank = 1 THEN 'Most Ordered'
        WHEN min_rank = 1 THEN 'Least Ordered'
    END AS category
FROM ranked
WHERE max_rank = 1 OR min_rank = 1
ORDER BY month, category DESC;


##  Find the customers with the second highest bill value of each month of year 2021 

WITH bill_values AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        bc.bill_id,
        b.user_id,
        SUM(i.item_rate * bc.item_quantity) AS bill_amount
    FROM booking_commercials bc
    JOIN items i 
        ON bc.item_id = i.item_id
    JOIN bookings b 
        ON bc.booking_id = b.booking_id
    GROUP BY MONTH(bc.bill_date), bc.bill_id, b.user_id
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY month 
               ORDER BY bill_amount DESC
           ) AS rnk
    FROM bill_values
)
SELECT 
    month,
    user_id,
    bill_id,
    bill_amount
FROM ranked
WHERE rnk = 2;
