# import what you need
import snowflake.snowpark as snowpark

# import col
#from snowflake.snowpark.functions import col

# make sure to define main when you’re working in a Python worksheet
def main(session: snowpark.Session): 

    # load your table as a dataframe
    df_table = session.table("TASTY_BYTES.RAW_POS.MENU")

    # execute the operations. (Remember, Snowpark DataFrames are evaluated lazily.)
    df_table.show()

    # return your table
    return df_table

# ADDITIONAL IMPORTANT CODE SNIPPETS BELOW!

# save your dataframe as a table!
#df_table.write.save_as_table("TEST_DATABASE.TEST_SCHEMA.FREEZING_POINT_ITEMS", mode="append")

# load data using a query through session.sql instead of through session.table
    #df_table2 = session.sql("SELECT * FROM TASTY_BYTES.RAW_POS.MENU LIMIT 5")

# you can run other commands through session.sql – even things like CREATE
    #session.sql("""
    #CREATE OR REPLACE TABLE TEST_DATABASE.TEST_SCHEMA.EMPTY_TABLE (
    #col1 varchar, 
    #col2 varchar
    #)""").collect()

# filter rows
    #df_table = df_table.filter(col("TRUCK_BRAND_NAME") == "Freezing Point")

# select columns
    #df_table = df_table.select(col("MENU_ITEM_NAME"), col("ITEM_CATEGORY"))

# filter and select at the same time (chaining)
    #df_table = df_table.filter(
    #    col("TRUCK_BRAND_NAME") == "Freezing Point"
    #).select(
    #    col("MENU_ITEM_NAME"), 
    #    col("ITEM_CATEGORY")
    #)
