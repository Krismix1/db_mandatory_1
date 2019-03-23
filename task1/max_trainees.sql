\q
psql -d it_company;

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


-- Assuming the data for table `training_sessions` from `dummies.sql` was inserted:
INSERT INTO trainees VALUES (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT);
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5);
-- The line below will fail (with error that only '5' trainees are allowed per training session)
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 6);
