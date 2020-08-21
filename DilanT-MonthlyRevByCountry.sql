--Monthly revenue based on Country, source, month registered on travel guide site
SELECT 
       country,
       source,
       EXTRACT (MONTH FROM DATE(new_readers.my_date)) as month,
       SUM(price)
FROM new_readers,buyers
WHERE new_readers.user_id = buyers.user_id
GROUP BY country,
         source,
         month
ORDER BY country,
         source,
         month;
