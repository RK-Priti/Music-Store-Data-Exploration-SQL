--1. Who is the senior most employee based on job title? 
Select Top 1 employee_id,CONCAT(first_name,' ',last_name)[Name] from [dbo].[employee]
order by hire_date

--2. Which countries have the most Invoices? 
select count(*)as Count,billing_country from invoice
group by billing_country
order by Count desc;

--3. What are top 3 values of total invoice? 
select top 3 Total from invoice
order by total desc;

--4. Which city has the best customers? We would like to throw a promotional Music 
--Festival in the city we made the most money. Write a query that returns one city that 
--has the highest sum of invoice totals. Return both the city name & sum of all invoice 
--totals 
Select billing_city,Sum(total) [Total Invoice] from invoice
group by billing_city
order by [Total Invoice] desc;

--5. Who is the best customer? The customer who has spent the most money will be 
--declared the best customer. Write a query that returns the person who has spent the 
--most money 
select c.customer_id,c.first_name,c.last_name, SUM(i.total) Total from invoice i join customer c
on i.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by Total desc;

