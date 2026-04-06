---> create a table – note that each column has a name and a data type
-- supported types: https://docs.snowflake.com/en/sql-reference/intro-summary-data-types

- - comment = '<comment>';
CREATE TABLE TEST_TABLE (
	TEST_NUMBER NUMBER,
	TEST_VARCHAR VARCHAR,
	TEST_BOOLEAN BOOLEAN,
	TEST_DATE DATE,
	TEST_VARIANT VARIANT,
	TEST_GEOGRAPHY GEOGRAPHY
);

SELECT * FROM TEST_DATABASE.TEST_SCHEMA.TEST_TABLE;

---> insert a row into the table we just created
INSERT INTO TEST_DATABASE.TEST_SCHEMA.TEST_TABLE
  VALUES
  (28, 'ha!', True, '2024-01-01', NULL, NULL);

SELECT * FROM TEST_DATABASE.TEST_SCHEMA.TEST_TABLE;

---> drop the test table
DROP TABLE TEST_DATABASE.TEST_SCHEMA.TEST_TABLE;

---> see all tables in a particular schema
SHOW TABLES IN TEST_DATABASE.TEST_SCHEMA;

---> undrop the test table
UNDROP TABLE TEST_DATABASE.TEST_SCHEMA.TEST_TABLE;

SHOW TABLES IN TEST_DATABASE.TEST_SCHEMA;

SHOW TABLES;

---> see table storage metadata from the Snowflake database
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS;

SHOW TABLES in account;

---> here’s an example of table we created previously
CREATE TABLE tasty_bytes.raw_pos.order_detail 
(
    order_detail_id NUMBER(38,0),
    order_id NUMBER(38,0),
    menu_item_id NUMBER(38,0),
    discount_id VARCHAR(16777216),
    line_number NUMBER(38,0),
    quantity NUMBER(5,0),
    unit_price NUMBER(38,4),
    price NUMBER(38,4),
    order_item_discount_amount VARCHAR(16777216)
);
