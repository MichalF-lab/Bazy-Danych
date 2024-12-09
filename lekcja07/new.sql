USE piaskownica;

CREATE TABLE actor_275951(
    actor_id SMALLINT auto_increment,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    last_update TIMESTAMP default current_timestamp,
    primary key(actor_id)
);

DROP TABLE actor_275951;

CREATE TABLE piaskownica.film_275951 SELECT * FROM sakila.film;

SELECT * FROM piaskownica.actor_275951;

SELECT * 
FROM sakila.customer 
JOIN sakila.rental using(customer_id)
JOIN sakila.inventory using(inventory_id)
WHERE film_id = 2


DELETE FROM piaskownica.film_275951
JOIN sakila.film_category using(film_id)
JOIN sakila.category using(category_id)
WHERE name = "Drama"