SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b', 'What kind of literature was Marianne Moore known for?');

-- Q1: Use the Snowflake Cortex Complete function and the “mistral-7b” model to answer the question: “What kind of literature was Marianne Moore known for?”
-- Note: The provided solution did not add on the SUMMARIZE... just the COMPLETE
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(SNOWFLAKE.CORTEX.COMPLETE( -- 
    'mistral-7b', 'What kind of literature was Marianne Moore known for?'));
-- A1:Marianne Moore was a modernist poet known for her intellectual, witty, and linguistically innovative poetry. Her work explored various subjects and featured precise language, alliteration, and unexpected juxtapositions. She referenced other literature and art and was renowned for her erudition and cultural references. Moore's poetry was also characterized by its complex formal structure. 

-- Q2: Use the Snowflake Cortex Complete function with the “mistral-7b” model. Ask Snowflake Cortex Complete to “Describe this food: ” and then apply that to the menu_item_name for five rows of the table TASTY_BYTES.RAW_POS.MENU.
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b',
        CONCAT('Describe this food: ', menu_item_name)
) FROM FROSTBYTE_TASTY_BYTES.RAW_POS.MENU LIMIT 5;
-- A2: SNOWFLAKE.CORTEX.COMPLETE('MISTRAL-7B', CONCAT('DESCRIBE THIS FOOD: ', MENU_ITEM_NAME))
