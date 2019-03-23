USE library;

DROP PROCEDURE IF EXISTS `find_all_borrowers_with_overdue`;
DELIMITER $
CREATE PROCEDURE `find_all_borrowers_with_overdue`()
BEGIN
  SELECT br.* FROM borrowers br
  INNER JOIN loans l ON l.borrower_id = br.id
  WHERE DATEDIFF(NOW(), l.loaned_at) > l.loan_period;
END$
DELIMITER ;

CALL find_all_borrowers_with_overdue();


DROP PROCEDURE IF EXISTS `find_all_current_borrowers_with_overdue`;
DELIMITER $
CREATE PROCEDURE `find_all_current_borrowers_with_overdue`()
BEGIN
  SELECT br.* FROM borrowers br
  INNER JOIN loans l ON l.borrower_id = br.id
  WHERE DATEDIFF(NOW(), l.loaned_at) > l.loan_period AND l.returned_at IS NULL;
END$
DELIMITER ;

CALL find_all_current_borrowers_with_overdue();
