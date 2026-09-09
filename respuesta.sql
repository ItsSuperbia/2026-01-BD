-- Select the name of the products sold by all employees
SELECT p.productname
FROM products p
JOIN orderdetails od ON p.productid = od.productid
JOIN orders o ON od.orderid = o.orderid
WHERE o.employeeid IS NOT NULL
GROUP BY p.productid, p.productname
HAVING COUNT(DISTINCT o.employeeid) = (
    SELECT COUNT(*)
    FROM employees
);


-- Select the name of the customers who purchased only products with a price less than 50
SELECT c.contactname
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN orderdetails od ON o.orderid = od.orderid
JOIN products p ON od.productid = p.productid
GROUP BY c.customerid, c.contactname
HAVING MAX(p.unitprice) < 50;

-- Select the title and name of the employees who have sold at least one
-- of the 'Gravad Lax' or 'Mishi Kobe Niku' products
SELECT DISTINCT 
    e.title,
    e.firstname,
    e.lastname
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN orderdetails od ON o.orderid = od.orderid
JOIN products p ON od.productid = p.productid
WHERE p.productname IN ('Gravad Lax', 'Mishi Kobe Niku');

-- Select the employee name and customer name for orders sent by
-- Speedy Express to customers living in Brussels
SELECT DISTINCT
    e.firstname || ' ' || e.lastname AS employee_name,
    c.contactname AS customer_name
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN customers c ON o.customerid = c.customerid
JOIN shippers s ON o.shipvia = s.shipperid
WHERE s.companyname = 'Speedy Express'
  AND c.city = 'Brussels';

-- Select the name, address, city, and region of the employees who
-- have placed orders for delivery in Belgium
SELECT DISTINCT
    e.firstname || ' ' || e.lastname AS employee_name,
    e.address,
    e.city,
    e.region
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
WHERE o.shipcountry = 'Belgium';