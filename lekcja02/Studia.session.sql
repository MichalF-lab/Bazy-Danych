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
LIMIT 1;

SELECT title
FROM sakila.film
ORDER BY release_year DESC
LIMIT 1;

SELECT title
FROM sakila.film
WHERE release_year = (SELECT MAX(release_year) FROM sakila.film)
   OR release_year = (SELECT MIN(release_year) FROM sakila.film);

-- Zad 3
SELECT title
FROM sakila.film
ORDER BY title ASC
LIMIT 10;

SELECT title
FROM (SELECT title
      FROM sakila.film
      ORDER BY title ASC
      LIMIT 10) AS subq
ORDER BY title DESC
LIMIT 1;

-- Zad 4
SELECT count(film_id)
FROM sakila.film
WHERE description LIKE '% SUMO %';

-- Zad 5

