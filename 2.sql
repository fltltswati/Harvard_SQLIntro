SELECT "expires_timestamp"
FROM "messages"
WHERE "id"='151';

--Through EXPLAIN QUERY PLAN, we can see that the query is utilizing the index on the primary key column.
