SELECT "city", COUNT("city") AS "Number of Public Schools"
FROM "schools"
WHERE "type"='Public School'
GROUP BY "city"
ORDER BY "Number of Public Schools" DESC, "city" ASC
LIMIT 10;
