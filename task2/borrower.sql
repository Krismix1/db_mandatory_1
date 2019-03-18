DROP FUNCTION IF EXISTS `book_copy_available`;
DELIMITER $
CREATE FUNCTION `book_copy_available`(title varchar(64))
  RETURNS tinyint(1) DETERMINISTIC
  RETURN (SELECT EXISTS(SELECT 1 FROM book_copies c
         INNER JOIN books b ON b.id = c.book_id
         WHERE b.title = title AND c.status = 'available'));$
DELIMITER ;
