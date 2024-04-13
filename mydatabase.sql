--
-- File generated with SQLiteStudio v3.4.4 on Sat Feb 24 14:23:51 2024
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: food_items
CREATE TABLE IF NOT EXISTS food_items (name TEXT, restaurant TEXT, weight NUMERIC, id NUMERIC PRIMARY KEY);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Quarter Pounder', 'McDonalds', 4, 4);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Big Mac', 'McDonalds', 3.2, 0);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('McChicken', 'McDonalds', 5.04, 1);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Whopper', 'Burger King', 3.879, 2);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Impossible Whopper', 'Burger King', 3.99, 3);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Big Mac', 'McDonalds', 3.2, NULL);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('McChicken', 'McDonalds', 5.04, NULL);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Quarter Pounder', 'McDonalds', 4, NULL);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Whopper', 'Burger King', 3.879, NULL);
INSERT INTO food_items (name, restaurant, weight, id) VALUES ('Impossible Whopper', 'Burger King', 3.99, NULL);

-- Table: users
CREATE TABLE IF NOT EXISTS users (name TEXT, id NUMERIC PRIMARY KEY, email TEXT, password TEXT, type TEXT);
INSERT INTO users (name, id, email, password, type) VALUES ('Gabi', NULL, 'gh734295@sju.edu', 'Test123', 'Admin');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
