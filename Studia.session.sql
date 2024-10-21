SELECT email, COUNT(customer_id)
FROM sakila.customer
WHERE NOT email LIKE "%@sakilacustomer.org"
GROUP BY email