-- CLINICS

CREATE TABLE clinics (
    cid VARCHAR(50),
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO clinics VALUES
('c1','XYZ Clinic','CityA','StateA','India'),
('c2','ABC Clinic','CityA','StateA','India'),
('c3','PQR Clinic','CityB','StateB','India');


-- CUSTOMER

CREATE TABLE customer (
    uid VARCHAR(50),
    name VARCHAR(100),
    mobile VARCHAR(20)
);

INSERT INTO customer VALUES
('u1','John Doe','9711111111'),
('u2','Alice','9722222222'),
('u3','Bob','9733333333');


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
('o1','u1','c1',1000,'2021-09-10 10:00:00','online'),
('o2','u2','c1',2000,'2021-09-15 12:00:00','offline'),
('o3','u1','c2',3000,'2021-09-20 14:00:00','online'),
('o4','u3','c3',4000,'2021-09-25 16:00:00','partner'),
('o5','u2','c2',1500,'2021-10-05 11:00:00','online');


-- EXPENSES

CREATE TABLE expenses (
    eid VARCHAR(50),
    cid VARCHAR(50),
    description VARCHAR(100),
    amount INT,
    datetime DATETIME
);

INSERT INTO expenses VALUES
('e1','c1','Supplies',500,'2021-09-10 08:00:00'),
('e2','c1','Maintenance',700,'2021-09-15 09:00:00'),
('e3','c2','Staff',1000,'2021-09-20 10:00:00'),
('e4','c3','Equipment',1500,'2021-09-25 11:00:00'),
('e5','c2','Rent',800,'2021-10-05 12:00:00');
