-- Run these lines to create the database and stage
USE WAREHOUSE compute_wh;
CREATE DATABASE test_ingestion;
CREATE OR REPLACE FILE FORMAT test_ingestion.public.csv_ff
type = 'csv';
/* Then create a stage called test_stage
Then use a CREATE STAGE command to create a stage named “test_stage” in the “public” schema in the “test_ingestion” database.
The url to use is: 's3://sfquickstarts/tasty-bytes-builder-education/raw_pos/truck'
And the file format to use is csv_ff.
*/

-- Q1: What status do you see after creating this stage
-- A1: Stage area TEST_STAGE successfully created.


create stage test_stage 
url = 's3://sfquickstarts/tasty-bytes-builder-education/raw_pos/truck'
file_format = test_ingestion.public.csv_ff;

-- Q1: What status do you see after creating this stage?
-- A1: Stage area TEST_STAGE successfully created.

-- Q2: Run a list command (“ls”) to view the staged files. What number do you see in the size column for “truck.csv.gz”?
-- a2: 5583
ls @TEST_INGESTION.PUBLIC.test_stage; 

-- Run the following code: 
-- truck table build
CREATE OR REPLACE TABLE test_ingestion.public.truck
(
    truck_id NUMBER(38,0),
    menu_type_id NUMBER(38,0),
    primary_city VARCHAR(16777216),
    region VARCHAR(16777216),
    iso_region VARCHAR(16777216),
    country VARCHAR(16777216),
    iso_country_code VARCHAR(16777216),
    franchise_flag NUMBER(38,0),
    year NUMBER(38,0),
    make VARCHAR(16777216),
    model VARCHAR(16777216),
    ev_flag NUMBER(38,0),
    franchise_id NUMBER(38,0),
    truck_opening_date DATE
);
-- Then use the COPY INTO command to copy into the test_ingestion.public.truck table from the test_ingestion.public.test_stage stage.

-- Q3: What number do you see in the “rows_parsed” column?
-- A3: 450
COPY INTO test_ingestion.public.truck
FROM @TEST_INGESTION.PUBLIC.test_stage;

-- Q4: which of the following creates an external stage?
CREATE STAGE tasty_bytes.public.s3load
url = 's3://sfquickstarts/tasty-bytes-builder-education/'
file_format = tasty_bytes.public.csv_ff;