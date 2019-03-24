### Task 2 solution

This folder contains the solution files for task 2.
The solution is done for [MySQL 5.6](https://dev.mysql.com/doc/refman/5.6/en/).

#### File structure/purpose:
  - `schema.sql` - defines the overall schema of the database (DDL)
  - `builtin.sql` - contains the data that needs to be inserted in the database for proper functioning
  - `triggers_subroutines.sql` - contains the subroutines, triggers for data validation
  - `dummies.sql` - contains optional data that can be used for testing
  - `tests.sql` - DML statements to test the data validation triggers


#### Order of execution to complete task 2:
  1. `schema.sql`
  2. `triggers_subroutines.sql`
  3. `builtin.sql`
  4. `dummies.sql` (Optional)
  5. `tests.sql` (Optional, but requires step **4**)
