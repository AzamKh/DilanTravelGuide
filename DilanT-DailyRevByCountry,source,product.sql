--Daily revenue based on Country, source, date registered, type of purchase, # of users
SELECT 
       country,
       source,
       DATE(new_readers.my_date),
       buyers.price,       
       COUNT(new_readers.user_id) AS new_readers_users,
       SUM(price)
FROM new_readers,buyers
WHERE new_readers.user_id = buyers.user_id
GROUP BY country,
         source,
         DATE(new_readers.my_date),
         price
ORDER BY country,
         source,
         DATE(new_readers.my_date), price;
