-- CLINICS
CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO clinics VALUES
('c101','HealthFirst Clinic','Bangalore','Karnataka','India'),
('c102','CarePlus Clinic','Hyderabad','Telangana','India'),
('c103','Wellness Center','Mumbai','Maharashtra','India'),
('c104','MediCare Hub','Bangalore','Karnataka','India');


-- CUSTOMER
CREATE TABLE customer (
    uid VARCHAR(50),
    name VARCHAR(100),
    mobile VARCHAR(20)
);

INSERT INTO customer VALUES
('u101','Rahul Sharma','9811111111'),
('u102','Sneha Reddy','9822222222'),
('u103','Amit Verma','9833333333'),
('u104','Priya Nair','9844444444'),
('u105','Test User',NULL); -- edge case


-- CLINIC_SALES
CREATE TABLE clinic_sales (
    oid VARCHAR(50),
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount INT,
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

INSERT INTO clinic_sales VALUES
('o101','u101','c101',1200,'2023-06-10 10:00:00','online'),
('o102','u102','c101',2500,'2023-06-12 12:30:00','offline'),
('o103','u101','c102',3200,'2023-06-15 14:00:00','online'),
('o104','u103','c103',4500,'2023-06-18 16:45:00','partner'),
('o105','u104','c104',2800,'2023-06-20 11:15:00','online'),
('o106','u101','c101',1800,'2023-06-22 09:00:00','offline'),
('o107','u102','c102',7000,'2023-06-25 17:30:00','online'),
('o108','u103','c103',2200,'2023-07-02 10:00:00','online');


-- EXPENSES
CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    description VARCHAR(100),
    amount INT,
    datetime DATETIME
);

INSERT INTO expenses VALUES
('e101','c101','Medical Supplies',800,'2023-06-10 08:00:00'),
('e102','c101','Maintenance',1200,'2023-06-12 09:30:00'),
('e103','c102','Staff Salary',2000,'2023-06-15 10:00:00'),
('e104','c103','Equipment Purchase',3000,'2023-06-18 11:15:00'),
('e105','c104','Utilities',1500,'2023-06-20 12:00:00'),
('e106','c101','Electricity Bill',600,'2023-06-22 13:00:00'),
('e107','c102','Rent',2500,'2023-07-02 14:00:00');
