CREATE TABLE "personen" (
  "id" integer PRIMARY KEY,
  "vorname" varchar NOT NULL,
  "nachname" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "telefon" varchar,
  "created_at" timestamp
);

CREATE TABLE "kunden" (
  "person_id" integer PRIMARY KEY,
  "mitgliedsnummer" varchar UNIQUE,
  "join_date" date NOT NULL
);

CREATE TABLE "mitarbeiter" (
  "person_id" integer PRIMARY KEY,
  "position" varchar,
  "hire_date" date
);

CREATE TABLE "buecher" (
  "id" integer PRIMARY KEY,
  "titel" varchar NOT NULL,
  "autor" varchar NOT NULL,
  "isbn" varchar UNIQUE,
  "created_at" timestamp
);

CREATE TABLE "ausleihe" (
  "id" integer PRIMARY KEY,
  "kunde_id" integer NOT NULL,
  "mitarbeiter_id" integer NOT NULL,
  "ausleih_datum" date NOT NULL,
  "faellig_datum" date NOT NULL,
  "status" varchar,
  "created_at" timestamp
);

CREATE TABLE "loan_items" (
  "id" integer PRIMARY KEY,
  "ausleihe_id" integer NOT NULL,
  "buch_id" integer NOT NULL,
  "return_date" date
);

CREATE TABLE "strafen" (
  "id" integer PRIMARY KEY,
  "ausleihe_id" integer NOT NULL,
  "amount" decimal(10,2) NOT NULL,
  "grund" varchar,
  "paid" boolean NOT NULL DEFAULT false,
  "created_at" timestamp
);

ALTER TABLE "kunden" ADD FOREIGN KEY ("person_id") REFERENCES "personen" ("id");

ALTER TABLE "mitarbeiter" ADD FOREIGN KEY ("person_id") REFERENCES "personen" ("id");

ALTER TABLE "ausleihe" ADD FOREIGN KEY ("kunde_id") REFERENCES "kunden" ("person_id");

ALTER TABLE "ausleihe" ADD FOREIGN KEY ("mitarbeiter_id") REFERENCES "mitarbeiter" ("person_id");

ALTER TABLE "loan_items" ADD FOREIGN KEY ("ausleihe_id") REFERENCES "ausleihe" ("id");

ALTER TABLE "loan_items" ADD FOREIGN KEY ("buch_id") REFERENCES "buecher" ("id");

ALTER TABLE "strafen" ADD FOREIGN KEY ("ausleihe_id") REFERENCES "ausleihe" ("id");
