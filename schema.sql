CREATE TABLE "users"(
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "user_name" TEXT NOT NULL UNIQUE,
    "password" BLOB NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "schools"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK (type IN ('Elementary School','Middle School','High School','Lower School','Upper School','College','University','Others')),
    "location" TEXT NOT NULL,
    "founding_year" INTEGER NOT NULL CHECK (length("founding_year")=4),
    PRIMARY KEY ("id")
);

CREATE TABLE "companies"(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    -- We can use a check for the industry field if the only industries are “Education”, “Technology, “Finance".
    --But as there are other industries, not placing that constraint here.
    "location" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

--The connection id will be used to join two users. Hence, 2 users connected to each other will have the same conn_id.
--For example, both user1 and user2 can be part of the same connection which would indicate that they are connected.
CREATE TABLE conn_users_users(
    "conn_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "related_user_id" INTEGER NOT NULL CHECK ("related_user_id" > "user_id"),
    --As the relationship is bidirectional, if user2 is friend of user1, it implies that user1 is also friend of user2.
    --So, the check avoids duplication of data.
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("related_user_id") REFERENCES "users"("id"),
    PRIMARY KEY ("conn_id")

);

CREATE TABLE conn_users_schools(
    "conn_id" INTEGER,
    "user_id" INTEGER NOT NULL, --A school will always be associated with at least 1 user
    "school_id" INTEGER, --A user might not be associated with any school
    "school_start" NUMERIC CHECK("school_start" <= CURRENT_TIMESTAMP), --Not applying the NOT NULL constraint. The user can provide data if he wishes to.
    "school_end" NUMERIC CHECK (("school_end">"school_start") AND ("school_start" IS NOT NULL)), --User should not be allowed to enter an ed date without providing a start date
    "school_degree" TEXT,
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("school_id") REFERENCES "schools"("id"),
    PRIMARY KEY ("conn_id")
);


CREATE TABLE conn_users_companies(
    "conn_id" INTEGER,
    "user_id" INTEGER NOT NULL, --A company will be connected to at least 1 user
    "company_id" INTEGER, --A user might not be connected to any company at all.
    "company_start" NUMERIC CHECK("company_start" <= CURRENT_TIMESTAMP),
    "company_end" NUMERIC CHECK (("company_end">"company_start") AND ("company_start" IS NOT NULL)),
    "user_position" TEXT,
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id"),
    PRIMARY KEY ("conn_id")
);



