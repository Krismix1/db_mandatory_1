\q
psql -d it_company;

-- Assuming the data from `dummies.sql` was inserted:

-- e) Write SQL statements to print out the name/s of the instructors/s on ‘Databases for Developers’
SELECT find_instructors_for_course('Databases for Developers'); -- Will show 2 records


----------------------------------------------
-- Check max number of trainees per session --
----------------------------------------------
INSERT INTO trainees VALUES (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT);
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5);
-- The line below will fail (with error that only '5' trainees are allowed per training session)
INSERT INTO training_sessions_trainees(session_id, trainee_id) VALUES (1, 6);


----------------------------------------------
-- Check max number of trainees per session --
----------------------------------------------
INSERT INTO teams (course_id, max_team_size) VALUES (1, 1); -- id: 9
-- will fail with message: max size (1) for team #9 already achieved
INSERT INTO teams_instructors (team_id, instructor_id) VALUES (9, 8), (9, 7);


-----------------------------------------------------------
-- Check to how many teams an instructor can be assigned --
-----------------------------------------------------------
INSERT INTO teams_instructors VALUES (2, 22);
-- The line below will fail (with error that an instructor can be part of only 2 teams max)
INSERT INTO teams_instructors VALUES (3, 22);


---------------------------------------------------------------------------
-- An instructor cannot be part of `researchers` and `teams_instructors` --
---------------------------------------------------------------------------
-- The line below will fail (with error that an instructor should not be in a team before assigning to research)
INSERT INTO researchers VALUES(22);
-- The line below will fail (with error that an instructor should not be in research before assigning to team)
INSERT INTO teams_instructors VALUES (8, 29);
