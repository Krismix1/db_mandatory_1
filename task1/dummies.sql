INSERT INTO courses (name) VALUES ('Automation Specialist I');
INSERT INTO courses (name) VALUES ('Databases for Developers');
INSERT INTO courses (name) VALUES ('Senior Quality Engineer');
INSERT INTO courses (name) VALUES ('Quality Engineer');
INSERT INTO courses (name) VALUES ('Food Chemist');


INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (2, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (1, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (3, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (2, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (4, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (5, 2, 30); -- The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, min_team_size, max_team_size) VALUES (4, 2, 30); -- The requirements tell that the company has 30 instructors


INSERT INTO instructors (name) VALUES ('Angelique Moreside');     -- id: 1
INSERT INTO instructors (name) VALUES ('Lorelle Larvin');         -- id: 2
INSERT INTO instructors (name) VALUES ('Brett Rooms');            -- id: 3
INSERT INTO instructors (name) VALUES ('Magdalen Mortimer');      -- id: 4
INSERT INTO instructors (name) VALUES ('Allyce Torel');           -- id: 5
INSERT INTO instructors (name) VALUES ('Roxie Silberschatz');     -- id: 6
INSERT INTO instructors (name) VALUES ('Antoni Liddiatt');        -- id: 7
INSERT INTO instructors (name) VALUES ('Xena Tiley');             -- id: 8
INSERT INTO instructors (name) VALUES ('Adamo Thirtle');          -- id: 9
INSERT INTO instructors (name) VALUES ('Charis Shekle');          -- id: 10
INSERT INTO instructors (name) VALUES ('Ellynn Yoakley');         -- id: 11
INSERT INTO instructors (name) VALUES ('Roarke Powney');          -- id: 12
INSERT INTO instructors (name) VALUES ('Marsiella Gergolet');     -- id: 13
INSERT INTO instructors (name) VALUES ('Angeline Waitland');      -- id: 14
INSERT INTO instructors (name) VALUES ('Caressa Gillbard');       -- id: 15
INSERT INTO instructors (name) VALUES ('Aarika Gravet');          -- id: 16
INSERT INTO instructors (name) VALUES ('Ichabod Poon');           -- id: 17
INSERT INTO instructors (name) VALUES ('Janet Teresi');           -- id: 18
INSERT INTO instructors (name) VALUES ('Geoffry Pesak');          -- id: 19
INSERT INTO instructors (name) VALUES ('Letitia Bartolic');       -- id: 20
INSERT INTO instructors (name) VALUES ('Kirsteni Shemmans');      -- id: 21
INSERT INTO instructors (name) VALUES ('Martguerita Frostdippe'); -- id: 22
INSERT INTO instructors (name) VALUES ('Jaime Ewbanks');          -- id: 23
INSERT INTO instructors (name) VALUES ('El Caush');               -- id: 24
INSERT INTO instructors (name) VALUES ('Rafe Huertas');           -- id: 25
INSERT INTO instructors (name) VALUES ('Calypso Gleasane');       -- id: 26
INSERT INTO instructors (name) VALUES ('Devland Sille');          -- id: 27
INSERT INTO instructors (name) VALUES ('Terrance Tetther');       -- id: 28
INSERT INTO instructors (name) VALUES ('Bebe Joscelyne');         -- id: 29
INSERT INTO instructors (name) VALUES ('Nevin Strother');         -- id: 30


INSERT INTO teams_instructors (instructor_id, team_id) VALUES (22, 1);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (30, 3);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (27, 6);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (9,  2);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (17, 5);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (15, 4);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (24, 2);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (26, 2);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (27, 3);
INSERT INTO teams_instructors (instructor_id, team_id) VALUES (19, 7);
