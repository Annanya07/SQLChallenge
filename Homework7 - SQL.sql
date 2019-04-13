use sakila;

-- Display the first and last names of all actors from the table `actor`
SELECT first_name, last_name 
FROM actor;

-- Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT concat(UPPER(first_name), " " ,  UPPER(last_name)) AS 'Actor Name'
FROM actor

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'Joe' ;

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
ADD column 'Description' BLOB;
--  Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.

-- List the last names of actors, as well as how many actors have that last name.
SELECT last_name FROM * 
-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

-- The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.

-- Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.

-- You cannot locate the schema of the `address` table. Which query would you use to re-create it?

-- Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

-- Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

-- List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.

-- How many copies of the film `Hunchback Impossible` exist in the inventory system?

-- Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.

-- Use subqueries to display all actors who appear in the film `Alone Trip`.

-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.

-- Display the most frequently rented movies in descending order.

-- Write a query to display how much business, in dollars, each store brought in.

-- Write a query to display for each store its store ID, city, and country.

-- List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

-- In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

-- How would you display the view that you created in previous question?

-- You find that you no longer need the view `top_five_genres`. Write a query to delete it.


