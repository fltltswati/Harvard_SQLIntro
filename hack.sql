--Change admin password to register a true (yet false) entry in the user_logs table

UPDATE "users"
SET "password" = (
    SELECT "password"
    FROM "users"
    WHERE "username"='emily33'
)
WHERE "username"='admin';

--Change the admin password to "oops!" as required.

UPDATE "users"
SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username"='admin';


--Delete the log of admin pwd change to "oops!"

DELETE FROM "user_logs"
WHERE "old_username"='admin' AND "new_password"='982c0381c279d139fd221fce974916e7';
