SELECT "city", COUNT("name") AS "Number of Public Schools"
FROM "schools"
WHERE type='Public School'
GROUP BY "city"
HAVING "Number of Public Schools"<4
ORDER BY "Number of Public Schools" DESC, "city" ASC;
