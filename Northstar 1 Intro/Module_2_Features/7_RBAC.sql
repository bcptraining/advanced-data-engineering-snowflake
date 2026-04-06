/* Code block for video */
USE ROLE accountadmin;

---> create a role
CREATE ROLE tasty_de;
CREATE USER tastyadmin
  PASSWORD = 'TASTYBYTES'
  MUST_CHANGE_PASSWORD = FALSE
  DEFAULT_NAMESPACE = TASTY_BYTES_CLONE;
---> see what privileges this new role has
SHOW GRANTS TO ROLE tasty_de;

---> see what privileges an auto-generated role has
SHOW GRANTS TO ROLE accountadmin;
-- SHOW GRANTS TO ROLE TASTY_DE;
---> grant a role to a specific user

GRANT ROLE tasty_de TO USER tastyadmin;

---> use a role
USE ROLE tasty_de;

---> try creating a warehouse with this new role
CREATE WAREHOUSE tasty_de_test;

USE ROLE accountadmin;

---> grant the create warehouse privilege to the tasty_de role
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE tasty_de;

---> show all of the privileges the tasty_de role has
SHOW GRANTS TO ROLE tasty_de;

USE ROLE tasty_de;

---> test to see whether tasty_de can create a warehouse
CREATE WAREHOUSE tasty_de_test;

---> learn more about the privileges each of the following auto-generated roles has

SHOW GRANTS TO ROLE securityadmin;

SHOW GRANTS TO ROLE useradmin;

SHOW GRANTS TO ROLE sysadmin;

SHOW GRANTS TO ROLE public;

/*  Assignment */
-- Q1: Create a role called “tasty_role” using the CREATE ROLE command. When you do this, what does the status message in Results say?
create role tasty_role;

-- Q2: Use the SHOW GRANTS command to show the grants to the role “tasty_role” you just created. When you do this, what is the first thing you see in Results (under the column names)?
show grants to role tasty_role; -- Query produced no results

--  Q3: Use the GRANT command to grant the privilege to CREATE DATABASE ON ACCOUNT to the role “tasty_role”. When you run the SHOW GRANTS command to show the grants to tasty_role, what is the first value you see under the “privilege” column, and what is the first value you see under the “granted_to” column?
GRANT CREATE DATABASE ON ACCOUNT TO ROLE tasty_role;
-- CREATE DATABASE / ROLE

-- Q4: Run the command “SELECT CURRENT_USER;” to see your username, and then use the GRANT ROLE… TO USER command to grant the “tasty_role” role to your username.
-- Then use the USE ROLE command to switch to the role “tasty_role”. Finally, in the “tasty_role” role, use the CREATE WAREHOUSE command to create a warehouse called “tasty_test_wh”.
-- What do you see in the Results? -- ACCOUNTADMIN
SELECT CURRENT_USER; -- admin
GRANT ROLE TASTY_ROLE TO USER ADMIN;
USE ROLE TASTY_ROLE;
CREATE OR REPLACE WAREHOUSE tasty_test_wh;
USE ROLE ACCOUNTADMIN;
SHOW GRANTS TO USER ADMIN;

-- Q6: Use the SHOW GRANTS command to show grants to the role “USERADMIN”. What are the privileges you see in the “privilege” column?
SHOW GRANTS TO ROLE USERADMIN;
USE ROLE USERADMIN;
SELECT CURRENT_ROLE(); -- useradmin;
CREATE OR REPLACE USER tastyadmin_VIA_USERADMIN
  PASSWORD = 'TASTYBYTES'
  MUST_CHANGE_PASSWORD = FALSE
  DEFAULT_NAMESPACE = TASTY_BYTES_CLONE;
