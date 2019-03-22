USE it_company;

DROP PROCEDURE IF EXISTS `check_max_trainees_per_session`;
DELIMITER $
CREATE PROCEDURE `check_max_trainees_per_session`(IN session_id int unsigned)
BEGIN
  DECLARE current tinyint unsigned DEFAULT 0;
  SELECT COUNT(1) INTO current FROM training_sessions_trainees s
    WHERE s.session_id = session_id;
  IF current >= 5 THEN -- TODO: Increase it to '100' when finished with testing
    SIGNAL SQLSTATE '46000'
      SET MESSAGE_TEXT = 'check constraint on max_trainee_per_session failed';
  END IF;
END$

-- Before insert
DROP TRIGGER IF EXISTS `trainee_per_session_before_insert`$
CREATE TRIGGER `trainee_per_session_before_insert` BEFORE INSERT ON `training_sessions_trainees`
FOR EACH ROW
BEGIN
  CALL check_max_trainees_per_session(new.session_id);
END$
-- Before update
DROP TRIGGER IF EXISTS `trainee_per_session_before_update`$
CREATE TRIGGER `trainee_per_session_before_update` BEFORE UPDATE ON `training_sessions_trainees`
FOR EACH ROW
BEGIN
  CALL check_max_trainees_per_session(new.session_id);
END$
DELIMITER ;

-- Assuming the data for table `training_sessions` from `dummies.sql` was inserted:
INSERT INTO trainees() VALUES (), (), (), (), ();
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5);
-- The line below will fail (with error that only '5' trainees are allowed per training session)
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 6);
