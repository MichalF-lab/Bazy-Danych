-- Zad 1
SELECT first_name, last_name, email, address, phone
FROM sakila.staff
JOIN address ON address.address_id = staff.address_id;

-- Zad 2
SELECT city, country
FROM city
JOIN country ON country.country_id = city.country_id;

-- Zad 3
SELECT address, city, country
FROM address
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id;

-- Zad 4
SELECT first_name, last_name, email, address, phone, city
FROM sakila.staff
JOIN address ON address.address_id = staff.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id;

-- Zad 5
SELECT first_name, address, COUNT(rental.rental_id)
FROM staff
JOIN rental ON rental.staff_id = staff.staff_id
JOIN inventory On inventory.inventory_id = rental.inventory_id
JOIN store ON store.store_id = inventory.store_id
JOIN address ON address.address_id = store.address_id
GROUP BY first_name, address;

-- Zad 6
SELECT first_name, last_name, title
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film On film.film_id = film_actor.film_id;

-- Zad 7
SELECT first_name, last_name, title
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film On film.film_id = film_actor.film_id
WHERE title LIKE '%egg%'

-- Zad 8
SELECT customer.first_name, customer.last_name, customer.email, phone, address, city, country, staff.first_name, staff.last_name
FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
JOIN inventory On inventory.inventory_id = rental.inventory_id
JOIN store ON store.store_id = inventory.store_id
JOIN address ON address.address_id = store.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id
JOIN staff On staff.staff_id = store.manager_staff_id
WHERE customer.first_name = 'ALAN' AND customer.last_name = 'KAHN'
GROUP BY address;

-- Zad 9
SELECT rental_date, title, return_date, amount, payment_date
FROM rental
JOIN payment USING (rental_id)
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
WHERE customer.first_name = 'ALAN' AND customer.last_name = 'KAHN';