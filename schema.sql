CREATE TABLE "ingredients"(
    "id" INTEGER,
    "name" TEXT UNIQUE NOT NULL, --As diff types of Sugar are to be stored, we assume that the unique names wwill specify which one is which.
    "price_per_unit" REAL NOT NULL CHECK("price">0),
    "unit" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donuts"(
    "id" INTEGER,
    "name" TEXT UNIQUE NOT NULL,
    "gluten_free_flag" TEXT CHECK(("gluten_free"='Y') OR ("gluten_free"='N')),
    "unit_price" REAL NOT NULL CHECK("price">0),
    PRIMARY KEY ("id")
);

CREATE TABLE "donut_ingredients"(
    "id" INTEGER,
    "donut_id" INTEGER,
    "ingredient_id" INTEGER,
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id"),
    PRIMARY KEY ("id")
);

CREATE TABLE "orders"(
    "number" INTEGER,
    "donut_id" INTEGER,
    "qty" INTEGER NOT NULL CHECK("qty">0),
    "customer_id" INTEGER,
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    PRIMARY KEY ("number")
);

CREATE TABLE "customers"(
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "customer_orders"(
    "id" INTEGER,
    "customer_id" INTEGER,
    "order_number" INTEGER,
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY ("order_number") REFERENCES "orders"("number"),
    PRIMARY KEY ("id")
);
