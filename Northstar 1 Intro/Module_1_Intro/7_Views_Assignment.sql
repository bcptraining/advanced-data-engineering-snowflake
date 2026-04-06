/* Note: The objects were intended to be created in test_database.test.Schema */

-- Q1: Create a view of the query below. What is the “make” of the food truck for the franchisee with the first name of “Sara” and the last name of “Nicholson”?
-- A1: Chevrolet
SELECT
    t.*,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name
FROM tasty_bytes.raw_pos.truck t
JOIN tasty_bytes.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id;

create or alter view tasty_bytes.harmonized.truck_franchise as  -- View TRUCK_FRANCHISE successfully created.
SELECT
    t.*,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name
FROM tasty_bytes.raw_pos.truck t
JOIN tasty_bytes.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id;
select * from tasty_bytes.harmonized.truck_franchise
where FRANCHISEE_FIRST_NAME = 'Sara'
  and franchisee_last_name = 'Nicholson'      
        ;

-- Q2: Use desc to determine the type of the TRUCK_ID column
-- A2: NUMBER(38,0)
desc view tasty_bytes.harmonized.truck_franchise;

-- Q3: Drop the truck_franchise view using the DROP VIEW command. What is the status message in Results?
-- A3: TRUCK_FRANCHISE successfully dropped.
drop view tasty_bytes.harmonized.truck_franchise;

-- Q4: Use the CREATE MATERIALIZED VIEW command to create a “truck_franchise_materialized” view, and base it on the same SQL query, reproduced below. What is the result?
-- A4: “Invalid materialized view definition. More than one table referenced in the view definition”
create materialized view truck_franchise_materialized 
as 
SELECT
    t.*,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name
FROM tasty_bytes.raw_pos.truck t
JOIN tasty_bytes.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id;

-- Q5: Use the CREATE MATERIALIZED VIEW command to create a “nissan” view in the test_database database and the test_schema schema, based on this SQL query:
-- A5: 6 rows 
create database test_database;
create schema test_database.test_schema;
create materialized view test_database.test_schema.nissan as 
SELECT
    t.*
FROM tasty_bytes.raw_pos.truck t
WHERE make = 'Nissan';

select * from test_database.test_schema.nissan;

-- Q6:Drop the “nissan” materialized view using the DROP MATERIALIZED VIEW command. What is the status in the Results
-- A6:  NISSAN successfully dropped.

 DROP MATERIALIZED VIEW test_database.test_schema.nissan;