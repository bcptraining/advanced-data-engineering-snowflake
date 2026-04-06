
-- Two kinds of monitors: Account, Warehouse

---> create a resource monitor
CREATE RESOURCE MONITOR tasty_test_rm
WITH 
    CREDIT_QUOTA = 20 -- 20 credits
    FREQUENCY = daily -- reset the monitor daily
    START_TIMESTAMP = immediately -- begin tracking immediately
    TRIGGERS 
        ON 80 PERCENT DO NOTIFY -- notify accountadmins at 80%
        ON 100 PERCENT DO SUSPEND -- suspend warehouse at 100 percent, let queries finish
        ON 110 PERCENT DO SUSPEND_IMMEDIATE; -- suspend warehouse and cancel all queries at 110 percent

---> see all resource monitors
SHOW RESOURCE MONITORS;

---> assign a resource monitor to a warehouse

/* Resource Monitors Hands-on Assignment */
-- Q1 Create a resource monitor called “tasty_test_rm” with a credit_quota of 15, a daily frequency, a start_timestamp of immediately, and a trigger of “notify” on 90 percent.

-- Then use the SHOW RESOURCE MONITORS command. What value is in the “notify_at” column for the “tasty_test_rm” monitor?
CREATE or replace RESOURCE MONITOR tasty_test_rm -- Resource monitor TASTY_TEST_RM successfully created.
WITH 
    CREDIT_QUOTA = 15 -- 15 credits
    FREQUENCY = daily -- reset the monitor daily
    START_TIMESTAMP = immediately -- begin tracking immediately
    TRIGGERS 
        ON 90 PERCENT DO NOTIFY -- notify accountadmins at 90%
        -- ON 100 PERCENT DO SUSPEND -- suspend warehouse at 100 percent, let queries finish
     ;

SHOW RESOURCE MONITORS; --SHOW RESOURCE MONITORS;

-- Q2: Create a warehouse called tasty_test_wh using the CREATE WAREHOUSE command. Then use the ALTER WAREHOUSE command to assign the tasty_test_rm resource monitor to the tasty_test_wh. 
-- After doing this, when you run SHOW RESOURCE MONITORS, what value do you see for “TASTY_TEST_RM” in the “level” column? 
CREATE WAREHOUSE tasty_test_wh -- Warehouse TASTY_TEST_WH successfully created.
  WAREHOUSE_SIZE = 'X-SMALL'
  INITIALLY_SUSPENDED = TRUE;

ALTER WAREHOUSE tasty_test_wh SET RESOURCE_MONITOR = tasty_test_rm;  -- Statement executed successfully.
SHOW RESOURCE MONITORS;
-- A2: warehouse

-- Q3:Use the ALTER RESOURCE MONITOR command to change the credit_quota for tasty_test_rm from 15 to 20. What status message do you see in the Results?
ALTER RESOURCE MONITOR tasty_test_rm  -- Statement executed successfully.
set CREDIT_QUOTA = 20; 
