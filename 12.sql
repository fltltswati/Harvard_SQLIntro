WITH "temp" AS
(SELECT *
FROM (
    SELECT *, players.id AS "pid"
    FROM "salaries"
    JOIN "performances" ON "salaries"."player_id"="performances"."player_id" AND "salaries"."year"="performances"."year"
    JOIN "players" ON "salaries"."player_id"="players"."id"
    WHERE "salaries"."year"=2001 AND "H"!=0
    ORDER BY ("salary"/"H")
    LIMIT 10
    )
INTERSECT
SELECT *
FROM (
    SELECT *, players.id AS "pid"
    FROM "salaries"
    JOIN "performances" ON "salaries"."player_id"="performances"."player_id" AND "salaries"."year"="performances"."year"
    JOIN "players" ON "salaries"."player_id"="players"."id"
    WHERE "salaries"."year"=2001 AND "RBI"!=0
    ORDER BY ("salary"/"RBI")
    LIMIT 10
    )
ORDER BY "pid" ) SELECT "first_name","last_name" FROM "temp";


-- I tried the query using the following logic too but Check50 wasn't able to validate it
--even though it produced correct results.

SELECT "first_name", "last_name"
FROM "players"
WHERE "id" IN(
    SELECT "players"."id"
    FROM "salaries"
    JOIN "performances" ON "salaries"."player_id"="performances"."player_id" AND "salaries"."year"="performances"."year"
    JOIN "players" ON "salaries"."player_id"="players"."id"
    WHERE "salaries"."year"=2001 AND "H"!=0
    ORDER BY ("salary"/"H")
    LIMIT 10
    )
    AND
    "id" IN (
    (SELECT "players"."id"
    FROM "salaries"
    JOIN "performances" ON "salaries"."player_id"="performances"."player_id" AND "salaries"."year"="performances"."year"
    JOIN "players" ON "salaries"."player_id"="players"."id"
    WHERE "salaries"."year"=2001 AND "RBI"!=0
    ORDER BY ("salary"/"RBI")
    LIMIT 10)
    )
ORDER BY "id";
