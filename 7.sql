SELECT "first_name","last_name"
FROM "players"
JOIN "salaries" ON "players"."id"="salaries"."player_id"
ORDER by "salary" DESC
LIMIT 1;
