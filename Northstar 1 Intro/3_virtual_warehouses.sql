---> what menu items does the Freezing Point brand sell?
SELECT 
   menu_item_name
FROM tasty_bytes_sample_data.raw_pos.menu
WHERE truck_brand_name = 'Freezing Point';

---> what is the profit on Mango Sticky Rice?
SELECT 
   menu_item_name,
   (sale_price_usd - cost_of_goods_usd) AS profit_usd
FROM tasty_bytes_sample_data.raw_pos.menu
WHERE 1=1
AND truck_brand_name = 'Freezing Point'
AND menu_item_name = 'Mango Sticky Rice';

CREATE WAREHOUSE warehouse_dash;
CREATE WAREHOUSE warehouse_gilberto;

SHOW WAREHOUSES;

USE WAREHOUSE warehouse_gilberto;

---> set warehouse size to medium
ALTER WAREHOUSE warehouse_dash SET warehouse_size=xs;

USE WAREHOUSE warehouse_dash;

SELECT
    menu_item_name,
   (sale_price_usd - cost_of_goods_usd) AS profit_usd
FROM tasty_bytes_sample_data.raw_pos.menu
ORDER BY 2 DESC;

---> set warehouse size to xsmall
ALTER WAREHOUSE warehouse_dash SET warehouse_size=medium;
ALTER WAREHOUSE warehouse_dash SUSPEND;
ALTER WAREHOUSE warehouse_gilberto SUSPEND;
ALTER WAREHOUSE warehouse_gilberto SUSPEND;

--> Suspend WAREHOUSES
ALTER WAREHOUSE warehouse_dash SUSPEND;
ALTER WAREHOUSE warehouse_gilberto SUSPEND;
---> drop warehouse
DROP WAREHOUSE warehouse_vino;

SHOW WAREHOUSES;

---> create a multi-cluster warehouse (max clusters = 3)
CREATE WAREHOUSE warehouse_vino MAX_CLUSTER_COUNT = 3 INITIALLY_SUSPENDED = TRUE;

SHOW WAREHOUSES;

---> set the auto_suspend and auto_resume parameters
ALTER WAREHOUSE warehouse_dash SET AUTO_SUSPEND = 180, AUTO_RESUME = FALSE;

SHOW WAREHOUSES;

/* Assignment: Virtual Warehouse */
-- Question 1: Create a warehouse named “warehouse_one” using the CREATE WAREHOUSE command. Then use SHOW WAREHOUSES to see metadata about the warehouse. What size is the warehouse? X-Small
create warehouse warehouse_one INITIALLY_SUSPENDED = TRUE;
SHOW WAREHOUSES;
--Question 2: Now create a new warehouse named “warehouse_two”. Then use the USE WAREHOUSE command to switch over to using warehouse_two. Then use SHOW WAREHOUSES. What does warehouse_one say for “is_current”, and what does warehouse_two say for “is_current”?
-- N Y
create warehouse warehouse_two;
use warehouse warehouse_two;
show warehouses;

-- Question 3: Drop warehouse_two using the DROP WAREHOUSE command. What does the status message say?
-- WAREHOUSE_TWO successfully dropped.
drop warehouse warehouse_two;

-- Question 4: Use the “ALTER WAREHOUSE” command and “SET warehouse_size” to change warehouse_one to a SMALL warehouse. Then use SHOW WAREHOUSES. What is the text listed in the “size” column next to warehouse_one?
ALTER WAREHOUSE warehouse_one SET WAREHOUSE_SIZE = 'Small';

-- Question 5: Use the “ALTER WAREHOUSE” command and “SET auto_suspend” to set the warehouse_one auto-suspend parameter to two minutes. Then use SHOW WAREHOUSES. What is the number in the “auto_suspend” column in the warehouse_one row?

ALTER  WAREHOUSE warehouse_one SET AUTO_SUSPEND = 120;