USE SAKILA;

-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.
select c.first_name AS FN, c.last_name AS LN, c.email AS Mail
from customer c
join (
	select customer_id, max(rental_date) AS rental 
    from rental
    group by customer_id) r
    on c.customer_id = r.customer_id
group by FN, LN, Mail;

-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), 
-- and the average payment made).

select * from customer; -- customer_id, customer name (first_name)
select * from payment; -- customer_id, amount

select c.first_name AS FN, c.last_name AS LN, Avg_Amount
from customer c
join (
	select customer_id, round(avg(amount),2) AS Avg_Amount 
    from payment
    group by customer_id) p
    on c.customer_id = p.customer_id;

-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
-- 3.a Write the query using multiple join statements
-- 3.b Write the query using sub queries with multiple WHERE clause and IN condition
-- 3-c Verify if the above two queries produce the same results or not

-- From Customer: customer_id, customer name (first_name), email
-- From Rental: customer_id, inventory_id
-- From Inventory: inventory_id, film_id
-- From Film_Category: film_id, category_id
-- From Category: category_id, name (category)

select FN, EM from (
	select c.first_name AS FN, c.email AS EM, name
	from customer c
	join rental r ON c.customer_id = r.customer_id
	join inventory i ON r.inventory_id = i.inventory_id
	join film_category f ON  i.film_id = f.film_id
	join category ca ON f.category_id = ca.category_id
	where name = 'Action') sub1;
    
-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the 
-- amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, --
-- the label should be medium, and if it is more than 4, then it should be high.

-- 0 < Amount < 2 : Low
-- 2 < Amount < 4 : Medium
-- 4 < Amount : High

select * from payment;

select amount AS AMOUNT,
	case when 0 < amount and amount <= 2 Then amount end as L,
    case when 2 < amount and amount <= 4 Then amount end as M,
    case when 4 < amount Then amount end as H 
from payment;

