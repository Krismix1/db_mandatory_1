USE library;

DROP FUNCTION IF EXISTS `book_copy_available`;
DELIMITER $
CREATE FUNCTION `book_copy_available`(title varchar(64))
  RETURNS tinyint(1) DETERMINISTIC
  RETURN (SELECT EXISTS(SELECT 1 FROM book_copies c -- TODO: Maybe reconsider using `exists` for better performance
         INNER JOIN books b ON b.id = c.book_id
         WHERE b.title = title AND c.status = 'available'));$
DELIMITER ;

-- Assuming the data from dummies was inserted:
SELECT book_copy_available('Media Manager 1'); -- Will return 0
SELECT book_copy_available('Quality Engineer'); -- Will return 1


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

-- Assuming the data from dummies was inserted:
CALL find_all_borrowers_of_title('Media Manager I'); -- Will show 3 records
CALL find_all_borrowers_of_title('Quality Engineer'); -- Will show 3 records


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

CALL find_current_borrowers_of_title('Media Manager I');
CALL find_current_borrowers_of_title('Quality Engineer');
