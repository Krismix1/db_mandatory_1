\q
psql -d it_company;


--------------------------------------------------
-- Function to find all instructor for a course --
--------------------------------------------------
CREATE OR REPLACE FUNCTION find_instructors_for_course (IN course varchar(64)) RETURNS SETOF instructors
LANGUAGE plpgsql AS $$
DECLARE
    r instructors%rowtype;
BEGIN
  FOR r IN
    (SELECT i.* FROM instructors i
      INNER JOIN teams_instructors ti ON i.id = ti.instructor_id
        INNER JOIN teams t ON t.id = ti.team_id
          INNER JOIN courses c ON c.id = t.course_id WHERE c.name = course ORDER BY i.id)
  LOOP
    RETURN NEXT r; -- return current row of SELECT
  END LOOP;
  RETURN;
END$$;


----------------------------------------------
-- Check max number of trainees per session --
----------------------------------------------
CREATE OR REPLACE FUNCTION check_max_trainees_per_session() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  i smallint default 0;
  max_nr smallint default 5;
BEGIN
  SELECT COUNT(1) INTO i FROM training_sessions_trainees s
    WHERE s.session_id = new.session_id;
  IF (i >= max_nr) THEN
    RAISE EXCEPTION 'Maximum numbers of trainees/session (%) for #% already achieved', max_nr, new.session_id
      USING ERRCODE='46000';
  END IF;
  RETURN new;
END$$;

DROP TRIGGER IF EXISTS trainee_per_session_before_constraint ON training_sessions_trainees CASCADE;
CREATE TRIGGER trainee_per_session_before_constraint BEFORE INSERT OR UPDATE ON training_sessions_trainees
  FOR EACH ROW EXECUTE PROCEDURE check_max_trainees_per_session();


----------------------------------------
-- Check maximum instructors per team --
----------------------------------------
CREATE OR REPLACE FUNCTION check_maximum_instructors_per_team() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  max_nr smallint := 0;
  curr   smallint := 0;
BEGIN
  SELECT max_team_size INTO max_nr FROM teams t WHERE t.id = new.team_id;
  SELECT COUNT(1) INTO curr FROM teams_instructors ti WHERE ti.team_id = new.team_id;
  IF curr >= max_nr THEN
    RAISE EXCEPTION 'max size (%) for team #% already achieved', max_nr, new.team_id
      USING ERRCODE='48001';
  END IF;
  RETURN new;
END$$;

DROP TRIGGER IF EXISTS max_team_size_constraint ON teams_instructors CASCADE;
CREATE TRIGGER max_team_size_constraint BEFORE INSERT OR UPDATE ON teams_instructors
  FOR EACH ROW EXECUTE PROCEDURE check_maximum_instructors_per_team();



-- This solution requires explicit deletion of the instructor from those table before reassigning
---------------------------------------------------------------------------
-- An instructor cannot be part of `researchers` and `teams_instructors` --
---------------------------------------------------------------------------

-- Function to check if an instructor is part of a team or research
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


-----------------------------------------------------------
-- Check to how many teams an instructor can be assigned --
-----------------------------------------------------------
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

DROP TRIGGER IF EXISTS instructor_in_team_constraint ON teams_instructors CASCADE;
CREATE TRIGGER instructor_in_team_constraint BEFORE INSERT OR UPDATE ON teams_instructors
  FOR EACH ROW EXECUTE PROCEDURE max_teams_per_instructor();
