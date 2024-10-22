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
) AS NOPOWAZNIE
ORDER BY last_name DESC, first_name DESC
LIMIT 1;


