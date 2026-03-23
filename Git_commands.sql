-- Valid Commands
SHOW GIT REPOSITORIES;
SHOW GIT BRANCHES IN <repo>;
SHOW GIT TAGS IN <repo>;
SHOW GIT VERSIONS IN <repo>;


-- Fetch latest changes from the remote repo
ALTER GIT REPOSITORY advanced_data_engineering_snowflake FETCH;

-- How to fetch and switch to a specific branch
ALTER GIT REPOSITORY advanced_data_engineering_snowflake FETCH;
ALTER GIT REPOSITORY advanced_data_engineering_snowflake SET BRANCH = 'feature/git_documentation';

-- List files after fetching
-- LIST @advanced_data_engineering_snowflake;  <-- Files paths in git repositories must specify a scope. For example, a branch name, a tag name, or a valid commit hash. Commit hashes are between 6 and 40 characters long.
LIST @advanced_data_engineering_snowflake/branches/main;  --  <-- Must specify a branch

-- What branches exist?
SHOW GIT BRANCHES IN advanced_data_engineering_snowflake;

/*
Note: In Snowsight... one repo object = 1 branch
So... you cannot just switch to a different branch. Instead, you must create a new Git repo object like this...
*/
-- CREATE OR REPLACE GIT REPOSITORY advanced_data_engineering_snowflake_feature
--   ORIGIN = 'https://github.com/bcpurkistraining/advanced-data-engineering-snowflake.git'
--   BRANCH = 'feature/git_documentation';



