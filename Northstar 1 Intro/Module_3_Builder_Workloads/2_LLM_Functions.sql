/* Code block for the videos  */
--> use the mistral-7b model and Snowflake Cortex Complete to ask a question
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b', 'What are three reasons that Snowflake is positioned to become the go-to data platform?');

---> now send the result to the Snowflake Cortex Summarize function
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b', 'What are three reasons that Snowflake is positioned to become the go-to data platform?'));

---> run Snowflake Cortex Complete on multiple rows at once
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b',
        CONCAT('Tell me why this food is tasty: ', menu_item_name)
) FROM FROSTBYTE_TASTY_BYTES.RAW_POS.MENU LIMIT 5;

---> check out what the table of prompts we’re feeding to Complete (roughly) looks like
SELECT CONCAT('Tell me why this food is tasty: ', menu_item_name)
FROM FROSTBYTE_TASTY_BYTES.RAW_POS.MENU LIMIT 5;

---> give Snowflake Cortex Complete a prompt with history
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b', -- the model you want to use
    [
        {'role': 'system', 
        'content': 'Analyze this Snowflake review and determine the overall sentiment. Answer with just \"Positive\", \"Negative\", or \"Neutral\"' },
        {'role': 'user',
        'content': 'I love Snowflake because it is so simple to use.'}
    ], -- the array with the prompt history, and your new prompt
    {} -- An empty object of options (we're not specify additional options here)
) AS response;

---> give Snowflake Cortex Complete a prompt with a lengthier history
SELECT SNOWFLAKE.CORTEX.COMPLETE(
    'mistral-7b',
    [
        {'role': 'system', 
        'content': 'Analyze this Snowflake review and determine the overall sentiment. Answer with just \"Positive\", \"Negative\", or \"Neutral\"' },
        {'role': 'user',
        'content': 'I love Snowflake because it is so simple to use.'},
        {'role': 'assistant',
        'content': 'Positive. The review expresses a positive sentiment towards Snowflake, specifically mentioning that it is \"so simple to use.\'"'},
        {'role': 'user',
        'content': 'Based on other information you know about Snowflake, explain why the reviewer might feel they way they do.'}
    ], -- the array with the prompt history, and your new prompt
    {} -- An empty object of options (we're not specify additional options here)
) AS response;

-- Use cortext to generate a list of supported models 

WITH raw AS ( -- Text block of models with descriptive info, but not that readable
    SELECT SNOWFLAKE.CORTEX.COMPLETE(
        'mistral-7b',
        [
            {'role': 'user', 'content': 'List the models available for use with CORTEX functions.'}
        ],
        {}
    ) AS response
)
SELECT SNOWFLAKE.CORTEX.SUMMARIZE(  -- Present the answer in a more readable form
    CONCAT(
        'Rewrite the following into a clean, presentable table with columns: Model Name, Description. ',
        'Ensure the table is well‑formatted and readable.\n\n',
        response:choices[0]:messages::VARCHAR
    )
) AS formatted_output
FROM raw;


