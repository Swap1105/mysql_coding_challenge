CREATE DATABASE HMBANK;
USE HMBANK;

CREATE TABLE CUSTOMERS(
	CUSTOMER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(30),
    LAST_NAME VARCHAR(30),
    DOB DATE,
    EMAIL VARCHAR(50),
    PHONE_NO DOUBLE
    );
    
ALTER TABLE CUSTOMERS ADD CUSTOMER_CITY VARCHAR(30);    
    
CREATE TABLE ACCOUNTS(
	ACCOUNT_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    ACCOUNT_TYPE VARCHAR(30),
    BALANCE DOUBLE,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID) ON DELETE CASCADE
    );
    
CREATE TABLE TRANSACTIONS(
	TRANSACTION_ID INT PRIMARY KEY,
    ACCOUNT_ID INT,
    TRANSACTION_TYPE VARCHAR(30),
    AMOUNT DOUBLE,
    TRANSACTION_DATE DATE,
    FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNTS(ACCOUNT_ID) ON DELETE CASCADE
    );


INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, DOB, EMAIL, PHONE_NO, CUSTOMER_CITY) VALUES
(1, 'Amit', 'Sharma', '1990-05-15', 'amit.sharma@email.com', 9876543210,'Mumbai'),
(2, 'Priya', 'Patel', '1985-10-20', 'priya.patel@email.com', 8765432109, 'Pune'),
(3, 'Rahul', 'Verma', '1992-03-10', 'rahul.verma@email.com', 7654321098, 'Delhi'),
(4, 'Sneha', 'Kumar', '1988-07-25', 'sneha.kumar@email.com', 6543210987, 'Mumbai'),
(5, 'Vikas', 'Joshi', '1995-11-30', 'vikas.joshi@email.com', 5432109876, 'Pune'),
(6, 'Anjali', 'Rao', '1993-06-18', 'anjali.rao@email.com', 4321098765, 'Delhi'),
(7, 'Deepak', 'Singh', '1987-09-05', 'deepak.singh@email.com', 3210987654,'Mumbai'),
(8, 'Meera', 'Desai', '1991-02-28', 'meera.desai@email.com', 2109876543, 'Pune'),
(9, 'Arjun', 'Iyer', '1994-12-12', 'arjun.iyer@email.com', 1098765432, 'Delhi'),
(10, 'Riya', 'Choudhary', '1986-08-08', 'riya.choudhary@email.com', 9988776655, 'Mumbai');

INSERT INTO ACCOUNTS (ACCOUNT_ID, CUSTOMER_ID, ACCOUNT_TYPE, BALANCE) VALUES
(101, 1, 'Savings', 25000.50),
(102, 2, 'Checking', 15000.75),
(103, 3, 'Savings', 32000.00),
(104, 4, 'Checking', 4500.25),
(105, 5, 'Savings', 58000.90),
(106, 6, 'Checking', 12000.40),
(107, 7, 'Savings', 27500.30),
(108, 8, 'Checking', 8000.60),
(109, 9, 'Savings', 40000.20),
(110, 10, 'Checking', 9500.85);

INSERT INTO TRANSACTIONS (TRANSACTION_ID, ACCOUNT_ID, TRANSACTION_TYPE, AMOUNT, TRANSACTION_DATE) VALUES
(1001, 101, 'Deposit', 5000.00, '2025-03-01'),
(1002, 102, 'Withdrawal', 2000.00, '2025-03-02'),
(1003, 103, 'Deposit', 10000.00, '2025-03-03'),
(1004, 104, 'Withdrawal', 500.00, '2025-03-04'),
(1005, 105, 'Deposit', 15000.00, '2025-03-05'),
(1006, 106, 'Withdrawal', 1000.00, '2025-03-06'),
(1007, 107, 'Deposit', 7500.00, '2025-03-07'),
(1008, 108, 'Withdrawal', 1200.00, '2025-03-08'),
(1009, 109, 'Deposit', 9000.00, '2025-03-09'),
(1010, 110, 'Withdrawal', 2500.00, '2025-03-10');

-- 1. Write a SQL query to retrieve the name, account_type and email of all customers.
SELECT FIRST_NAME, LAST_NAME, ACCOUNT_TYPE, EMAIL 
FROM CUSTOMERS C
LEFT JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID;

-- 2. Write a SQL query to list all transactions corresponding customers.
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME," ", C.LAST_NAME) CUSTOMER_NAME, A.ACCOUNT_ID, 
T.TRANSACTION_ID, T.TRANSACTION_DATE, T.AMOUNT, T.TRANSACTION_TYPE
FROM CUSTOMERS C 
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID;

-- 3. Write a SQL query to increase the balance of a specific account by certain amount.
UPDATE ACCOUNTS SET BALANCE = 35000 WHERE ACCOUNT_ID = 101;

-- 4. Write a SQL query to combine the first and last names of customers as full names.
SELECT CONCAT(FIRST_NAME," ", LAST_NAME) FULL_NAME FROM CUSTOMERS;

-- 5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE FROM ACCOUNTS WHERE ACCOUNT_TYPE = 'SAVINGS' AND BALANCE = 0;

-- 6. Write a SQL query to Find customers living in a specific city.
SELECT * FROM CUSTOMERS WHERE CUSTOMER_CITY='MUMBAI';

-- 7. Write a SQL query to Get the account balance for a specific account.
SELECT BALANCE FROM ACCOUNTS WHERE CUSTOMER_ID=6;

-- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.
SELECT ACCOUNT_ID FROM ACCOUNTS WHERE ACCOUNT_TYPE='CHECKING' AND BALANCE>1000;

-- 9. Write a SQL query to Retrieve all transactions for a specific account.
SELECT * FROM TRANSACTIONS WHERE ACCOUNT_ID = 103;

-- 10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
SELECT ACCOUNT_ID, (BALANCE+BALANCE*(4.5/100)) INTEREST_ACCRUED FROM ACCOUNTS WHERE ACCOUNT_TYPE='SAVINGS';

-- 11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
SELECT ACCOUNT_ID FROM ACCOUNTS WHERE BALANCE<10000;

-- 12. Write a SQL query to Find customers not living in a specific city.
SELECT * FROM CUSTOMERS WHERE CUSTOMER_CITY!='MUMBAI';


-- Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:

-- 1. Write a SQL query to Find the average account balance for all customers.
SELECT AVG(BALANCE) FROM ACCOUNTS;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
SELECT * FROM ACCOUNTS ORDER BY BALANCE DESC;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT SUM(AMOUNT) TOTAL_DEPOSITS FROM TRANSACTIONS WHERE TRANSACTION_TYPE = 'DEPOSIT' AND TRANSACTION_DATE='2025-03-03';

-- 4. Write a SQL query to Find the Oldest and Newest Customers.
SELECT * FROM CUSTOMERS WHERE DOB=(SELECT MIN(DOB) FROM CUSTOMERS);
SELECT * FROM CUSTOMERS WHERE DOB=(SELECT MAX(DOB) FROM CUSTOMERS);

-- 5. Write a SQL query to Retrieve transaction details along with the account type.
SELECT ACCOUNT_TYPE, T.* FROM ACCOUNTS A
RIGHT JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID;

-- 6. Write a SQL query to Get a list of customers along with their account details.
SELECT C.*, A.ACCOUNT_ID, A.ACCOUNT_TYPE, A.BALANCE 
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID; 

-- 7. Write a SQL query to Retrieve transaction details along with customer information for a
-- specific account.
SELECT T.*, C.* FROM TRANSACTIONS T 
JOIN ACCOUNTS A ON T.ACCOUNT_ID = A.ACCOUNT_ID
JOIN CUSTOMERS C ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE A.ACCOUNT_ID = 101;

-- 8. Write a SQL query to Identify customers who have more than one account.
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME, " ", C.LAST_NAME) CUSTOMER_NAME, COUNT(A.ACCOUNT_ID) ACCOUNT_COUNT
FROM CUSTOMERS C 
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, CUSTOMER_NAME HAVING COUNT(A.ACCOUNT_ID)>1;

-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and
-- withdrawals.
SELECT A.ACCOUNT_ID, SUM(CASE WHEN T.TRANSACTION_TYPE='DEPOSIT' THEN T.AMOUNT ELSE 0 END) TOTAL_DEPOSITS,
SUM(CASE WHEN T.TRANSACTION_TYPE='WITHDRAWAL' THEN T.AMOUNT ELSE 0 END) TOTAL_WITHDRAWALS,
SUM(CASE
		WHEN T.TRANSACTION_TYPE='DEPOSIT' THEN T.AMOUNT
        WHEN T.TRANSACTION_TYPE = 'WITHDRAWAL' THEN -T.AMOUNT
        ELSE 0 END
	) DIFFERENCE
FROM ACCOUNTS A 
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID
GROUP BY A.ACCOUNT_ID;

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified
-- period.
SELECT A.ACCOUNT_ID, ROUND(SUM(T.AMOUNT)/COUNT(DISTINCT T.TRANSACTION_DATE), 2) AVG_DAILY_BALANCE
FROM ACCOUNTS A 
JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE T.TRANSACTION_DATE BETWEEN '2025-03-01' AND '2025-03-05'
GROUP BY A.ACCOUNT_ID;

-- 11. Calculate the total balance for each account type.
SELECT ACCOUNT_TYPE, SUM(BALANCE) FROM ACCOUNTS GROUP BY ACCOUNT_TYPE;

-- 12. Identify accounts with the highest number of transactions order by descending order.
SELECT A.ACCOUNT_ID, COUNT(T.TRANSACTION_ID) TRANSACTION_COUNT
FROM ACCOUNTS A 
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID 
GROUP BY ACCOUNT_ID
ORDER BY TRANSACTION_COUNT DESC;

-- 13. List customers with high aggregate account balances, along with their account types.
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME," ",C.LAST_NAME) CUSTOMER_NAME, A.ACCOUNT_TYPE, SUM(A.BALANCE) TOT_BAL
FROM CUSTOMERS C
JOIN ACCOUNTS A ON A.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, CUSTOMER_NAME, A.ACCOUNT_TYPE
HAVING SUM(A.BALANCE) > 10000 
ORDER BY TOT_BAL DESC;

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account.
SELECT ACCOUNT_ID, TRANSACTION_DATE, AMOUNT, COUNT(*) DUPLICATE_COUNT
FROM TRANSACTIONS 
GROUP BY ACCOUNT_ID, TRANSACTION_DATE, AMOUNT HAVING COUNT(*)>1;

-- Tasks 4: Subquery and its type:

-- 1. Retrieve the customer(s) with the highest account balance.
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME," ",C.LAST_NAME) CUSTOMER_NAME, A.ACCOUNT_ID, A.ACCOUNT_TYPE, A.BALANCE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE A.BALANCE = (SELECT MAX(BALANCE) FROM ACCOUNTS);

-- 2. Calculate the average account balance for customers who have more than one account.
SELECT C.CUSTOMER_ID, CONCAT(C.FIRST_NAME," ",C.LAST_NAME) NAME, AVG(A.BALANCE) AVG_BALANCE, COUNT(A.ACCOUNT_ID) ACCOUNT_COUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, NAME HAVING COUNT(A.ACCOUNT_ID)>1;

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
SELECT A.ACCOUNT_ID, T.TRANSACTION_ID, T.TRANSACTION_DATE, T.AMOUNT, T.TRANSACTION_TYPE
FROM TRANSACTIONS T 
JOIN ACCOUNTS A ON A.ACCOUNT_ID=T.ACCOUNT_ID
WHERE T.AMOUNT > (SELECT AVG(AMOUNT) FROM TRANSACTIONS);

-- 4. Identify customers who have no recorded transactions.
SELECT CUSTOMER_ID, CONCAT(FIRST_NAME," ",LAST_NAME) NAME
FROM CUSTOMERS
WHERE CUSTOMER_ID NOT IN(SELECT DISTINCT A.CUSTOMER_ID FROM ACCOUNTS A 
						JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID);

-- 5. Calculate the total balance of accounts with no recorded transactions.
SELECT SUM(BALANCE) TOT_BAL
FROM ACCOUNTS 
WHERE ACCOUNT_ID NOT IN(SELECT DISTINCT ACCOUNT_ID FROM TRANSACTIONS);

-- 6. Retrieve transactions for accounts with the lowest balance.
SELECT T.TRANSACTION_ID, T.ACCOUNT_ID, T.TRANSACTION_DATE, T.AMOUNT, T.TRANSACTION_TYPE
FROM TRANSACTIONS T 
WHERE T.ACCOUNT_ID=(SELECT ACCOUNT_ID FROM ACCOUNTS ORDER BY BALANCE LIMIT 1);

-- 7. Identify customers who have accounts of multiple types.
SELECT CUSTOMER_ID, FIRST_NAME FROM CUSTOMERS
WHERE CUSTOMER_ID IN(SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID
						HAVING COUNT(DISTINCT ACCOUNT_TYPE)>1);

-- 8. Calculate the percentage of each account type out of the total number of accounts.
SELECT ACCOUNT_TYPE, COUNT(*) AS ACC_COUNT, ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM ACCOUNTS), 2) PERCENTAGE
FROM ACCOUNTS GROUP BY ACCOUNT_TYPE;

-- 9. Retrieve all transactions for a customer with a given customer_id.
SELECT * FROM TRANSACTIONS
WHERE ACCOUNT_ID IN (SELECT ACCOUNT_ID FROM ACCOUNTS WHERE CUSTOMER_ID=1);

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT
-- clause.
SELECT DISTINCT ACCOUNT_TYPE, (SELECT SUM(BALANCE) FROM ACCOUNTS A2 WHERE A2.ACCOUNT_TYPE=A1.ACCOUNT_TYPE) TOT_BAL
FROM ACCOUNTS A1;

SELECT * FROM CUSTOMERS;
SELECT * FROM ACCOUNTS;
SELECT * FROM TRANSACTIONS;




    
