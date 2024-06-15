SELECT "friend_id"
FROM "friends"
WHERE "user_id"=(
    SELECT "id"
    FROM "users"
    WHERE "username"='lovelytrust487'
)

INTERSECT

SELECT "friend_id"
FROM "friends"
WHERE "user_id"=(
    SELECT "id"
    FROM "users"
    WHERE "username"='exceptionalinspiration482'
);

--Query Plan gives the following details:
--It is a compound query utilising covering index created automatically on the primary key columns of the friends table-sqlite_autoindex_friends_1.
--Similary it uses the other autoindex for the users table.
