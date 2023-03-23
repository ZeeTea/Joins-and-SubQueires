-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name
FROM address a
JOIN customer c
ON c.address_id = a.address_id  
WHERE district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM payment p
JOIN customer c 
ON p.customer_id = c.customer_id
WHERE p.amount >= 6.99
ORDER BY amount DESC;

-- 3. Show all customers names who have made payments over $175(use subqueries)
--SELECT first_name, last_name, amount
--FROM payment p
--JOIN customer c 
--ON p.customer_id = c.customer_id
--WHERE p.amount >= 175
--ORDER BY amount DESC;

-- is this ment to be $1.75 or $175 in total payments, no payment made over 12.00 ?
SELECT *
FROM payment 
WHERE customer_id= (
    SELECT customer_id
    FROM "payment"
    WHERE "amount" >= 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM country c 
JOIN city c2 
ON c.country_id = c2.country_id 
JOIN address a 
ON c2.city_id = a.city_id 
JOIN  customer c3 
ON a.address_id = c3.address_id 
WHERE country = 'Nepal'

-- 5. Which staff member had the most transactions?
SELECT s.first_name, COUNT(*) AS transactions
FROM staff s 
JOIN payment p
ON p.staff_id = s.staff_id
GROUP BY s.staff_id
ORDER BY transactions DESC
LIMIT 1;
-- unable to make it "from payment", had to be "from staff", unsure as to why...?

-- 6. How many movies of each rating are there?
SELECT rating, count(*) AS movies
FROM film f 
GROUP BY rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT *
FROM payment 
WHERE customer_id IN (
    SELECT customer_id
    FROM "payment"
    WHERE amount > 6.99
    ORDER BY amount DESC 
);
-- why does this still show numbers below 6.99?

-- 8. How many free rentals did our store give away?

SELECT amount, count(*) AS free_rentals
FROM payment p 
WHERE amount = 0
GROUP BY amount;
