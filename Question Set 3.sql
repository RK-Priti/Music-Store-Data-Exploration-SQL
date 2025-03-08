--1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent 
WITH Best_Artist AS(
Select Top 1 artist.artist_id,artist.name [artist_name],
SUM(invoice_line.unit_price*invoice_line.quantity) [TOTAL SALES]
from invoice_line
JOIN track ON track.track_id=invoice_line.track_id
JOIN album ON album.album_id= track.album_id
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.artist_id,artist.name
order by [TOTAL SALES] desc
)
SELECT Top 5 customer.customer_id,customer.first_name,customer.last_name,BSA.artist_name,SUM(invoice_line.quantity*invoice_line.unit_price) [TOTAL SPEND]
FROM invoice 
JOIN customer ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN album ON album.album_id = track.album_id
JOIN Best_Artist BSA  ON BSA.artist_id = album.artist_id
GROUP BY customer.customer_id,customer.first_name,customer.last_name,BSA.artist_name
order by [TOTAL SPEND] DESC

--2. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres 
With Popular_Genre as(
Select i.billing_country [Country],g.name [Genre Name],
COUNT(il.quantity) AS Total,
Row_Number() 
OVER(Partition by i.billing_country ORDER BY COUNT(il.quantity)DESC) as [Row]
from invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON t.genre_id = g.genre_id
group by i.billing_country,g.name
)
select * from Popular_Genre
Where Row<=1
Order by Country ASC,Total Desc

--3. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount 

WITH TOP_CUSTOMER AS(
Select c.customer_id,c.first_name,c.last_name,i.billing_country [Country],SUM(i.total) AS [Total Spend],
ROW_NUMBER() over(Partition by(i.billing_country) Order BY(SUM(i.total))Desc) [Rank]
from customer c 
JOIN invoice i ON c.customer_id = i.customer_id
group by  c.customer_id,c.first_name,i.billing_country,c.last_name
)
Select * from TOP_CUSTOMER
Where Rank<=1
ORDER BY Country ASC,[Total Spend] DESC

