DROP DATABASE IF EXISTS it_company;
CREATE DATABASE it_company;
USE it_company;


CREATE TABLE courses (
  id          int unsigned NOT NULL AUTO_INCREMENT,
  name        varchar(64) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE teams (
  id             int unsigned NOT NULL AUTO_INCREMENT,
  course_id      int unsigned NOT NULL,  -- TODO: Can multiple teams teach the same course?
  min_team_size  tinyint(1) unsigned, -- Number of minimum instructors required per team
  max_team_size  tinyint(1) unsigned, -- Number of maximum instructors allowed per team
  PRIMARY KEY (id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);
-- Any extra information can be stored (e.g. name, email etc.)
CREATE TABLE trainees (
  id          int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id)
);

-- Any extra information can be stored (e.g. time range)
CREATE TABLE training_sessions (
  id          int unsigned NOT NULL AUTO_INCREMENT,
  team_id     int unsigned NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE training_sessions_trainees (
  trainee_id  int unsigned NOT NULL,
  session_id  int unsigned NOT NULL,
  PRIMARY KEY (trainee_id, session_id), -- If we need to allow the trainee to retake the course, this should be removed
  FOREIGN KEY (trainee_id) REFERENCES trainees(id),
  FOREIGN KEY (session_id) REFERENCES training_sessions(id)
);

CREATE TABLE instructors (
  id          int unsigned NOT NULL AUTO_INCREMENT,
  name        varchar(64) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE teams_instructors (
  team_id        int unsigned NOT NULL,
  instructor_id  int unsigned NOT NULL,
  PRIMARY KEY (team_id, instructor_id),
  FOREIGN KEY (team_id) REFERENCES teams(id),
  FOREIGN KEY (instructor_id) REFERENCES instructors(id)
);

-- Allows to assign a instructor to do research
-- An instructor can not be part of a team and of research at the same time
CREATE TABLE researchers (
  instructor_id int unsigned NOT NULL,
  PRIMARY KEY   (instructor_id), -- Avoid duplication, and overall benefits (speed) from an index
  FOREIGN KEY   (instructor_id) REFERENCES instructors(id)
);
