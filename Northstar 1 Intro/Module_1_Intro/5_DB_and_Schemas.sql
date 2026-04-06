SELECT * FROM RAW_POS.MENU;

---> see table metadata
SELECT * FROM TASTY_BYTES.INFORMATION_SCHEMA.TABLES;

---> create a test database
CREATE DATABASE test_database2;
drop DATABASE test_database2;

SHOW DATABASES;

---> drop the database
DROP DATABASE test_database;

---> undrop the database
UNDROP DATABASE test_database2;

SHOW DATABASES;

---> use a particular database
USE DATABASE test_database;

---> create a schema
CREATE SCHEMA test_schema;
CREATE SCHEMA testschema;
SHOW SCHEMAS;

---> see metadata about your database
DESCRIBE DATABASE TEST_DATABASE;

---> drop a schema
DROP SCHEMA test_schema;

SHOW SCHEMAS;

---> undrop a schema
UNDROP SCHEMA test_schema;

SHOW SCHEMAS;
