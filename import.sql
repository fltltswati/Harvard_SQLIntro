--1. Start with creating the database that will house the table
--However, we can directly use the cmd 'cat import.sql | sqlite3 meteorites.db' to create the db and run the commands in file import.sql in it.
--Hence, skipping this step.

--2. Next, create the schema of the meteorites table.
--Note that the temp table does not need schema definition as SQL can figure out the column names etc with the first row in the csv.

CREATE TABLE "meteorites"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" REAL,
    "discovery" TEXT NOT NULL CHECK ("discovery" IN('Fell','Found')),
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

--3. Import data from csv file into the temp table
.import --csv meteorites.csv meteorites_temp


--4. Data Cleaning

-- Replace empty values with Nulls. We can use NULLIF function as follows:
UPDATE "meteorites_temp"
SET "mass"=NULLIF("mass",''),
"year"=NULLIF("year",''),
"lat"=NULLIF("lat",''),
"long"=NULLIF("long",'');
--Alternatively, we can also use UPDATE statements to set empty values with nulls for each individual column like below:
--UPDATE meteorites
--SET mass='NULL'
--WHERE id=(
--    SELECT id
--    WHERE mass = ''
--);


--Round up decimals to 2 places
UPDATE "meteorites_temp"
SET "mass"=ROUND("mass",2),
"lat"=ROUND("lat",2),
"long"=ROUND("long",2);

--Delete meteorites with  nametype “Relict”.
DELETE FROM "meteorites_temp"
WHERE "nametype"='Relict';


--5. Insert data from temp table to meteorites table
--(Note that 'nametype'column is not required in the meteorites table)
--Sort by year(oldest to newest) and then by name (alphabetically)
--The id column needs to be reset. Hence, we will not specify it explicitly to let sqlite take care of the fresh ordering in the meteorites table.

INSERT INTO "meteorites"("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name","class","mass","discovery","year","lat","long" FROM "meteorites_temp"
ORDER BY "year","name";

--6. Delete data and then drop temp table
DELETE FROM "meteorites_temp";
DROP TABLE "meteorites_temp";

--Yippee!
