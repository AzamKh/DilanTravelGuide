--Final solutions from Azam
SELECT reg.date,
       reg.source,
       reg.country,
       reg.reg,
       return_readers_users.return_readers_users,
       subscribers_users.subscribers_users,
       paying_users.paying_users
FROM
    --FUNNEL #1 - new_readers
    (SELECT DATE(my_date),
            source,
            country,
            COUNT(*) AS reg
     FROM new_readers
     GROUP BY DATE(my_date),
              source,
              country
     ORDER BY DATE(my_date)) AS reg
LEFT JOIN
    --FUNNEL #2 - NUMBER OF USERS (return_readers)
   (SELECT DATE(new_readers.my_date),
           new_readers.source,
           new_readers.country,
           COUNT(DISTINCT (return_readers.user_id)) AS return_readers_users
    FROM return_readers
      JOIN new_readers ON new_readers.user_id = return_readers.user_id
    GROUP BY DATE(new_readers.my_date),
             new_readers.source,
             new_readers.country
    ORDER BY DATE(new_readers.my_date)) AS return_readers_users
ON reg.date = return_readers_users.date
   AND reg.source = return_readers_users.source
   AND reg.country = return_readers_users.country
LEFT JOIN
    --FUNNEL #3 - NUMBER OF USERS (subscribers)
   (SELECT DATE(new_readers.my_date),
           new_readers.source,
           new_readers.country,
           COUNT(DISTINCT (subscribers.user_id)) AS subscribers_users
    FROM subscribers
      JOIN new_readers ON new_readers.user_id = subscribers.user_id
    GROUP BY DATE(new_readers.my_date),
             new_readers.source,
             new_readers.country
    ORDER BY DATE(new_readers.my_date)) AS subscribers_users
ON reg.date = subscribers_users.date
   AND reg.source = subscribers_users.source
   AND reg.country = subscribers_users.country
LEFT JOIN
   --FUNNEL #4 - NUMBER OF USERS (PAID buyers)
   (SELECT DATE(new_readers.my_date),
           new_readers.source,
           new_readers.country,
           COUNT(paying_users.user_id) AS paying_users
    FROM (SELECT user_id,
                 COUNT(*)
          FROM buyers
          GROUP BY user_id) AS paying_users
      JOIN new_readers ON new_readers.user_id = paying_users.user_id
    GROUP BY DATE(new_readers.my_date),
             new_readers.source,
             new_readers.country
    ORDER BY DATE(new_readers.my_date)) AS paying_users
ON reg.date = paying_users.date
   AND reg.source = paying_users.source
   AND reg.country = paying_users.country;
