SELECT "first_name", "last_name", "salary","salaries"."year", "HR"
FROM "players"
JOIN "salaries" ON "players"."id"="salaries"."player_id"
JOIN "performances" ON "players"."id"="performances"."player_id" AND "salaries"."year"="performances"."year"
ORDER BY "players"."id", "performances"."year" DESC, "HR" DESC, "salary" DESC;
