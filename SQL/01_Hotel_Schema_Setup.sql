-- USERS
CREATE TABLE users (
    user_id VARCHAR(50),
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

INSERT INTO users VALUES
('u1','John Doe','9711111111','john@example.com','Street A'),
('u2','Alice','9722222222','alice@example.com','Street B'),
('u3','Bob','9733333333','bob@example.com','Street C');


-- BOOKINGS
CREATE TABLE bookings (
    booking_id VARCHAR(50),
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

INSERT INTO bookings VALUES
('b1','2021-11-10 10:00:00','r1','u1'),
('b2','2021-11-15 12:00:00','r2','u1'),
('b3','2021-10-05 09:00:00','r3','u2'),
('b4','2021-11-20 14:00:00','r4','u3'),
('b5','2021-09-25 08:00:00','r5','u2');


-- ITEMS
CREATE TABLE items (
    item_id VARCHAR(50),
    item_name VARCHAR(100),
    item_rate INT
);

INSERT INTO items VALUES
('i1','Paratha',20),
('i2','Veg',100),
('i3','Rice',50);


-- BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id VARCHAR(50),
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity FLOAT
);

INSERT INTO booking_commercials VALUES
('c1','b1','bill1','2021-11-10','i1',2),
('c2','b1','bill1','2021-11-10','i2',1),
('c3','b2','bill2','2021-11-15','i2',5),
('c4','b3','bill3','2021-10-05','i1',50),
('c5','b4','bill4','2021-11-20','i3',10),
('c6','b5','bill5','2021-09-25','i1',1);
