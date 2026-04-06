-- Q4:
If you want to get the result “Sweet Mango” from the following SQL query:
SELECT XYZ
FROM tasty_bytes.raw_pos.menu
WHERE MENU_ITEM_NAME = 'Mango Sticky Rice';

What should “XYZ” be?
-- A4:
select menu_item_health_metrics_obj['menu_item_health_metrics'][0]['ingredients'][0]
FROM tasty_bytes.raw_pos.menu
WHERE MENU_ITEM_NAME = 'Mango Sticky Rice';
