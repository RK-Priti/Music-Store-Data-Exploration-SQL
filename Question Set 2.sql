--1. Write query to return the email, first name, last name, & Genre of all Rock Music 
--listeners. Return your list ordered alphabetically by email starting with A 
SELECT distinct c.email, c.first_name, c.last_name 
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE il.track_id IN (
    SELECT t.track_id 
    FROM track t  
    INNER JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name = 'Rock'
)
Order By c.email;


--2. Let's invite the artists who have written the most rock music in our dataset. Write a 
--query that returns the Artist name and total track count of the top 10 rock bands 
Select distinct top 10 a.artist_id,a.name,Count(a.artist_id) [Total Track] from artist a Join album ab ON 
a.artist_id = ab.artist_id join track t ON
ab.album_id = t.album_id Where t.track_id IN(
Select t.track_id from track t join genre g ON
t.genre_id = g.genre_id 
Where g.name like 'Rock'
)
group by a.name,a.artist_id
order by [Total Track] desc;


--3. Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the 
--longest songs listed first 
Select name,milliseconds from track
where milliseconds >(
Select AVG(milliseconds) from track
)
order by milliseconds desc;
;