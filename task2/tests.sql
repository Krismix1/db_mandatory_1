USE library;

-- Assuming the data from dummies was inserted:

-- -------------------------------------------------- --
-- Check if there is a book copy available for a name --
-- -------------------------------------------------- --
SELECT book_copy_available('Media Manager 1'); -- Will return 0
SELECT book_copy_available('Quality Engineer'); -- Will return 1


-- ----------------------------------- --
-- Find all borrowers for a book title --
-- ----------------------------------- --
CALL find_all_borrowers_of_title('Media Manager I'); -- Will show 3 records
CALL find_all_borrowers_of_title('Quality Engineer'); -- Will show 3 records


-- ------------------------------------------- --
-- Find all current borrowers for a book title --
-- ------------------------------------------- --
CALL find_current_borrowers_of_title('Media Manager I'); -- Will show 3 records
CALL find_current_borrowers_of_title('Quality Engineer'); -- Will show 1 record



-- Prerequisites:
  -- No existing records where loans.borrower_id = 2
  -- A borrower with id=2, whose borrower_type is 'Guest' (allowed to loan only 1 book)
  -- A book_copy with id=3
-- The next insert should succeed
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (84, DATE_SUB(NOW(), INTERVAL 3 DAY), 2, 3);
-- The next insert should fail
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (84, DATE_SUB(NOW(), INTERVAL 3 DAY), 2, 3);

-- ------------------------------------------- --
-- Find all borrowers that had an overdue ever --
-- ------------------------------------------- --
CALL find_all_borrowers_with_overdue(); -- Will show 3 records (4 loans but 3 unique borrowers)

-------------------------------------------------
-- Find current borrowers that have an overdue --
-------------------------------------------------
CALL find_all_current_borrowers_with_overdue(); -- Will show 2 records
