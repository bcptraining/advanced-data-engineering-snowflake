/* This is the code for the cloning topic */
---> create a clone of the truck table
CREATE OR REPLACE TABLE tasty_bytes.raw_pos.truck_clone 
    CLONE tasty_bytes.raw_pos.truck;

/* look at metadata for the truck and truck_clone tables from the table_storage_metrics view in the information_schema */
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLE_STORAGE_METRICS
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

/* look at metadata for the truck and truck_clone tables from the tables view in the information_schema */
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

---> insert the truck table into the clone (thus doubling the clone’s size!)
INSERT INTO tasty_bytes.raw_pos.truck_clone
SELECT * FROM tasty_bytes.raw_pos.truck;

---> now use the tables view to look at metadata for the truck and truck_clone tables again
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK';

---> clone a schema
CREATE OR REPLACE SCHEMA tasty_bytes.raw_pos_clone
CLONE tasty_bytes.raw_pos;

---> clone a database
CREATE OR REPLACE DATABASE tasty_bytes_clone
CLONE tasty_bytes;

---> clone a table based on an offset (so the table as it was at a certain interval in the past) 
CREATE OR REPLACE TABLE tasty_bytes.raw_pos.truck_clone_time_travel 
    CLONE tasty_bytes.raw_pos.truck AT(OFFSET => -60*10);

SELECT * FROM tasty_bytes.raw_pos.truck_clone_time_travel;

/* Cloning Assignment */
-- Q1 clone a database
CREATE OR REPLACE DATABASE tasty_bytes_clone
CLONE tasty_bytes; -- Database TASTY_BYTES_CLONE successfully created.
-- Q2 
CREATE OR REPLACE TABLE TASTY_BYTES.RAW_POS.TRUCK_CLONE  CLONE TASTY_BYTES.RAW_POS.TRUCK;

-- q3

SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLE_STORAGE_METRICS
WHERE (TABLE_NAME = 'TRUCK_CLONE' OR TABLE_NAME = 'TRUCK')
AND TABLE_CATALOG = 'TASTY_BYTES'
AND TABLE_SCHEMA ='RAW_POS'
AND TABLE_DROPPED IS NULL
;