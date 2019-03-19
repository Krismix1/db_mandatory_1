### Task 2 solution

This folder contains the solution files for task 2.

File structure/purpose:
  - `schema.sql` - defines the overall schema of the database (DDL)
  - `builtin.sql` - contains the data that needs to be inserted in the database for proper functioning
  - `dummies.sql` - optional data that can be inserted (e.g. for testing the solutions)
  - `max_loan_constraint.sql` - the constrain for the maximal number of books allowed for loan by a borrower
  - `borrower.sql` - contains subroutines to check if a book title has any copy available, to find all borrowers who have ever loaned a book title and to find all borrowers who have an ongoing loan for a book title
  - `overdue.sql` - contains subroutines to find all borrowers who have ever returned a loan with overdue and to find all borrowers who have an ongoing loan with overdue
