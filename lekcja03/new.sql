#Zad 1
SELECT last_name AS 'Aktorzy o dwuliterowych imionach'
FROM sakila.actor
WHERE first_name LIKE '__'
ORDER BY last_name;

#Zad 2
SELECT title, substring(description, 2) AS opis
FROM sakila.film
WHERE description NOT LIKE "%boring%"
ORDER BY opis;

#Zad 3
SELECT customer.customer_id, COUNT(rental.rental_id) * 0.5 AS doplata
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.rental_date BETWEEN '2005-07-01' AND '2005-08-31'
AND rental.return_date > '2005-08-31'
GROUP BY customer.customer_id;

#Zad 4
SELECT city_id, GROUP_CONCAT(DISTINCT district ORDER BY district ASC SEPARATOR ' oraz ') AS dystrykty
FROM address
GROUP BY city_id
HAVING COUNT(DISTINCT district) > 1
ORDER BY city_id DESC;

#Zad 5
SELECT staff_id, SUM(amount), SUM(amount)/COUNT(staff_id)
FROM payment
GROUP BY staff_id;

#Zad 6
SELECT MAX(return_date - rental_date) / 216000, MIN(return_date - rental_date)/ 216000
FROM rental

#Zad 7
SELECT customer_id, AVG(return_date - rental_date) / 216000 AS xd
FROM rental
ORDER BY xd DESC
LIMIT 1