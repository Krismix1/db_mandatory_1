-- Reset/drop existing database and create a new one
\q
dropdb --if-exists 'it_company';
createdb 'it_company';
psql -d 'it_company';


CREATE TABLE courses (
  id          serial,
  name        varchar(64) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE teams (
  id             serial,
  course_id      bigint NOT NULL,     -- TODO: Can multiple teams teach the same course?
  max_team_size  smallint CONSTRAINT max_size CHECK (max_team_size > 0), -- Number of maximum instructors allowed per team
  PRIMARY KEY (id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Any extra information can be stored (e.g. name, email etc.)
CREATE TABLE trainees (
  id          serial,
  PRIMARY KEY (id)
);

-- Any extra information can be stored (e.g. time range)
CREATE TABLE training_sessions (
  id          serial,
  team_id     bigint,
  PRIMARY KEY (id),
  FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE training_sessions_trainees (
  trainee_id  bigint,
  session_id  bigint,
  PRIMARY KEY (trainee_id, session_id), -- If we need to allow the trainee to retake the course, this should be removed
  FOREIGN KEY (trainee_id) REFERENCES trainees(id),
  FOREIGN KEY (session_id) REFERENCES training_sessions(id)
);

CREATE TABLE instructors (
  id          serial,
  name        varchar(64) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE teams_instructors (
  team_id        bigint,
  instructor_id  bigint,
  PRIMARY KEY (team_id, instructor_id),
  FOREIGN KEY (team_id) REFERENCES teams(id),
  FOREIGN KEY (instructor_id) REFERENCES instructors(id)
);

-- Allows to assign a instructor to do research
-- An instructor can not be part of a team and of research at the same time
CREATE TABLE researchers (
  instructor_id bigint,
  PRIMARY KEY   (instructor_id), -- Avoid duplication, and overall benefits (speed) from an index
  FOREIGN KEY   (instructor_id) REFERENCES instructors(id)
);
