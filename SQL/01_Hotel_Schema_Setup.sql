-- USERS
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

INSERT INTO users VALUES
('u11','Amit Verma','9812345678','amit.verma@gmail.com','Whitefield, Bangalore'),
('u12','Neha Kapoor','9898765432','neha.kapoor@yahoo.com','Banjara Hills, Hyderabad'),
('u13','Rohan Shah','9765432109','rohan.shah@outlook.com','Andheri East, Mumbai'),
('u14','Kiran Rao','9876501234','kiran.rao@gmail.com','Indiranagar, Bangalore'); -- no booking user


-- BOOKINGS
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings VALUES
('b11','2023-04-10 09:00:00','101','u11'),
('b12','2023-04-12 18:30:00','102','u11'),
('b16','2023-04-12 18:30:00','103','u11'),
('b13','2023-04-15 11:45:00','201','u12'),
('b14','2023-04-18 14:20:00','305','u13'),
('b15','2023-04-20 08:10:00','110','u12'),
('b17','2023-04-25 10:00:00','999','u13');


-- ITEMS
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate INT
);

INSERT INTO items VALUES
('i11','Idli Sambar',50),
('i12','Chicken Biryani',200),
('i13','Veg Fried Rice',130),
('i14','Cold Coffee',90),
('i15','Gulab Jamun',70);


-- BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity FLOAT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials VALUES
('c11','b11','bill201','2023-04-10','i11',4),
('c12','b11','bill201','2023-04-10','i12',1),

('c13','b12','bill202','2023-04-12','i12',3),
('c14','b12','bill202','2023-04-12','i14',2),

('c15','b13','bill203','2023-04-15','i11',6),
('c16','b13','bill203','2023-04-15','i13',2),

('c17','b14','bill204','2023-04-18','i13',5),
('c18','b14','bill204','2023-04-18','i15',4),

('c19','b15','bill205','2023-04-20','i11',3),
('c20','b15','bill205','2023-04-20','i12',10);
