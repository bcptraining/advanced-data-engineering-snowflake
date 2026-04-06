-- Run this code before doing the assignment
CREATE DATABASE test_database;
CREATE SCHEMA test_database.test_schema;

USE DATABASE test_database;
USE SCHEMA test_schema;

CREATE or alter TABLE TEST_TABLE (
	TEST_NUMBER NUMBER,
	TEST_VARCHAR VARCHAR,
	TEST_BOOLEAN BOOLEAN,
	TEST_DATE DATE,
	TEST_VARIANT VARIANT,
	TEST_GEOGRAPHY GEOGRAPHY
);
INSERT INTO TEST_DATABASE.TEST_SCHEMA.TEST_TABLE
  VALUES
  (28, 'ha!', True, '2024-01-01', NULL, NULL);

-- Q1: Run the SHOW TABLES command. What value is in the “bytes” column for the test_table row?
-- A1: 2048
show tables;

-- Q2: After creating table test_table2 with one NUMBER column called TEST_NUMBER. Then insert the value 42 into it using the INSERT INTO command.  How many bytess is the table now??
-- A2: 1024
create table test_table2 (TEST_NUMBER NUMBER );
INSERT INTO TEST_DATABASE.TEST_SCHEMA.TEST_TABLE2
    values (42);

show tables;

--Q3: Drop the test_table table with the DROP TABLE command. Then undrop it with the UNDROP TABLE command. What status message in the Results do you see?
-- A3: Table TEST_TABLE2 successfully restored.
drop table test_table2;
undrop table test_table2;

-- Q4:Which of the following is synonymous with the NUMBER data type?
-- BIGINT