-- Wszytsko Jest
SELECT *
FROM sakila.actor
WHERE first_name IS NULL 
   OR first_name = ''
   OR last_name IS NULL 
   OR last_name = ''
   OR last_update IS NULL
   OR last_update = '';

-- Bez przesady

-- Zad 2
SELECT title
FROM sakila.film
ORDER BY release_year ASC
LIMIT 10;

SELECT title
FROM sakila.film
ORDER BY release_year DESC
LIMIT 10;

