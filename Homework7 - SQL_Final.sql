use sakila;

-- Display the first and last names of all actors from the table `actor`
SELECT first_name, last_name 
FROM actor;

-- Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT concat(UPPER(first_name), " " ,  UPPER(last_name)) AS 'Actor Name'
FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'Joe';

-- Find all actors whose last name contain the letters `GEN`:
SELECT last_name 
FROM actor 
WHERE last_name LIKE '%GEN%' ;

--  Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
SELECT last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor
ADD COLUMN Description VARCHAR(45)
AFTER last_update;

ALTER TABLE actor
MODIFY Description BLOB;

--  Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE actor
DROP COLUMN Description;

ALTER TABLE actor
ADD COLUMN Description BLOB;

ALTER TABLE actor
DROP COLUMN Description;

-- List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) AS Count_Actors
FROM actor 
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) AS Count_Actors
FROM actor 
GROUP BY last_name
HAVING Count_Actors >=2;

-- The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE Actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
SELECT *
  FROM ACTOR
 WHERE ACTOR_ID  = 172
;
-- You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE Address;

-- Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT   S.first_name
        ,S.last_name
        ,A.address

  FROM  STAFF   S 
  
  LEFT JOIN ADDRESS A
         ON S.address_id = A.address_id
 ;
-- Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT  P.staff_id
       ,concat(S.first_name,' ',S.last_name) as Name
       ,SUM(P.amount) as Total_Amount
  FROM PAYMENT P
  JOIN STAFF S ON P.staff_id = S.staff_id 
 GROUP BY P.staff_id
-- List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT   FA.film_id
,F.title
		,count(FA.actor_id) as Actor_Count
  FROM   FILM_ACTOR FA
		,FILM F 
 WHERE   FA.film_id = F.film_id
 GROUP BY FA.film_id
-- How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT  I.film_id, F.title
	   ,count(I.inventory_id) as count_copies
  FROM  INVENTORY I 
	   ,FILM F 
 WHERE  I.film_id in 
        (SELECT F.film_id FROM FILM F 
          WHERE F.title like 'Hunchback%Impossible%')
   AND I.FILM_ID = F.FILM_ID
 GROUP BY 1
 ;
-- Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
select    C.first_name, C.last_name, Sum(P.amount) as Cust_Total 
  from    PAYMENT  P
	     ,CUSTOMER C
where     P.customer_id = C.customer_id
Group BY  C.last_name, C.first_name
ORDER BY  C.last_name  
;
-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
SELECT title 
  FROM FILM F
 WHERE ((F.title like 'K%')  OR
	   (F.title like 'Q%')  AND
	   (F.language_id IN  ( Select language_id 
							from  language L
                            where L.name = 'English' )))
					                        
 ;
-- Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT title 
  FROM FILM F
 WHERE ((F.title like 'K%')  OR
	   (F.title like 'Q%')  AND
	   (F.language_id IN  ( Select language_id 
							from  language L
                            where L.name = 'English' )))
					                        
 ;
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT C.first_name, C.last_name, C.email
  FROM CUSTOMER C
 WHERE address_id in (select  A.address_id 
                        from  ADDRESS A
                             ,CITY    CI
                             ,COUNTRY CN
                       where  A.city_id     = CI.city_id
                         AND  CI.country_id = CN.country_id
                         AND  CN.country = 'Canada')
					  
;

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
SELECT F.title, F.description
  from FILM F
 WHERE F.film_id in 
                (select  FC.film_id 
                   from  film_category FC
                        ,Category      C
				  where  FC.category_id = C.category_id
                    and  C.name = 'Family'
                )
;		
-- Display the most frequently rented movies in descending order.
select  I.film_id, F.title,  count(*) as count_rented
 from   rental    R 
       ,inventory I 
       ,Film      F
where   R.inventory_id = I.inventory_id
  and   I.film_id      = F.film_id
Group by I.film_id, F.title
order by count_rented Desc
;
-- Write a query to display how much business, in dollars, each store brought in.
SELECT    C.store_id, Sum(P.amount) as Total_store
    From  Payment  P
         ,Customer C
         
	where  P.customer_id = C.customer_id 
    Group by C.store_id
;
-- Write a query to display for each store its store ID, city, and country.
SELECT S.store_id, CI.city, CN.country
 FROM  STORE   S
      ,ADDRESS A
      ,CITY    CI
      ,COUNTRY CN
 
 where S.address_id  = A.address_id
   and A.city_id     = CI.city_id
   and CI.country_id = CN.country_id
;
-- List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT C.name as Genre, sum(P.AMOUNT) as Gross_revenue
  FROM   PAYMENT  P
		,RENTAL   R
        ,inventory I
        ,FILM_CATEGORY FC
        ,Category  C
WHERE    P.rental_id = R.rental_id
  AND    R.inventory_id = I.inventory_id
  AND    I.film_id      = FC.film_id
  AND    FC.category_id = C.category_id
GROUP BY C.name
ORDER BY 2 DESC
LIMIT  5 
;  
-- In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW Gross_revenue_genre as 
	(SELECT C.name as Genre, sum(P.AMOUNT) as Gross_revenue
	  FROM   PAYMENT  P
			,RENTAL   R
			,inventory I
			,FILM_CATEGORY FC
			,Category  C
	WHERE    P.rental_id = R.rental_id
	  AND    R.inventory_id = I.inventory_id
	  AND    I.film_id      = FC.film_id
	  AND    FC.category_id = C.category_id
	GROUP BY C.name
	ORDER BY 2 DESC
	LIMIT  5 )
;
-- How would you display the view that you created in previous question?
SHOW CREATE VIEW Gross_revenue_genre;
-- You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW Gross_revenue_genre;


