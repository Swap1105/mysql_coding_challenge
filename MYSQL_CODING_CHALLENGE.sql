CREATE DATABASE CODING_CHALLENGE;
USE CODING_CHALLENGE;

CREATE TABLE CUSTOMERS(
	CUSTOMER_ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    EMAIL VARCHAR(50),
    PASSWORD VARCHAR(50)
    );
    
CREATE TABLE PRODUCTS(
	PRODUCT_ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    PRICE DOUBLE,
    DESCRIPTION VARCHAR(50),
    STOCK_QUANTITY INT
    );
    
CREATE TABLE CART(
	CART_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID) ON DELETE CASCADE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID) ON DELETE CASCADE
    );
    
CREATE TABLE ORDERS(
	ORDER_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    ORDER_DATE DATE,
    TOTAL_PRICE DOUBLE,
    SHIPPING_ADDRESS VARCHAR(100),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID) ON DELETE CASCADE
    );
    
CREATE TABLE ORDER_ITEMS(
	ORDER_ITEM_ID INT PRIMARY KEY,
    ORDER_ID INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    ITEM_AMOUNT DOUBLE,
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID) ON DELETE CASCADE
    );
    
INSERT INTO CUSTOMERS(CUSTOMER_ID, NAME, EMAIL, PASSWORD) 
VALUES (1, 'John Doe', 'johndoe@example.com', '123 Main St, City'),
	   (2, 'Jane Smith', 'janesmith@example.com', '456 Elm St, Town'),
       (3, 'Robert Johnson', 'robert@example.com', '789 Oak St, Village'),
       (4, 'Sarah Brown', 'sarah@example.com', '101 Pine St, Suburb'),
       (5, 'David Lee', 'david@example.com', '234 Cedar St, District'),
       (6, 'Laura Hall', 'laura@example.com', '567 Birch St, County'),
       (7, 'Michael Davis', 'michael@example.com', '890 Maple St, State'),
       (8, 'Emma Wilson', 'emma@example.com', '321 Redwood St, Country'),
       (9, 'William Taylor', 'william@example.com', '432 Spruce St, Province'),
       (10, 'Olivia Adams', 'olivia@example.com', '765 Fir St, Territory');
       
INSERT INTO PRODUCTS(PRODUCT_ID, NAME, DESCRIPTION, PRICE, STOCK_QUANTITY)
VALUES (1, 'Laptop', 'High-performance laptop', 800.00, 10),
       (2, 'Smartphone', 'Latest Smartphone', 600.00, 15),
       (3, 'Tablet', 'Portable tablet', 300.00, 20),
       (4, 'Headphones', 'Noise-canceling', 150.00, 30),
       (5, 'TV', '4K Smart TV', 900.00, 5),
       (6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
       (7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
       (8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
       (9, 'Blender', 'High-speed blender', 70.00, 20),
       (10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
       
INSERT INTO CART(CART_ID, CUSTOMER_ID, PRODUCT_ID, QUANTITY)
VALUES (1, 1, 1, 2),
       (2, 1, 3, 1),
       (3, 2, 2, 3),
       (4, 3, 4, 4),
       (5, 3, 5, 2),
       (6, 4, 6, 1),
       (7, 5, 1, 1),
       (8, 6, 10, 2),
       (9, 6, 9, 3),
       (10, 7, 7, 2);
       
INSERT INTO ORDERS(ORDER_ID, CUSTOMER_ID, ORDER_DATE, TOTAL_PRICE, SHIPPING_ADDRESS)
VALUES (1, 1, '2023-01-05', 1200.00, '123 Main St, City'),
       (2, 2, '2023-02-10', 900.00, '456 Elm St, Town'),
       (3, 3, '2023-03-15', 300.00, '789 Oak St, Village'),
       (4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
       (5, 5, '2023-05-25', 1800.00, '234 Cedar St, District'),
       (6, 6, '2023-06-30', 400.00, '567 Birch St, County'),
       (7, 7, '2023-07-05', 700.00, '890 Maple St, State'),
       (8, 8, '2023-08-10', 160.00, '321 Redwood St, Country'),
       (9, 9, '2023-09-15', 140.00, '432 Spruce St, Province'),
       (10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');
       
INSERT INTO ORDER_ITEMS(ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, ITEM_AMOUNT)
VALUES (1, 1, 1, 2, 1600),
       (2, 1, 3, 1, 300),
       (3, 2, 2, 3, 1800),
       (4, 3, 5, 2, 1800),
       (5, 4, 4, 4, 600),
       (6, 4, 6, 1, 50),
       (7, 5, 1, 1, 800),
       (8, 5, 2, 2, 1200),
       (9, 6, 10, 2, 240),
       (10, 6, 9, 3, 210);
       
       
       
-- 1) Update refrigerator product price to 800
UPDATE PRODUCTS SET PRICE = 800 WHERE NAME = 'REFRIGERATOR';

-- 2) Remove all cart items for a specific customer
DELETE FROM CART WHERE CUSTOMER_ID = 1;

-- 3) Retrieve Products Priced Below $100
SELECT * FROM PRODUCTS WHERE PRICE<100;

-- 4) Find products with stock quantity greater than 5
SELECT * FROM PRODUCTS WHERE STOCK_QUANTITY>5;

-- 5) Retrieve Orders with Total Amount Between $500 and $1000
SELECT * FROM ORDERS WHERE TOTAL_PRICE BETWEEN 500 AND 1000;

-- 6) Find products which end with letter 'r'
SELECT NAME FROM PRODUCTS WHERE NAME LIKE '%R';

-- 7) Retrieve cart items for customer 5
SELECT * FROM CART WHERE CUSTOMER_ID = 5;

-- 8) Find Customers who placed orders in 2023
SELECT DISTINCT C.* 
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE YEAR(O.ORDER_DATE) = 2023; 

-- 9) Determine the minimum stock quantity for each product category
SELECT MIN(STOCK_QUANTITY) MIN_STOCK FROM PRODUCTS;

-- 10) Calculate the Total Amount Spend by each customer
SELECT C.CUSTOMER_ID, SUM(OT.QUANTITY*P.PRICE) TOT_SPENT
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
LEFT JOIN ORDER_ITEMS OT ON O.ORDER_ID = OT.ORDER_ID
LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OT.PRODUCT_ID
GROUP BY CUSTOMER_ID;

-- 11) Find the average order amount for each customer
SELECT C.CUSTOMER_ID, AVG(OT.QUANTITY*P.PRICE) AVG_SPENT
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
LEFT JOIN ORDER_ITEMS OT ON O.ORDER_ID = OT.ORDER_ID
LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OT.PRODUCT_ID
GROUP BY CUSTOMER_ID;

-- 12) Count the number of orders placed by each customer
SELECT C.NAME, COUNT(OT.ORDER_ITEM_ID) TOT_ORDERS 
FROM CUSTOMERS C 
LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
LEFT JOIN ORDER_ITEMS OT ON O.ORDER_ID = OT.ORDER_ID 
GROUP BY C.CUSTOMER_ID;


-- 13) Find the maximum order amount for each customer
SELECT C.CUSTOMER_ID, MAX(OT.QUANTITY*P.PRICE) MAX_SPENT
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
LEFT JOIN ORDER_ITEMS OT ON O.ORDER_ID = OT.ORDER_ID
LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OT.PRODUCT_ID
GROUP BY CUSTOMER_ID;

-- 14) Get customers who placed orders totalling over $1000
SELECT C.CUSTOMER_ID, C.NAME
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON O.CUSTOMER_ID = C.CUSTOMER_ID 
LEFT JOIN ORDER_ITEMS OT ON O.ORDER_ID = OT.ORDER_ID
LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OT.PRODUCT_ID
WHERE OT.QUANTITY*P.PRICE>1000
GROUP BY CUSTOMER_ID;

-- 15) Subquery to find products not in the cart
SELECT * FROM PRODUCTS
WHERE PRODUCT_ID NOT IN (SELECT DISTINCT PRODUCT_ID FROM CART);

-- 16) Subquery to find customers who haven't placed orders
SELECT C.CUSTOMER_ID, C.NAME FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE ORDER_ID NOT IN (SELECT DISTINCT ORDER_ID FROM ORDER_ITEMS);

-- 17) Subquery to calculate the percentage of total revenue for a product
SELECT PRODUCT_ID, (SUM(ITEM_AMOUNT)/(SELECT SUM(ITEM_AMOUNT) FROM ORDER_ITEMS))*100
AS REVENUE_PERCENTAGE
FROM ORDER_ITEMS
GROUP BY PRODUCT_ID;

-- 18) Subquery to find products with low stock
SELECT * FROM PRODUCTS
WHERE STOCK_QUANTITY < (SELECT AVG(STOCK_QUANTITY) FROM PRODUCTS);

-- 19) Subquery to find customers who placed high-value orders
SELECT CUSTOMER_ID FROM ORDERS
WHERE TOTAL_PRICE > (SELECT AVG(TOTAL_PRICE) FROM ORDERS);

SELECT * FROM CUSTOMERS;
SELECT * FROM PRODUCTS;
SELECT * FROM CART;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_ITEMS;