\q
psql -d it_company;

-- An instructor cannot be part of `researchers` and `teams_instructors`
-- This solution requires explicit deletion of the instructor from those table before reassigning
CREATE OR REPLACE FUNCTION is_instructor_in_table(id bigint, table_name varchar(64))
  RETURNS boolean AS $$
BEGIN
  IF table_name = 'researchers' THEN
    RETURN (SELECT EXISTS(SELECT 1 FROM researchers r WHERE r.instructor_id = id LIMIT 1));
  ELSEIF table_name = 'teams_instructors' THEN
    RETURN (SELECT EXISTS(SELECT 1 FROM teams_instructors r WHERE r.instructor_id = id LIMIT 1));
  ELSE
    RAISE EXCEPTION 'unknown table %', table_name USING ERRCODE='47000';
  END IF;
END$$ LANGUAGE plpgsql;


-- Check instructor is not in researchers
CREATE OR REPLACE FUNCTION check_instructor_in_researchers() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF is_instructor_in_table(new.instructor_id, CAST('researchers' as varchar(64))) THEN
    RAISE EXCEPTION 'instructor #% is already a researcher', new.instructor_id
      USING ERRCODE='47001';
  END IF;
  RETURN new;
END$$;

DROP TRIGGER IF EXISTS instructor_in_researchers_constraint ON teams_instructors CASCADE;
CREATE TRIGGER instructor_in_researchers_constraint BEFORE INSERT OR UPDATE ON teams_instructors
  FOR EACH ROW EXECUTE PROCEDURE check_instructor_in_researchers();

-- Check that an instructor is not already assigned to a teaching team
CREATE OR REPLACE FUNCTION check_instructor_in_team() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF is_instructor_in_table(new.instructor_id, CAST('teams_instructors' as varchar(64))) THEN
    RAISE EXCEPTION 'instructor #% is already in a team', new.instructor_id
      USING ERRCODE='47002';
  END IF;
  RETURN new;
END$$;

DROP TRIGGER IF EXISTS instructor_in_team_constraint ON researchers CASCADE;
CREATE TRIGGER instructor_in_team_constraint BEFORE INSERT OR UPDATE ON researchers
  FOR EACH ROW EXECUTE PROCEDURE check_instructor_in_team();


CREATE OR REPLACE FUNCTION max_teams_per_instructor() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  i smallint DEFAULT 0;
BEGIN
  SELECT COUNT(1) INTO i FROM teams_instructors t WHERE t.instructor_id = new.instructor_id LIMIT 2;
  IF i >= 2 THEN
    RAISE EXCEPTION 'instructor #% is already in 2 teams', new.instructor_id
      USING ERRCODE='47003';
  END IF;
  RETURN new;
END$$;
-- trigger
DROP TRIGGER IF EXISTS instructor_in_team_constraint ON teams_instructors CASCADE;
CREATE TRIGGER instructor_in_team_constraint BEFORE INSERT OR UPDATE ON teams_instructors
  FOR EACH ROW EXECUTE PROCEDURE max_teams_per_instructor();


-- Assuming the data for table `training_sessions` from `dummies.sql` was inserted:
INSERT INTO teams_instructors VALUES (2, 22);
-- The line below will fail (with error that an instructor can be part of only 2 teams max)
INSERT INTO teams_instructors VALUES (3, 22);
-- The line below will fail (with error that an instructor should not be in a team before assigning to research)
INSERT INTO researchers VALUES(22);
-- The line below will fail (with error that an instructor should not be in research before assigning to team)
INSERT INTO teams_instructors VALUES (8, 29);
