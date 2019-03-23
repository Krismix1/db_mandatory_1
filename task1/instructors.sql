USE it_company;

-- An instructor cannot be part of `researchers` and `teams_instructors`
-- This solution requires explicit deletion of the instructor from those table before reassigning
DROP FUNCTION IF EXISTS `is_instructor_in_table`;
DELIMITER $
CREATE FUNCTION `is_instructor_in_table`(id int unsigned, table_name varchar(64))
  RETURNS tinyint(1) DETERMINISTIC
    IF table_name = 'researchers' THEN
      RETURN (SELECT EXISTS(SELECT 1 FROM researchers r WHERE r.instructor_id = id LIMIT 1));
    ELSEIF table_name = 'teams_instructors' THEN
      RETURN (SELECT EXISTS(SELECT 1 FROM teams_instructors r WHERE r.instructor_id = id LIMIT 1));
    ELSE
      SIGNAL SQLSTATE '47000'
        SET MESSAGE_TEXT = 'unknown table';
    END IF;$


-- Check that an instructor is not already assigned as a researcher
DROP TRIGGER IF EXISTS `check_instructor_team_before_insert`$
-- Before create
CREATE TRIGGER `check_instructor_team_before_insert` BEFORE INSERT ON `teams_instructors`
FOR EACH ROW
BEGIN
  IF (SELECT is_instructor_in_table(new.instructor_id, 'researchers')) = 1 THEN
    SIGNAL SQLSTATE '47001'
      SET MESSAGE_TEXT = 'instructor is already a researcher';
  ELSE BEGIN
    DECLARE i tinyint(1) DEFAULT 0;
    SELECT COUNT(1) INTO i FROM teams_instructors t WHERE t.instructor_id = new.instructor_id;
    IF i >= 2 THEN
      SIGNAL SQLSTATE '47003'
        SET MESSAGE_TEXT = 'instructor can only be part of 2 teams';
    END IF;
    END;
  END IF;
  -- Check if maximum number of members per team is not exhausted
  DECLARE i tinyint(1) unsigned DEFAULT 0;
  DECLARE max_team_size tinyint(1) unsigned DEFAULT 0;
  SELECT COUNT(1) INTO i FROM teams_instructors t WHERE t.team_id = new.team_id;
  SELECT t.max_team_size INTO max_team_size FROM teams t WHERE t.id = new.team_id;

END$
-- Before update
DROP TRIGGER IF EXISTS `check_instructor_teams_before_update`$
CREATE TRIGGER `check_instructor_teams_before_update` BEFORE UPDATE ON `teams_instructors`
FOR EACH ROW
BEGIN
  IF (SELECT is_instructor_in_table(new.instructor_id, 'researchers')) = 1 THEN
    SIGNAL SQLSTATE '47001'
      SET MESSAGE_TEXT = 'instructor is already a researcher';
  ELSE BEGIN
    DECLARE i tinyint(1) DEFAULT 0;
    SELECT COUNT(1) INTO i FROM teams_instructors t WHERE t.instructor_id = new.instructor_id;
    IF i >= 2 THEN
      SIGNAL SQLSTATE '47003'
        SET MESSAGE_TEXT = 'instructor can only be part of 2 teams';
    END IF;
    END;
  END IF;
END$


-- Check that an instructor is not already assigned to a teaching team
DROP TRIGGER IF EXISTS `check_instructor_researcher_before_insert`$
-- Before create
CREATE TRIGGER `check_instructor_researcher_before_insert` BEFORE INSERT ON `researchers`
FOR EACH ROW
BEGIN
  IF (SELECT is_instructor_in_table(new.instructor_id, 'teams_instructors')) = 1 THEN
    SIGNAL SQLSTATE '47002'
      SET MESSAGE_TEXT = 'instructor is already in a teaching team';
  END IF;
END$
-- Before update
DROP TRIGGER IF EXISTS `check_instructor_researcher_before_update`$
CREATE TRIGGER `check_instructor_researcher_before_update` BEFORE UPDATE ON `researchers`
FOR EACH ROW
BEGIN
  IF (SELECT is_instructor_in_table(new.instructor_id, 'teams_instructors')) = 1 THEN
    SIGNAL SQLSTATE '47002'
      SET MESSAGE_TEXT = 'instructor is already in a teaching team';
  END IF;
END$

DELIMITER ;


-- Assuming the data for table `training_sessions` from `dummies.sql` was inserted:
INSERT INTO teams_instructors VALUES (2, 22);
-- The line below will fail (with error that an instructor can be part of only 2 teams max)
INSERT INTO teams_instructors VALUES (3, 22);
-- The line below will fail (with error that an instructor should not be in a team before assigning to research)
INSERT INTO researchers VALUES(22);
-- The line below will fail (with error that an instructor should not be in research before assigning to team)
INSERT INTO teams_instructors VALUES (8, 29);
