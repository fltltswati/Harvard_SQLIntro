CREATE TABLE "encrypted_message"(
    "id" INTEGER,
    "sentence_no" INTEGER,
    "character_no" INTEGER,
    "message_length" INTEGER,
    PRIMARY KEY ("id")
);

INSERT INTO "encrypted_message"("sentence_no", "character_no", "message_length")
VALUES('14','98','4'),
('114','3','5'),
('618','72','9'),
('630','7','3'),
('932','12','5'),
('2230','50','7'),
('2346','44','10'),
('3041','14','5');

CREATE VIEW "message" AS
SELECT SUBSTR("sentence","character_no","message_length") AS "phrase" FROM "sentences"
JOIN "encrypted_message" ON "sentences"."id"="encrypted_message"."sentence_no";
