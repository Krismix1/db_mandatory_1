USE library;

DROP PROCEDURE IF EXISTS `check_max_loan`;
DELIMITER $
-- , IN copy_id int unsigned
CREATE PROCEDURE `check_max_loan`(IN borrower_id int unsigned)
BEGIN
  DECLARE total_loans tinyint DEFAULT 0;
  DECLARE max_loans tinyint DEFAULT 0;
  SELECT COUNT(*) INTO total_loans FROM loans l WHERE l.borrower_id = borrower_id;
  SELECT t.max_books_count INTO max_loans
    FROM borrower_types t INNER JOIN borrowers b ON t.id = b.borrower_type_id
      WHERE b.id = borrower_id GROUP BY b.id ORDER BY b.id;
  IF total_loans >= max_loans THEN
    SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'check constraint on borrower_types.max_books_count failed';
  END IF;
END$
DELIMITER ;

-- before insert
DROP TRIGGER IF EXISTS `loans_before_insert`;
DELIMITER $
CREATE TRIGGER `loans_before_insert` BEFORE INSERT ON `loans`
FOR EACH ROW
BEGIN
  CALL check_max_loan(new.borrower_id);
END$
DELIMITER ;
-- before update
DROP TRIGGER IF EXISTS `loans_before_update`;
DELIMITER $
CREATE TRIGGER `loans_before_update` BEFORE UPDATE ON `loans`
FOR EACH ROW
BEGIN
  CALL check_max_loan(new.borrower_id);
END$
DELIMITER ;

-- Prerequisites:
  -- No existing records where loans.borrower_id = 2
  -- A borrower with id=2, whose borrower_type is 'Guest' (allowed to loan only 1 book)
  -- A book_copy with id=3
-- The next insert should succeed
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (84, DATE_SUB(NOW(), INTERVAL 3 DAY), 2, 3);
-- The next insert should fail
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (84, DATE_SUB(NOW(), INTERVAL 3 DAY), 2, 3);
