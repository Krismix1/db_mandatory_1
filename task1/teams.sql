\q
psql -d it_company;


-- Check maximum instructors per team
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


INSERT INTO teams (course_id, max_team_size) VALUES (1, 1); -- id: 9
-- will fail with message: max size (1) for team #9 already achieved
INSERT INTO teams_instructors (team_id, instructor_id) VALUES (9, 8);
