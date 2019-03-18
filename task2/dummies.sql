USE library;

INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0093752529520', 'Media Manager I', 'Britt Egarr', 'Browsebug', 2011);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0180887638511', 'Quality Engineer', 'Twyla Burd', 'Mynte', 2007);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0278752461059', 'VP Sales', 'Reeva Aizikovitch', 'Twiyo', 1998);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0360192685910', 'Sales Representative', 'Judy Dorin', 'Blognation', 2008);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0457659554700', 'Technical Writer', 'Clerissa Scopyn', 'Ntags', 1992);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0543425853988', 'Programmer Analyst III', 'Cheslie Feeham', 'Bubblemix', 2007);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0630468240357', 'Design Engineer', 'Warden Plaunch', 'Linktype', 1993);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0720568891546', 'Web Developer III', 'Paulie Bemrose', 'Livefish', 2002);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0817553433799', 'Office Assistant IV', 'Edna Treby', 'Feedfire', 2011);
INSERT INTO books (isbn, title, authors, publisher, year_of_publication) VALUES ('0906979426400', 'Director of Sales', 'Archibold Cheake', 'Minyx', 1993);

INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (10, 5,  'available');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (8,  38, 'taken');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (3,  83, 'available');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (1,  38, 'taken');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (2,  70, 'available');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (7,  36, 'available');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (1,  40, 'taken');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (6,  80, 'available');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (1,  5,  'taken');
INSERT INTO book_copies (book_id, allowed_loan_period, status) VALUES (7,  2,  'available');


INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Agna Crollman',     '0 Stone Corner Pass',  1);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Melesa Topham',     '42 John Wall Plaza',   3);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Mariellen Channon', '292 Hagan Court',      3);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Andeee Ferney',     '2 Oakridge Street',    1);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Wilfred Townsend',  '3919 Holmberg Center', 1);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Nat Birdsey',       '67955 Forster Street', 2);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Mirelle Flockhart', '29 Homewood Alley',    1);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Asia Henkmann',     '7 Bluestem Alley',     2);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Thornton Romao',    '5275 Superior Center', 2);
INSERT INTO borrowers (name, mail_address, borrower_type_id) VALUES ('Nickolai Benkin',   '05 Sachs Drive',       1);


-- Loans in progress without overdue
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (84, DATE_SUB(NOW(), INTERVAL 3 DAY), 10, 3);
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (83, DATE_SUB(NOW(), INTERVAL 3 DAY), 8,  4);
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (52, DATE_SUB(NOW(), INTERVAL 3 DAY), 5,  7);
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (41, DATE_SUB(NOW(), INTERVAL 3 DAY), 2,  5);
-- Loans in progress with overdue
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (2, DATE_SUB(NOW(), INTERVAL 3 DAY), 4,  9);
INSERT INTO loans (loan_period, loaned_at, borrower_id, book_copy_number) VALUES (3, DATE_SUB(NOW(), INTERVAL 4 DAY), 3,  8);
-- Finished loans without overdue
INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (5, '2019-03-15 11:38:55', '2019-03-11 11:38:55', 8,  5);
INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (7, '2018-02-15 10:38:55', '2018-02-10 10:38:55', 9,  2);
-- Finished loans with overdue
INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (5,  NOW(), DATE_SUB(NOW(), INTERVAL 7 DAY),  7,  5);
INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (10, '2017-11-27 09:49:00', DATE_SUB('2017-11-27 09:49:00', INTERVAL 12 DAY),  4,  2);
-- INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (8,  '21:42:00', '01:48:00',  7,  3);
-- INSERT INTO loans (loan_period, loaned_at, returned_at, borrower_id, book_copy_number) VALUES (80, '07:09:00', '16:23:00', 7,  7);
