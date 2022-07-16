CREATE TABLE company (
  month DATE,
  customer_id INT,
  campaign_name VARCHAR(1),
  order_value INT
);

-- -----------------------------------------------------------------------------

-- Company (adding in manually due to localhost server. I'll learn the more advanced way too after this!)
INSERT INTO company VALUES('2021-01-01', 1, 'A', 100);
INSERT INTO company VALUES('2021-01-01', 2, 'A', 200);
INSERT INTO company VALUES('2021-01-01', 3, 'A', 5000);
INSERT INTO company VALUES('2021-01-01', 4, 'B', 700);

INSERT INTO company VALUES('2021-02-01', 5, 'B', 350);
INSERT INTO company VALUES('2021-02-01', 6, 'B', 100);
INSERT INTO company VALUES('2021-02-01', 7, 'C', 200);
INSERT INTO company VALUES('2021-02-01', 8, 'A', 5000);
INSERT INTO company VALUES('2021-02-01', 9, 'C', 50);
INSERT INTO company VALUES('2021-02-01', 10, 'A', 800);

INSERT INTO company VALUES('2021-03-01', 1, 'A', 700);
INSERT INTO company VALUES('2021-03-01', 2, 'B', 350);
INSERT INTO company VALUES('2021-03-01', 3, 'C', 1200);
INSERT INTO company VALUES('2021-03-01', 1, 'A', 800);

INSERT INTO company VALUES('2021-04-01', 7, 'D', 550);
INSERT INTO company VALUES('2021-04-01', 5, 'A', 300);
INSERT INTO company VALUES('2021-04-01', 3, 'B', 100);
INSERT INTO company VALUES('2021-04-01', 4, 'D', 350);
INSERT INTO company VALUES('2021-04-01', 6, 'C', 1400);

INSERT INTO company VALUES('2021-05-01', 10, 'B', 250);
INSERT INTO company VALUES('2021-05-01', 9, 'C', 100);
INSERT INTO company VALUES('2021-05-01', 8, 'A', 1000);
INSERT INTO company VALUES('2021-05-01', 7, 'D', 400);

-- -----------------------------------------------------------------------------

-- Question 1:- Campaign-wise total value of orders for first five months.

CREATE TABLE A ( 
  SELECT month, sum(order_value) AS A_Total_order_value
  FROM company
  WHERE campaign_name = 'A'
  GROUP BY month
);

CREATE TABLE B ( 
  SELECT month, sum(order_value) AS B_Total_order_value
  FROM company
  WHERE campaign_name = 'B'
  GROUP BY month
);

CREATE TABLE C ( 
  SELECT month, sum(order_value) AS C_Total_order_value
  FROM company
  WHERE campaign_name = 'C'
  GROUP BY month
);

CREATE TABLE D ( 
  SELECT month, sum(order_value) AS D_Total_order_value
  FROM company
  WHERE campaign_name = 'D'
  GROUP BY month
);


SELECT A.month, A.A_Total_order_value, B.B_Total_order_value, C.C_Total_order_value, D.D_Total_order_value
FROM A
JOIN B
ON A.month = B.month
LEFT JOIN C 
ON B.month = C.month
LEFT JOIN D
ON D.month = B.month;


-- -----------------------------------------------------------------------------

-- Question 2:- No. of orders per month & cumulative orders per month.

CREATE TABLE Q2 ( 
  SELECT month, COUNT(month) AS 'Orders'
  FROM company
  GROUP BY month
);

SELECT month, Q2.Orders, (@csum := @csum + Orders) AS cumulative_orders
FROM Q2
JOIN (SELECT @csum := 0) r 
GROUP BY month;

-- -----------------------------------------------------------------------------

-- Question 3:- How many new & repeat customers?

SELECT month, COUNT(DISTINCT(customer_id)) AS new_customers,
(COUNT(customer_id) - COUNT(DISTINCT(customer_id))) AS repeat_customers
FROM company
GROUP BY month;


-- -----------------------------------------------------------------------------

-- Question 4:- For each month, no. of orders by order_value_bucket?


SELECT month,  COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 100 AND month LIKE '____-01-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 500 AND company.order_value > 100 AND
month LIKE '____-01-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 1000 AND company.order_value > 500 AND
month LIKE '____-01-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value > 1000 AND
month LIKE '____-01-__'
UNION ALL
SELECT month,  COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 100 AND month LIKE '____-02-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 500 AND company.order_value > 100 AND
month LIKE '____-02-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 1000 AND company.order_value > 500 AND
month LIKE '____-02-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value > 1000 AND
month LIKE '____-02-__'
UNION ALL
SELECT month,  COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 100 AND month LIKE '____-03-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 500 AND company.order_value > 100 AND
month LIKE '____-03-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value < 1000 AND company.order_value > 500 AND
month LIKE '____-03-__'
UNION ALL
SELECT month, COUNT(month) AS number_of_orders
FROM company
WHERE company.order_value > 1000 AND
month LIKE '____-03-__';
