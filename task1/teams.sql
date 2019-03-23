USE it_company;

DELIMITER $
DROP TRIGGER IF EXISTS `check_max_and_min_before_insert`$
-- Before create
CREATE TRIGGER `check_max_and_min_before_insert` BEFORE INSERT ON `teams`
FOR EACH ROW
BEGIN
  IF new.max_team_size < new.min_team_size THEN
    SIGNAL SQLSTATE '48000'
      SET MESSAGE_TEXT = 'maximum number of members can not be smaller than minimum';
  END IF;
END$
-- Before update
DROP TRIGGER IF EXISTS `check_max_and_min_before_update`$
CREATE TRIGGER `check_max_and_min_before_update` BEFORE UPDATE ON `teams`
FOR EACH ROW
BEGIN
  IF new.max_team_size < new.min_team_size THEN
    SIGNAL SQLSTATE '48001'
      SET MESSAGE_TEXT = 'maximum number of members can not be smaller than minimum';
  END IF;
END$

DELIMITER ;
