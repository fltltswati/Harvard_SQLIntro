SELECT "username"
FROM "users"
WHERE "last_login_date">='2024-01-01';

--Through EXPLAIN QUERY PLAN, we can see that the query is utilizing the INDEX search_users_by_last_login.
