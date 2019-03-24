USE library;


-- -------------------------------------------------- --
-- Check if there is a book copy available for a name --
-- -------------------------------------------------- --
DROP FUNCTION IF EXISTS `book_copy_available`;
DELIMITER $
CREATE FUNCTION `book_copy_available`(title varchar(64))
  RETURNS tinyint(1) DETERMINISTIC
  RETURN (SELECT EXISTS(SELECT 1 FROM book_copies c -- TODO: Maybe reconsider using `exists` for better performance
           INNER JOIN books b ON b.id = c.book_id
             WHERE b.title = title AND c.status = 'available'));$
DELIMITER ;


-- ----------------------------------- --
-- Find all borrowers for a book title --
-- ----------------------------------- --
DROP PROCEDURE IF EXISTS `find_all_borrowers_of_title`;
DELIMITER $
-- Procedure to find any person who had borrowed or has an ongoing loan for a specific title
CREATE PROCEDURE `find_all_borrowers_of_title` (IN title varchar(64))
BEGIN
  SELECT br.* FROM borrowers br
    INNER JOIN loans l ON l.borrower_id = br.id
      INNER JOIN book_copies c ON c.copy_number = l.book_copy_number
        INNER JOIN books b ON b.id = c.book_id
          WHERE b.title = title;
END$
DELIMITER ;


-- ------------------------------------------- --
-- Find all current borrowers for a book title --
-- ------------------------------------------- --
DROP PROCEDURE IF EXISTS `find_current_borrowers_of_title`;
DELIMITER $
-- Procedure to find any person who had borrowed or has an ongoing loan for a specific title
CREATE PROCEDURE `find_current_borrowers_of_title` (IN title varchar(64))
BEGIN
  SELECT br.* FROM borrowers br
    INNER JOIN loans l ON l.borrower_id = br.id
      INNER JOIN book_copies c ON c.copy_number = l.book_copy_number
        INNER JOIN books b ON b.id = c.book_id
          WHERE b.title = title AND l.returned_at IS NULL;
END$
DELIMITER ;


-- ----------------------------------------------------- --
-- Constraint on how many books a borrower_type can loan --
-- ----------------------------------------------------- --
DROP PROCEDURE IF EXISTS `check_max_loan`;
DELIMITER $
CREATE PROCEDURE `check_max_loan`(IN borrower_id int unsigned)
BEGIN
  DECLARE total_loans tinyint DEFAULT 0;
  DECLARE max_loans tinyint DEFAULT 0;
  SELECT COUNT(1) INTO total_loans FROM loans l WHERE l.borrower_id = borrower_id;
  SELECT t.max_books_count INTO max_loans
    FROM borrower_types t INNER JOIN borrowers b ON t.id = b.borrower_type_id
      WHERE b.id = borrower_id GROUP BY b.id ORDER BY b.id;
  IF total_loans >= max_loans THEN
    SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'check constraint on borrower_types.max_books_count failed';
  END IF;
END$
DELIMITER ;

-- Before insert
DROP TRIGGER IF EXISTS `loans_before_insert`;
DELIMITER $
CREATE TRIGGER `loans_before_insert` BEFORE INSERT ON `loans`
  FOR EACH ROW
BEGIN
  CALL check_max_loan(new.borrower_id);
END$
DELIMITER ;
-- Before update
DROP TRIGGER IF EXISTS `loans_before_update`;
DELIMITER $
CREATE TRIGGER `loans_before_update` BEFORE UPDATE ON `loans`
  FOR EACH ROW
BEGIN
  CALL check_max_loan(new.borrower_id);
END$
DELIMITER ;


-- ------------------------------------------- --
-- Find all borrowers that had an overdue ever --
-- ------------------------------------------- --
DROP PROCEDURE IF EXISTS `find_all_borrowers_with_overdue`;
DELIMITER $
CREATE PROCEDURE `find_all_borrowers_with_overdue`()
BEGIN
  SELECT DISTINCT br.* FROM borrowers br
    INNER JOIN loans l ON l.borrower_id = br.id
      WHERE (l.returned_at IS NULL AND DATEDIFF(NOW(), l.loaned_at) > l.loan_period)
        OR (l.returned_at IS NOT NULL AND DATEDIFF(l.returned_at, l.loaned_at) > l.loan_period);
END$
DELIMITER ;


-- ------------------------------------------ --
-- Find current borrowers that had an overdue --
-- ------------------------------------------ --
DROP PROCEDURE IF EXISTS `find_all_current_borrowers_with_overdue`;
DELIMITER $
CREATE PROCEDURE `find_all_current_borrowers_with_overdue`()
BEGIN
  SELECT DISTINCT br.* FROM borrowers br
    INNER JOIN loans l ON l.borrower_id = br.id
      WHERE DATEDIFF(NOW(), l.loaned_at) > l.loan_period AND l.returned_at IS NULL;
END$
DELIMITER ;
