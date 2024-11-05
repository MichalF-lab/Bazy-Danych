-- Wyswietlic fimlmy bez jezyka angielskiego

SELECT title, name
FROM film
JOIN language USING(language_id)
WHERE name NOT LIKE 'English'

-- Ile jest kopi filmów w naszym sklepie oraz jakiego sa gatunku
SELECT name, title, COUNT(inventory_id)
FROM category
JOIN film_category USING(category_id)
JOIN film USING(film_id)
JOIN inventory USING(film_id)
GROUP BY title


