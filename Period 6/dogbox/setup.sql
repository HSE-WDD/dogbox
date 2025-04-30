-- open the database
.open dogbox.db
.mode box

-- delete all tables
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS plans;

DROP VIEW IF EXISTS dog_owners;
DROP VIEW IF EXISTS owner_subscriptions;

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
    age INTEGER,
    owner_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES owners (owner_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS plans (
    plan_id INTEGER PRIMARY KEY,
    plan_name TEXT NOT NULL UNIQUE,
    price REAL,
    num_toys INTEGER
);

CREATE TABLE IF NOT EXISTS subscriptions (
    sub_id INTEGER PRIMARY KEY,
    owner_id INTEGER,
    plan_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES owners (owner_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES plans (plan_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- create the views (like saved select statements)
CREATE VIEW IF NOT EXISTS dog_owners AS
    SELECT * FROM owners NATURAL JOIN dogs;

CREATE VIEW IF NOT EXISTS owner_subscriptions AS
    SELECT * FROM owners NATURAL JOIN plans NATURAL JOIN subscriptions;


-- add a few oweners
INSERT INTO owners (first_name, last_name, email) VALUES
    ("Melissa", "Fishel", "test@test.com"),
    ("Tom", "Darling", "abc@xyz.com"),
    ("Becky", "Smith", "go@stay.com");

-- add a few dogs
INSERT INTO dogs (name, breed, gender, age, owner_id) VALUES
    ("Ruby", "Golden", "F", 4, 1),
    ("Zuko", "Huskie", "M", 4, 2),
    ("Flora", "Huskie", "F", 3, 2);

-- add the data for our plans
INSERT INTO plans (plan_name, price, num_toys) VALUES
    ("Basic", 14.99, 3),
    ("Gold", 19.95, 5),
    ("Platinum", 24.95, 8),
    ("Trial", 0, 1);

-- add some subscriptions
INSERT INTO subscriptions (owner_id, plan_id) VALUES
    (1,2), (2,1), (2,3);
