-- Zad 1
SELECT COUNT(actor_id), first_name
FROM sakila.actor
WHERE first_name LIKE 'A_A_'
GROUP BY first_name;

-- Zad 2
SELECT first_name
FROM sakila.actor
WHERE first_name LIKE "%chris%";

-- Zad 3
SELECT last_name, first_name
FROM (
    SELECT last_name, first_name
    FROM sakila.actor
    ORDER BY last_name ASC, first_name ASC
    LIMIT 50
) AS XD
ORDER BY last_name DESC, first_name DESC
LIMIT 1;

-- Zad 4
SELECT film_id, Temp As counts
FROM(
    SELECT film_id, COUNT(inventory_id) As Temp
    FROM inventory
    GROUP BY film_id
) As XD
WHERE Temp = 3;

-- Zad 5
SELECT COUNT(film_id), rating, MAX(length) - MIN(length)
FROM film
GROUP BY rating;

-- Zad 6
SELECT COUNT(film_id), rating, MAX(length) - MIN(length) AS length_difference
FROM film
GROUP BY rating
ORDER BY CAST(rating AS CHAR);
