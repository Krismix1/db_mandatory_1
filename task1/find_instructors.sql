USE it_company;

DROP PROCEDURE IF EXISTS `find_instructors_for_course`;
DELIMITER $
-- Procedure to find all instructor for a course
CREATE PROCEDURE `find_instructors_for_course` (IN course varchar(64))
BEGIN
  SELECT i.name FROM instructors i
    INNER JOIN teams_instructors ti ON i.id = ti.instructor_id
      INNER JOIN teams t ON t.id = ti.team_id
        INNER JOIN courses c ON c.id = t.course_id WHERE c.name = course ORDER BY i.id; -- the order is not necessary
END$
DELIMITER ;

-- Assuming the data from `dummies.sql` was inserted:
CALL find_instructors_for_course('Databases for Developers'); -- Will show 2 records
