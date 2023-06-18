Name: Pranav S. Joshi

Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 5.5.24 MySQL Community Server (GPL)

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>  -- create new database
mysql> create database Celebal_COE;
Query OK, 1 row affected (0.08 sec)

mysql>  use Celebal_COE;
Database changed
mysql>  -- create 3 tables viz. Customers, Orders and Products
mysql> CREATE TABLE Customers (
    ->   CustomerID INT PRIMARY KEY,
    ->   FirstName VARCHAR(50),
    ->   LastName VARCHAR(50),
    ->   Age INT
    -> );
Query OK, 0 rows affected (0.17 sec)

mysql> CREATE TABLE Orders (
    -> ProductID INT PRIMARY KEY,
    -> CustomerID INT,
    ->   OrderDate DATE,
    ->   TotalAmount DECIMAL(10, 2),
    ->   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
Query OK, 0 rows affected (0.24 sec)

mysql> CREATE TABLE Products (
    -> ProductID INT,
    -> ProductName VARCHAR(100),
    ->   Price DECIMAL(10, 2),
    ->  FOREIGN KEY (ProductID) REFERENCES Orders(ProductID)
    -> );
Query OK, 0 rows affected (0.19 sec)

mysql>  -- Insert Data into Tables
mysql> INSERT INTO Customers (CustomerID, FirstName, LastName, Age)
    -> VALUES (1, 'John', 'Doe', 30),
    ->        (2, 'Jane', 'Smith', 25);
Query OK, 2 rows affected (0.07 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Orders (ProductID, CustomerID, OrderDate, TotalAmount)
    -> VALUES (1, 1, '2023-01-01', 100.50),
    ->        (2, 2, '2023-02-01', 75.20);
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Products (ProductID, ProductName, Price)
    -> VALUES (1, 'Product 1', 10.99),
    ->        (2, 'Product 2', 15.99);
Query OK, 2 rows affected (0.04 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> -- Retrieve data from the tables
mysql> SELECT * FROM Customers;
+------------+-----------+----------+------+
| CustomerID | FirstName | LastName | Age  |
+------------+-----------+----------+------+
|          1 | John      | Doe      |   30 |
|          2 | Jane      | Smith    |   25 |
+------------+-----------+----------+------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Orders;
+-----------+------------+------------+-------------+
| ProductID | CustomerID | OrderDate  | TotalAmount |
+-----------+------------+------------+-------------+
|         1 |          1 | 2023-01-01 |      100.50 |
|         2 |          2 | 2023-02-01 |       75.20 |
+-----------+------------+------------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Products;
+-----------+-------------+-------+
| ProductID | ProductName | Price |
+-----------+-------------+-------+
|         1 | Product 1   | 10.99 |
|         2 | Product 2   | 15.99 |
+-----------+-------------+-------+
2 rows in set (0.00 sec)

mysql> -- 1) Perform Queries with Clauses:
mysql>  -- a) WHERE clause:
mysql> SELECT *
    -> FROM Customers
    -> WHERE Age > 25;
+------------+-----------+----------+------+
| CustomerID | FirstName | LastName | Age  |
+------------+-----------+----------+------+
|          1 | John      | Doe      |   30 |
+------------+-----------+----------+------+
1 row in set (0.00 sec)

mysql>  -- b) GROUP BY clause:
mysql> SELECT CustomerID, COUNT(*) AS OrderCount
    -> FROM Orders
    -> GROUP BY CustomerID;
+------------+------------+
| CustomerID | OrderCount |
+------------+------------+
|          1 |          1 |
|          2 |          1 |
+------------+------------+
2 rows in set (0.00 sec)

mysql> -- c) HAVING clause:
mysql> SELECT CustomerID, COUNT(*) AS OrderCount
    -> FROM Orders
    -> GROUP BY CustomerID
    -> HAVING OrderCount > 1;
Empty set (0.00 sec)

mysql> -- d) ORDER BY clause:
mysql> SELECT *
    -> FROM Customers
    -> ORDER BY LastName DESC;
+------------+-----------+----------+------+
| CustomerID | FirstName | LastName | Age  |
+------------+-----------+----------+------+
|          2 | Jane      | Smith    |   25 |
|          1 | John      | Doe      |   30 |
+------------+-----------+----------+------+
2 rows in set (0.00 sec)

mysql> -- 2) Perform All Joins:
mysql> -- Join the 3 tables based on common CustomerID and ProductID columns
mysql>  -- a) INNER JOIN:
mysql> SELECT Customers.FirstName, Orders.OrderDate, Products.ProductName
    -> FROM Customers
    -> INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    -> INNER JOIN Products ON Orders.ProductID = Products.ProductID;
+-----------+------------+-------------+
| FirstName | OrderDate  | ProductName |
+-----------+------------+-------------+
| John      | 2023-01-01 | Product 1   |
| Jane      | 2023-02-01 | Product 2   |
+-----------+------------+-------------+
2 rows in set (0.12 sec)

mysql> -- b) LEFT JOIN:
mysql> SELECT Customers.FirstName, Orders.OrderDate, Products.ProductName
    -> FROM Customers
    -> LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    -> LEFT JOIN Products ON Orders.ProductID = Products.ProductID;
+-----------+------------+-------------+
| FirstName | OrderDate  | ProductName |
+-----------+------------+-------------+
| John      | 2023-01-01 | Product 1   |
| Jane      | 2023-02-01 | Product 2   |
+-----------+------------+-------------+
2 rows in set (0.00 sec)

mysql> -- c) RIGHT JOIN:
mysql> SELECT Customers.FirstName, Orders.OrderDate, Products.ProductName
    -> FROM Customers
    -> RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    -> RIGHT JOIN Products ON Orders.ProductID = Products.ProductID;
+-----------+------------+-------------+
| FirstName | OrderDate  | ProductName |
+-----------+------------+-------------+
| John      | 2023-01-01 | Product 1   |
| Jane      | 2023-02-01 | Product 2   |
+-----------+------------+-------------+
2 rows in set (0.00 sec)

mysql> -- d) FULL OUTER JOIN:
mysql> SELECT Customers.FirstName, Orders.OrderDate, Products.ProductName
    -> FROM Customers
    -> FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    -> FULL OUTER JOIN Products ON Orders.ProductID = Products.ProductID;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
FULL OUTER JOIN Pr' at line 3

mysql> -- e) SELF JOIN:
mysql> SELECT c1.FirstName AS Customer1, c2.FirstName AS Customer2
    -> FROM Customers c1
    -> JOIN Customers c2 ON c1.CustomerID <> c2.CustomerID;
+-----------+-----------+
| Customer1 | Customer2 |
+-----------+-----------+
| Jane      | John      |
| John      | Jane      |
+-----------+-----------+
2 rows in set (0.00 sec)

mysql> -- f) CROSS JOIN:
mysql> SELECT Customers.FirstName, Products.ProductName
    -> FROM Customers
    -> CROSS JOIN Products;
+-----------+-------------+
| FirstName | ProductName |
+-----------+-------------+
| John      | Product 1   |
| Jane      | Product 1   |
| John      | Product 2   |
| Jane      | Product 2   |
+-----------+-------------+
4 rows in set (0.00 sec)

mysql> -- 3) Practice All Built-in functions:
mysql> -- a) STRING Functions:
mysql> SELECT CONCAT(FirstName, ' ', LastName) AS FullName
    -> FROM Customers;
+------------+
| FullName   |
+------------+
| John Doe   |
| Jane Smith |
+------------+
2 rows in set (0.00 sec)

mysql> SELECT UPPER(FirstName) AS UpperCaseName
    -> FROM Customers;
+---------------+
| UpperCaseName |
+---------------+
| JOHN          |
| JANE          |
+---------------+
2 rows in set (0.00 sec)

mysql> -- b) NUMERIC Functions:
mysql> SELECT AVG(Price) AS AveragePrice
    -> FROM Products;
+--------------+
| AveragePrice |
+--------------+
|    13.490000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT SUM(TotalAmount) AS TotalSales
    -> FROM Orders;
+------------+
| TotalSales |
+------------+
|     175.70 |
+------------+
1 row in set (0.00 sec)

mysql> -- c) DATE AND TIME Functions:
mysql> SELECT CURRENT_TIMESTAMP() AS CurrentDateTime;
+---------------------+
| CurrentDateTime     |
+---------------------+
| 2023-05-19 22:49:08 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT YEAR(OrderDate) AS OrderYear,
    ->        MONTH(OrderDate) AS OrderMonth,
    ->        DAY(OrderDate) AS OrderDay
    -> FROM Orders;
+-----------+------------+----------+
| OrderYear | OrderMonth | OrderDay |
+-----------+------------+----------+
|      2023 |          1 |        1 |
|      2023 |          2 |        1 |
+-----------+------------+----------+
2 rows in set (0.09 sec)

mysql>