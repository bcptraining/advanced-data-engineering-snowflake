/* Code block for videos */
---> create the storage integration
CREATE OR REPLACE STORAGE INTEGRATION S3_role_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = "arn:aws:iam::849350360261:role/snowflake_role_snowpipe"
  STORAGE_ALLOWED_LOCATIONS = ("s3://intro-to-snowflake-snowpipe/");
---> describe the storage integration to see the info you need to copy over to AWS
DESCRIBE INTEGRATION S3_role_integration;
---> create the database
CREATE OR REPLACE DATABASE S3_db;
---> create the table (automatically in the public schema, because we didn’t specify)
CREATE OR REPLACE TABLE S3_table(food STRING, taste INT);
USE SCHEMA S3_db.public;
---> create stage with the link to the S3 bucket and info on the associated storage integration
CREATE OR REPLACE STAGE S3_stage
  url = ('s3://intro-to-snowflake-snowpipe/')
  storage_integration = S3_role_integration;
SHOW STAGES;
---> see the files in the stage
LIST @S3_stage;
---> select the first two columns from the stage
SELECT $1, $2 FROM @S3_stage;
USE WAREHOUSE COMPUTE_WH;
---> create the snowpipe, copying from S3_stage into S3_table
CREATE PIPE S3_db.public.S3_pipe AUTO_INGEST=TRUE as
  COPY INTO S3_db.public.S3_table
  FROM @S3_db.public.S3_stage;
SELECT * FROM S3_db.public.S3_table;
---> see a list of all the pipes
SHOW PIPES;
DESCRIBE PIPE S3_db.public.S3_pipe;
---> pause the pipe
ALTER PIPE S3_db.public.S3_pipe SET PIPE_EXECUTION_PAUSED = TRUE;
---> drop the pipe
DROP PIPE S3_pipe;
SHOW PIPES;

/* Snowpipe Part 1 */



/* Snowpipe Part 2 */


/* Snowpipe Assignment*/