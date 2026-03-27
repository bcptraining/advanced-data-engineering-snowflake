USE ROLE accountadmin;
USE DATABASE staging_tasty_bytes;
USE SCHEMA raw_pos;

-- Configure logging level:
ALTER ACCOUNT SET LOG_LEVEL = 'INFO'; -- INFORMATION-LEVEL AND HIGHERE
-- Create the stored procedure, define its logic with Snowpark for Python, write sales to raw_pos.daily_sales_hamburg_t
CREATE OR REPLACE PROCEDURE staging_tasty_bytes.raw_pos.process_order_headers_stream()
  RETURNS STRING
  LANGUAGE PYTHON
  RUNTIME_VERSION = '3.10'
  HANDLER ='process_order_headers_stream'
  PACKAGES = ('snowflake-snowpark-python')
AS
$$
import snowflake.snowpark.functions as F
from snowflake.snowpark import Session
# Added this to specify we want to use the logging library
import logging  

def process_order_headers_stream(session: Session) -> float:
    # Added this to specify a named logger
    logger = logging.getLogger('order_headers_stream_sproc')
    
    # Log procedure start:
    logger.info("starting process_order_headers_stream procedure")
    
    try:
        # Query the stream
        logger.info("Querying order_header_stream for new records")
        recent_orders = session.table("order_header_stream").filter(F.col("METADATA$ACTION") == "INSERT")
        
        # Look up location of the orders in the stream using the LOCATIONS table
        logger.info("Filtering orders for Hamburg, Germany")
        locations = session.table("location")
        hamburg_orders = recent_orders.join(
            locations,
            recent_orders["LOCATION_ID"] == locations["LOCATION_ID"]
        ).filter(
            (locations["CITY"] == "Hamburg") &
            (locations["COUNTRY"] == "Germany")
        )
        
        # Log the count of filtered records:
        hamburg_count = hamburg_orders.count()
        logger.info(f"Found {hamburg_count} orders from Hmburg")
        # Added this as part of exercise
        logger.info(f'found {hamburg_count} orders from Hamburg')
        # Calculate the sum of sales in Hamburg
        logger.info("Calculating daily sales aggregates")
        daily_sales = hamburg_orders.select(
            F.date_trunc('DAY', F.col("ORDER_TS")).cast("DATE").alias("DATE"),
            F.col("ORDER_TOTAL")
        ).group_by("DATE").agg(
            F.coalesce(F.sum("ORDER_TOTAL"), F.lit(0)).alias("total_sales")
        )
        
        # Write the results to the DAILY_SALES_HAMBURG_T table
        logger.info("Writing results to raw_pos.daily_sales_hamburg_t")
        daily_sales.write.mode("append").save_as_table("raw_pos.daily_sales_hamburg_t")
        
        # Log successful completion:
        logger.info("procedure completed successfully")
        return "Daily sales for Hamburg, Germany have been successfully written to raw_pos.daily_sales_hamburg"
    
    except Exception as e:
        # Log any errors that occur
        logger.error(f"Error processing orders: {str(e)}")
        raise
$$;

CALL staging_tasty_bytes.raw_pos.process_order_headers_stream();

USE DATABASE staging_tasty_bytes;
USE SCHEMA TELEMETRY;
SELECT * FROM pipeline_events where start_timestamp >= '2026-03-23 00:00:00.000' ;
select count(*) FROM pipeline_events
where start_timestamp > '2026-03-23 22:09:05.200' ;

-- Insert dummy data into ORDER_HEADER table
INSERT INTO STAGING_TASTY_BYTES.RAW_POS.ORDER_HEADER (
    ORDER_ID,
    TRUCK_ID,
    LOCATION_ID,
    CUSTOMER_ID,
    DISCOUNT_ID,
    SHIFT_ID,
    SHIFT_START_TIME,
    SHIFT_END_TIME,
    ORDER_CHANNEL,
    ORDER_TS,
    SERVED_TS,
    ORDER_CURRENCY,
    ORDER_AMOUNT,
    ORDER_TAX_AMOUNT,
    ORDER_DISCOUNT_AMOUNT,
    ORDER_TOTAL
) VALUES 
-- Hamburg Order 1
(1001, 42, 4494, 5001, NULL, 301, '08:00:00', '16:00:00', 'POS', 
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'EUR', 25.50, '3.83', '0.00', 29.33),

-- Hamburg Order 2
(1002, 42, 4495, 5002, 'SUMMER10', 301, '08:00:00', '16:00:00', 'MOBILE', 
 DATEADD(hour, -1, CURRENT_TIMESTAMP()), DATEADD(minute, -45, CURRENT_TIMESTAMP()), 'EUR', 42.75, '6.41', '4.28', 44.88),

-- Hamburg Order 3
(1003, 43, 4496, 5003, NULL, 302, '10:00:00', '18:00:00', 'POS', 
 DATEADD(hour, -3, CURRENT_TIMESTAMP()), DATEADD(hour, -3, CURRENT_TIMESTAMP()), 'EUR', 18.20, '2.73', '0.00', 20.93);
 
CALL staging_tasty_bytes.raw_pos.process_order_headers_stream();

-- SELECT * FROM pipeline_events;

SELECT * FROM pipeline_events WHERE record_type = 'LOG' AND OBSERVED_TIMESTAMP > '2026-03-23 22:09:30.108';


select * from STAGING_TASTY_BYTES.RAW_POS.ORDER_HEADER_STREAM;
select * from STAGING_TASTY_BYTES.RAW_POS.LOCATION where CITY = 'Hamburg'; -- and LOCATION_ID = 137;
select * from STAGING_TASTY_BYTES.RAW_POS.LOCATION where LOCATION_ID = 4494;