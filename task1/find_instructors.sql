\q
psql -d it_company;

-- Function to find all instructor for a course
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
END;
$$;

-- Assuming the data from `dummies.sql` was inserted:
SELECT find_instructors_for_course('Databases for Developers'); -- Will show 2 records
