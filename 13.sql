--Is there a relation between geraduation rates and unsatisfactory staff evals?
SELECT "districts"."name","graduated","unsatisfactory"
FROM "districts"
JOIN "schools" ON "districts"."id"="schools"."district_id"
JOIN "graduation_rates" ON "schools"."id"="graduation_rates"."school_id"
JOIN "staff_evaluations" ON "districts"."id"="staff_evaluations"."district_id"
ORDER BY "unsatisfactory" DESC
LIMIT 10;
