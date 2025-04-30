.open dogbox.db
.mode box

-- drop any tables
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS plans;
DROP VIEW IF EXISTS dog_owners;
DROP VIEW IF EXISTS owner_subcriptions;

-- now create the tables
CREATE TABLE IF NOT EXISTS owners (
    owner_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dogs (
    dog_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    breed TEXT,
    gender TEXT,
    age TEXT,
    owner_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES owners (owner_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS plans (
    plan_id INTEGER PRIMARY KEY,
    plan_name TEXT NOT NULL UNIQUE,
    price REAL,
    num_toys INTEGER
);

-- this table will set up a many to many realationship between the
-- owners and the plans
CREATE TABLE IF NOT EXISTS subscriptions (
    sub_id INTEGER PRIMARY KEY,
    owner_id INTEGER,
    plan_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES owners (owner_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES plans (plan_id)
        ON UPDATE CASCADE ON DELETE CASCADE

);



-- create some views (save some select statements)
CREATE VIEW IF NOT EXISTS dog_owners AS
    SELECT * FROM owners NATURAL JOIN dogs;

CREATE VIEW IF NOT EXISTS owner_subscriptions AS
    SELECT * FROM owners
        NATURAL JOIN plans
        NATURAL JOIN subscriptions;



-- add two oners
INSERT INTO owners (first_name, last_name, email) VALUES
    ("Melissa", "Fishel", "test@example.com"),
    ("Tom", "Darling", "abc@xyz.com");

-- add a few dogs to start with
INSERT INTO dogs (name, breed, gender, age, owner_id) VALUES
    ("Ruby", "Golden", "F", 4, 1),
    ("Zuko", "Huskie", "M", 4, 2),
    ("Flora", "Huskie", "F", 3, 2);


-- add the plans we offer
INSERT INTO plans (plan_name, price, num_toys) VALUES
    ("Basic", 14.99, 3),
    ("Gold", 19.95, 5),
    ("Platinum", 24.95, 8),
    ("Trial", 0, 1);

-- add a few subscriptions
INSERT INTO subscriptions (owner_id, plan_id) VALUES
    (1, 2), (2,1), (2,3);
