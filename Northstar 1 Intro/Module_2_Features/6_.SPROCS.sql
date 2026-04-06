/* Code Block for videos */
---> list all procedures
SHOW PROCEDURES;

SELECT * FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
LIMIT 100;

---> see the latest and earliest order timestamps so we can determine what we want to delete
SELECT MAX(ORDER_TS), MIN(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER;

---> save the max timestamp
SET max_ts = (SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER);

SELECT $max_ts;

SELECT DATEADD('DAY',-180,$max_ts);

---> determine the necessary cutoff to go back 180 days
SET cutoff_ts = (SELECT DATEADD('DAY',-180,$max_ts));
select $cutoff_ts;
---> note how you can use the cutoff_ts variable in the WHERE clause
SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
WHERE ORDER_TS < $cutoff_ts;

USE DATABASE TASTY_BYTES;

---> create your procedure
CREATE OR REPLACE PROCEDURE delete_old()
RETURNS BOOLEAN
LANGUAGE SQL
AS
$$
DECLARE
  max_ts TIMESTAMP;
  cutoff_ts TIMESTAMP;
BEGIN
  max_ts := (SELECT MAX(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER);
  cutoff_ts := (SELECT DATEADD('DAY',-180,:max_ts));
  DELETE FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER
  WHERE ORDER_TS < :cutoff_ts;
END;
$$
;

SHOW PROCEDURES LIKE '%delete%';

---> see information about your procedure
DESCRIBE PROCEDURE delete_old();

---> run your procedure
CALL DELETE_OLD();

---> confirm that that made a difference
SELECT MIN(ORDER_TS) FROM TASTY_BYTES_CLONE.RAW_POS.ORDER_HEADER;

---> it did! We deleted everything from before the cutoff timestamp
SELECT $cutoff_ts;


/* Assignment */
use database tasty_bytes_clone;
create or replace procedure increase_prices()
RETURNS BOOLEAN
LANGUAGE SQL
AS
$$
begin
    UPDATE tasty_bytes_clone.raw_pos.menu
    SET SALE_PRICE_USD = menu.SALE_PRICE_USD + 1;
end;
$$
;
call increase_prices();
desc procedure increase_prices();

-- Q4:  Create a stored procedure called “decrease_mango_sticky_rice_price” that decreases the price by 1 dollar for the item with the “MENU_ITEM_NAME” of “Mango Sticky Rice”. 

-- If you run the SHOW PROCEDURES command, what value do you see in the “arguments” column in the row associated with “decrease_mango_sticky_rice_price”?
-- DECREASE_MANGO_STICKY_RICE_PRICE() RETURN BOOLEAN

create procedure decrease_mango_sticky_rice_price(menu_item_name varchar)
returns boolean
LANGUAGE SQL
AS
$$
begin
    update tasty_bytes_clone.raw_pos.menu
    set SALE_PRICE_USD = SALE_PRICE_USD - 1
    where MENU_ITEM_NAME = :menu_item_name;
end;
$$
;

create or alter procedure decrease_mango_sticky_rice_price()
returns boolean
LANGUAGE SQL
AS
$$
begin
    update tasty_bytes_clone.raw_pos.menu
    set SALE_PRICE_USD = SALE_PRICE_USD - 1
    where MENU_ITEM_NAME = 'Mango Sticky Rice';
end;
$$
;
call decrease_mango_sticky_rice_price();
select * from tasty_bytes_clone.raw_pos.menu 
where menu_item_name = 'Mango Sticky Rice';

show procedures like '%decrease%';