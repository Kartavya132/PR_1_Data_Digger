CREATE DATABASE data_digger;
USE data_digger;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(40),
    email VARCHAR(30),
    address VARCHAR(70)
    );

INSERT INTO customers VALUES 
(1, 'Alice', 'alice@gmail.com', 'alice house'), 
(2, 'Bob', 'bob@gmail.com', 'bob house'), 
(3, 'Charlie', 'charlie@gmail.com', 'charlie home'), 
(4, 'Darwin', 'darwin@gmail.com', 'darwin house'), 
(5, 'Eleth', 'Eleth@gmail.com', 'Eleth house'), 
(6, 'Alice', 'alices1@gmail.com', 'Amma house');

SELECT * FROM customers;

UPDATE customers
SET address = 'charlie house'
WHERE customer_id = 3;
DELETE FROM customers
WHERE customer_id = 5;
SELECT * FROM customers 
WHERE name = 'Alice';


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    customer_id INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO Orders (OrderID, customer_id, OrderDate, TotalAmount) VALUES
(101, 1, '2026-07-01', 1500.00),
(102, 2, '2026-07-05', 2200.50),
(103, 3, '2026-06-20', 800.00),
(104, 1, '2026-07-15', 3200.75),
(105, 4, '2026-07-10', 500.00);

SELECT * FROM Orders
WHERE customer_id = 1;

UPDATE Orders
SET TotalAmount = 1750.00
WHERE OrderID = 101;

DELETE FROM Orders
WHERE OrderID = 103;

SELECT * FROM Orders
WHERE OrderDate >= '2026-07-23' ;

SELECT 
    MAX(TotalAmount) AS Highest_Order,
    MIN(TotalAmount) AS Lowest_Order,
    AVG(TotalAmount) AS Average_Order
FROM Orders;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Price, Stock) VALUES
(1, 'Wireless Mouse', 450.00, 25),
(2, 'Bluetooth Headphones', 1800.00, 10),
(3, 'USB Keyboard', 650.00, 0),
(4, 'Laptop Stand', 1200.00, 15),
(5, 'Webcam HD', 2200.00, 8);

SELECT * FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 500.00
WHERE ProductID = 1;

DELETE FROM Products
WHERE Stock = 0;

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;

SELECT 
    MAX(Price) AS Most_Expensive,
    MIN(Price) AS Cheapest
FROM Products;


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 101, 1, 2, 1000.00),
(2, 101, 4, 1, 1200.00),
(3, 102, 2, 1, 1800.00),
(4, 104, 5, 1, 2200.00),
(5, 105, 4, 1, 1200.00);

SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS Total_Revenue
FROM OrderDetails;

SELECT ProductID, SUM(Quantity) AS Total_Quantity_Sold
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Quantity_Sold DESC
LIMIT 3;

SELECT ProductID, COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 4
GROUP BY ProductID;