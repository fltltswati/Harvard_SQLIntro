SELECT "to_user_id"
FROM "messages"
WHERE "from_user_id"=(
    SELECT "id"
    FROM "users"
    WHERE "username"='creativewisdom377')
GROUP BY "to_user_id"
ORDER BY COUNT("to_user_id") DESC
LIMIT 3;

-- We can see that the query uses the  INDEX search_messages_by_from_user_id on messages table.
-- Also, the Covering Index sqlite_autoindex_users_1 is utilized to search users in the users table.
--The query also utilises Temp B-Trees for grouping and ordering data in the end.

