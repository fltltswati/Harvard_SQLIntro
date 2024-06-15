SELECT "first_name","last_name",(SUBSTR("debut",0,5)-"birth_year") AS "approx_age_at_debut","birth_city" FROM "players" WHERE "birth_country"='USA' AND ("debut"*"birth_year"
)  IS NOT NULL ORDER BY "approx_age_at_debut" LIMIT 10; 
