--We ensured that Satchel Paige had stopped playing and the value in the final_game field of the table was not blank.
SELECT "name"
FROM "teams"
WHERE "id" IN (
    SELECT "team_id"
    FROM "performances"
    WHERE "player_id"=(
        SELECT "id"
        FROM "players"
        WHERE "first_name"='Satchel' AND "last_name"='Paige'
        )
    );
