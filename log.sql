
-- *** The Lost Letter ***

--The scans table can tell us about the last 'address_id' the package was scanned at. However, we do not have the 'package_id'.
--Now, we can get the 'package_id' from the packages table. But as the sender wasn't sure of the recipients address,so we will query on 'from_address_id'.
--Writing a nested query to find all the scans made for the particular package.
SELECT * FROM "scans" WHERE "package_id"=(
   ...> SELECT "id" FROM "packages" WHERE "from_address_id"=(
   ...>     SELECT "id" FROM "addresses" WHERE "address"='900 Somerville Avenue'
   ...> ));

--Once we have the scans made for the letter and we have identified the last dropped off location, we will query the addresses table to find out the
--address corresponding to the dropped off address id.
   SELECT * FROM "addresses" WHERE "id"='854';

--Alternatively, we can combine the above two queries in one query to say
   SELECT * FROM "addresses" WHERE "id"=(
      SELECT "address_id" FROM "scans" WHERE "action"='Drop' AND "package_id"=(
         SELECT "id" FROM "packages" WHERE "from_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='900 Somerville Avenue'
      )));


-- *** The Devious Delivery ***
--As the package had no from_address, let us look at the packages table to see if there is such entry:
SELECT * FROM "packages" WHERE "from_address_id" IS NULL;

--It looks like the same package the fellow was talking about (with a quack) as it is a duck debugger.
--Let us see what all locations the package was scanned at:
SELECT * FROM "scans" WHERE "package_id"='5098';

--As we have identified the last location the package was scanned at, let us find out more about the address:
SELECT * FROM "addresses" WHERE "id"=348;

--Alternatively, we can use nested queries to find out the answer in one go:
SELECT * FROM "addresses" WHERE "id"=(
   SELECT "address_id" FROM "scans" WHERE "action"='Drop' AND "package_id"=(
      SELECT "id" FROM "packages" WHERE "from_address_id" IS NULL
   )
);

-- *** The Forgotten Gift ***
-- Let us find out the package_id and the contents of the package sent from the sender's intimated address.
SELECT * FROM "packages" WHERE "from_address_id"=(
   SELECT "id" FROM "addresses" WHERE "address" LIKE '%109 Tileston Street%');

--We also checked the addresses table to ensure that the package was headed indeed to the location the sender intended to:
SELECT * FROM "addresses" WHERE "id"='4983';

--Since, we now have the package id, let us see where all has it been:
SELECT * FROM "scans" WHERE "package_id"='9523';

-- As the package has not reached the correct location yet, it must be with a driver.Let us find out the name of the driver who last picked up the package:
SELECT * from "drivers" WHERE "id"='17';

--Alternatively, we can use the following nested query:
SELECT "name" from "drivers" WHERE "id"=(
   SELECT "driver_id" FROM "scans" WHERE "action"='Pick' AND "package_id"=(
      SELECT "id" FROM "packages" WHERE "from_address_id"=(
         SELECT "id" FROM "addresses" WHERE "address" LIKE '%109 Tileston Street%'
         )
      )ORDER BY "timestamp" DESC LIMIT 1
   );
