use sakila;

-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
select floor(avg(length)) 
from film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select DATEDIFF(max(rental_date),min(rental_date))
from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, date_format(rental_date,"%M"), date_format(rental_date,"%D")
from rental;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
select *,
CASE 
    when dayofweek(rental_date)=1  or dayofweek(rental_date)=7 then "weekend"
    else "workday"
END AS DAY_TYPE
from rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, 
CASE 
when length is null then "Not Available"
else length
end as length
from film
order by title ASC;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select *
from customer;

select concat(first_name," ",last_name), substring(email,1,3)
from customer
order by last_name ASC;

-- Challenge 2
-- 1.1 The total number of films that have been released.
select count(release_year)
from film;

-- 1.2 The number of films for each rating.
select rating,count(*)
from film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating,count(*)
from film
group by rating
order by count(*) desc;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length),2)
from film
group by rating
order by avg(length) desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length),2)
from film
group by rating
having avg(length)>120;

-- Bonus: determine which last names are not repeated in the table actor.
select DISTINCT last_name
from actor;


