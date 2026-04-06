/* Run this code before hands-on */
CREATE or replace TABLE tasty_bytes.raw_pos.truck_dev
    CLONE tasty_bytes.raw_pos.truck;
SELECT * FROM tasty_bytes.raw_pos.truck_dev;
SET saved_query_id = LAST_QUERY_ID();
SET saved_timestamp = CURRENT_TIMESTAMP;
UPDATE tasty_bytes.raw_pos.truck_dev t
    SET t.year = (YEAR(CURRENT_DATE()) -1000);

/* Assignment */
SHOW VARIABLES;

-- Q2:When you run “SELECT * FROM tasty_bytes.raw_pos.truck_dev” with AT and specify the timestamp to be the $saved_timestamp variable we set earlier, what value is in the “year” column for the truck with a “truck_id” of 1?
SELECT * FROM tasty_bytes.raw_pos.truck_dev
-- AT(TIMESTAMP => $saved_timestamp)
BEFORE(STATEMENT => $saved_query_id);
;

-- AT(OFFSET => -2121);
