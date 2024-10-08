SELECT COUNT(actor_id)
FROM sakila.actor;

SELECT COUNT(emp_no)
FROM employees.employees;

SELECT COUNT(EmployeeID)
FROM northwind.Employees;

SELECT COUNT(customer_id)
FROM sakila.customer;

SELECT COUNT(CustomerID)
FROM northwind.Customers;

SELECT COUNT(EmployeeID)
FROM northwind.Employees
WHERE BirthDate LIKE "%-01-16";

SELECT COUNT(emp_no)
FROM employees.employees
WHERE birth_date LIKE "%-01-16";

SELECT city_id, city, country_id
FROM sakila.city
WHERE city = "Wroclaw";

SELECT first_name, last_name
FROM sakila.actor
WHERE first_name LIKE "JOHNNY" AND last_name LIKE "DEPP"

-----------------------------------------------------
-- ZADANIA DODATKOWE

SELECT COUNT(actor_id)
FROM sakila.actor
WHERE first_name LIKE "A%";

SELECT COUNT(actor_id)
FROM sakila.actor
WHERE first_name LIKE "JULIA";

SELECT COUNT(city_id)
FROM sakila.city
WHERE country_id = 76;

SELECT TerritoryID
FROM northwind.Territories
WHERE TerritoryDescription = "Seattle";

SELECT COUNT(emp_no)
FROM employees.employees;