/*---------------------------------------------------------
  Pulling the Final Value in One Step
  ---------------------------------------------------------
  Now that we understand each layer of the JSON structure,
  this query jumps directly to the first ingredient using
  the full VARIANT path. This is equivalent to TEST_MENU5,
  but without creating intermediate tables.
---------------------------------------------------------*/
SELECT MENU_ITEM_HEALTH_METRICS_OBJ['menu_item_health_metrics'][0]['ingredients'][0]
FROM FROSTBYTE_TASTY_BYTES.RAW_POS.MENU;


/*---------------------------------------------------------
  Inspecting the Raw Menu Table
  ---------------------------------------------------------
  A simple select to view the full menu rows, including the
  semi‑structured VARIANT column. Useful for validating the
  JSON structure before flattening.
---------------------------------------------------------*/
SELECT *
FROM frostbyte_tasty_bytes.raw_pos.menu m;
desc table frostbyte_tasty_bytes.raw_pos.menu; -- MENU_ITEM_HEALTH_METRICS_OBJ is variant
select TYPEOF(MENU_ITEM_HEALTH_METRICS_OBJ) FROM frostbyte_tasty_bytes.raw_pos.menu;


/*---------------------------------------------------------
  Flattening the menu_item_health_metrics Array
  ---------------------------------------------------------
  LATERAL FLATTEN returns one row per element of the array.
  In this dataset, each menu item contains exactly one
  health‑metrics object, so flattening produces one row per
  menu item.
---------------------------------------------------------*/
SELECT *
FROM frostbyte_tasty_bytes.raw_pos.menu m,
LATERAL FLATTEN (input => m.menu_item_health_metrics_obj:menu_item_health_metrics);


/*---------------------------------------------------------
  Creating a View for Analytics
  ---------------------------------------------------------
  This view extracts the health‑metric flags from the
  semi‑structured JSON and exposes them as typed relational
  columns. The FLATTEN output column "value" represents the
  single object inside the array.
---------------------------------------------------------*/
CREATE OR REPLACE VIEW frostbyte_tasty_bytes.analytics.menu_v
AS
SELECT
    m.menu_item_health_metrics_obj:menu_item_id :: integer AS menu_item_id,
    value:"is_healthy_flag"::VARCHAR(1)       AS is_healthy_flag,
    value:"is_gluten_free_flag"::VARCHAR(1)   AS is_gluten_free_flag,
    value:"is_dairy_free_flag"::VARCHAR(1)    AS is_dairy_free_flag,
    value:"is_nut_free_flag"::VARCHAR(1)      AS is_nut_free_flag
FROM frostbyte_tasty_bytes.raw_pos.menu m,
LATERAL FLATTEN (input => m.menu_item_health_metrics_obj:menu_item_health_metrics);


/*---------------------------------------------------------
  Executive Metrics
  ---------------------------------------------------------
  Using the relationalized view, we can now compute
  high‑level KPIs such as:
    - total menu items
    - count of healthy items
    - count of gluten‑free items
    - count of dairy‑free items
    - count of nut‑free items

  These metrics demonstrate how semi‑structured JSON can be
  transformed into business‑ready analytics.
---------------------------------------------------------*/
SELECT
    COUNT(DISTINCT menu_item_id) AS total_menu_items,
    SUM(CASE WHEN is_healthy_flag = 'Y' THEN 1 ELSE 0 END) AS healthy_item_count,
    SUM(CASE WHEN is_gluten_free_flag = 'Y' THEN 1 ELSE 0 END) AS gluten_free_item_count,
    SUM(CASE WHEN is_dairy_free_flag = 'Y' THEN 1 ELSE 0 END) AS dairy_free_item_count,
    SUM(CASE WHEN is_nut_free_flag = 'Y' THEN 1 ELSE 0 END) AS nut_free_item_count
FROM frostbyte_tasty_bytes.analytics.menu_v;
