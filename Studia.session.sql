SELECT COUNT(actor_id)
FROM sakila.actor;

SELECT COUNT(emp_no)
FROM employees.employees;

SELECT COUNT(EmployeeID)
FROM nortwind.Employees;

SELECT COUNT(customer_id)
FROM sakila.customer;

SELECT COUNT(CustomerID)
FROM nortwind.Customers;

SELECT COUNT(EmployeeID)
FROM nortwind.Employees
WHERE birth_date LIKE "%-01-16"

SELECT COUNT(emp_no)
FROM employees.employees
WHERE birth_date LIKE "%-01-16"

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
WHERE country_id = 76

SELECT territory_id
FROM nortwind.Territories
WHERE territoryDescription LIKE "Seattle";

SELECT COUNT(emp_no)
FROM employees.employees;