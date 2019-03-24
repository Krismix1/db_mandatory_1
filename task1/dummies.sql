\q
psql -d it_company;

INSERT INTO courses (name) VALUES ('Automation Specialist I');
INSERT INTO courses (name) VALUES ('Databases for Developers');
INSERT INTO courses (name) VALUES ('Senior Quality Engineer');
INSERT INTO courses (name) VALUES ('Quality Engineer');
INSERT INTO courses (name) VALUES ('Food Chemist');


INSERT INTO teams (course_id, max_team_size) VALUES (2, 30); -- id: 1, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (1, 30); -- id: 2, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (3, 30); -- id: 3, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (2, 30); -- id: 4, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (4, 30); -- id: 5, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (5, 30); -- id: 6, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (4, 30); -- id: 7, The requirements tell that the company has 30 instructors
INSERT INTO teams (course_id, max_team_size) VALUES (4, 30); -- id: 8, used to test researchers & teams_instructors constraints


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


INSERT INTO teams_instructors VALUES (1, 22);
INSERT INTO teams_instructors VALUES (3, 30);
INSERT INTO teams_instructors VALUES (6, 27);
INSERT INTO teams_instructors VALUES (2, 9 );
INSERT INTO teams_instructors VALUES (5, 17);
INSERT INTO teams_instructors VALUES (4, 15);
INSERT INTO teams_instructors VALUES (2, 24);
INSERT INTO teams_instructors VALUES (2, 26);
INSERT INTO teams_instructors VALUES (3, 27);
INSERT INTO teams_instructors VALUES (7, 19);


INSERT INTO researchers VALUES (29);


INSERT INTO training_sessions (team_id) VALUES (1); -- id: 1
