/* 
SQL-level Git Repository Objects (GIT REPOSITORY)
* These are shallow clones
* They cache branch metadata
* They do NOT prune deleted branches
* They only update refs when you run FETCH
* Even after FETCH, deleted branches may remain visible
* They are not designed for branch management

This is why:

✔ The Snowsight branch dropdown shows only real GitHub branches
❌ But SHOW GIT BRANCHES IN <repo> still shows old, deleted branches

Snowflake Git Repositories are designed for:
* reading code
* referencing files
* version pinning
* reproducible deployments
* They are not designed to mirror GitHub’s branch lifecycle.
* So Snowflake:
* pulls new branches
* updates existing branches
* does not delete branches that disappeared upstream
* does not support branch switching
* does not support branch pruning
T
his is why deleted branches linger.

*/

-- Valid Commands
SHOW GIT REPOSITORIES;
SHOW GIT BRANCHES IN <repo>;
SHOW GIT TAGS IN <repo>;
SHOW GIT VERSIONS IN <repo>;


-- Fetch latest changes from the remote repo
ALTER GIT REPOSITORY advanced_data_engineering_snowflake FETCH;


-- List files after fetching
-- LIST @advanced_data_engineering_snowflake;  <-- Files paths in git repositories must specify a scope. For example, a branch name, a tag name, or a valid commit hash. Commit hashes are between 6 and 40 characters long.
LIST @advanced_data_engineering_snowflake/branches/main;  --  <-- Must specify a branch

-- What branches exist?
SHOW GIT BRANCHES IN advanced_data_engineering_snowflake; -- The SQL-level git repository objects are "shallow clones" and will cache branch metadata (continue to show deleted branches cuz they were cached ) 

/*
Note: In Snowsight... one repo object = 1 branch
So... you cannot just switch to a different branch. Instead, you must create a new Git repo object like this...
*/
-- CREATE OR REPLACE GIT REPOSITORY advanced_data_engineering_snowflake_feature
--   ORIGIN = 'https://github.com/bcpurkistraining/advanced-data-engineering-snowflake.git'
--   BRANCH = 'feature/git_documentation';



