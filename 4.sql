SELECT "username"
FROM "users"
JOIN "messages"
WHERE "users"."id"="messages"."to_user_id"
GROUP BY "to_user_id"
ORDER BY COUNT("to_user_id") DESC, "username"
LIMIT 1;

-- When we ran EXPLAIN QUERY PLAN, we could see that the messages table
--was being scanned using the Covering Index mentioned in the problem.
--Simlarly, users table being searched using the autoindex as the search is on the Integer Primary Key.
--Order By is done using B-Trees.
