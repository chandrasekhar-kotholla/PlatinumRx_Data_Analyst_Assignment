##  For every user in the system, get the user_id and last booked room_no ##

SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) rn
    FROM bookings
) t
WHERE rn = 1;


## Get booking_id and total billing amount of every booking created in November, 2021 ##
    
SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;


## . Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000##

SELECT bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bill_id
HAVING bill_amount > 1000;


## Determine the most ordered and least ordered item of each month of year 2021 ## 
 
WITH item_orders AS (
    SELECT 
        MONTH(bill_date) AS month,
        item_id,
        SUM(item_quantity) AS qty
    FROM booking_commercials
    WHERE YEAR(bill_date) = 2021
    GROUP BY MONTH(bill_date), item_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY qty DESC) AS r_desc,
           RANK() OVER (PARTITION BY month ORDER BY qty ASC) AS r_asc
    FROM item_orders
)
SELECT month, item_id, qty
FROM ranked
WHERE r_desc = 1 OR r_asc = 1
ORDER BY month;


##  Find the customers with the second highest bill value of each month of year 2021 ##

WITH bill_totals AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.bill_id, b.user_id
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY month 
               ORDER BY bill_amount DESC
           ) AS rnk
    FROM bill_totals
)
SELECT month, user_id, bill_id, bill_amount
FROM ranked
WHERE rnk = 2
ORDER BY month;
