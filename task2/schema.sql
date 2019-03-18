DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

CREATE TABLE books (
  id                   int unsigned NOT NULL AUTO_INCREMENT,
  isbn                 char(13) NOT NULL UNIQUE, -- use chars so that we can have '0' as first digits, not empty should only contain digits
  title                varchar(64) NOT NULL UNIQUE,
  authors              varchar(255), -- later could be changed to a FK
  publisher            varchar(64),
  year_of_publication  tinyint,
  PRIMARY KEY (id)
);

CREATE TABLE book_copies (
  copy_number int unsigned NOT NULL AUTO_INCREMENT,
  book_id int unsigned NOT NULL,
  status varchar(16) NOT NULL,
  allowed_loan_period tinyint NOT NULL,
  PRIMARY KEY (copy_number),
  FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE borrower_types (
  id          int unsigned NOT NULL AUTO_INCREMENT,
  name        varchar(16) NOT NULL UNIQUE, -- not empty
  max_number  tinyint NOT NULL, -- > 0?
  PRIMARY KEY (id)
);

CREATE TABLE borrowers (
  id int unsigned NOT NULL AUTO_INCREMENT,
  name varchar(64) NOT NULL UNIQUE,
  mail_address varchar(128) NOT NULL UNIQUE,
  borrower_type_id int unsigned NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (borrower_type_id) REFERENCES borrower_types(id)
);

CREATE TABLE loans (
  id int unsigned NOT NULL AUTO_INCREMENT,
  borrower_id int unsigned NOT NULL,
  book_id int unsigned NOT NULL,
  loaned_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  returned_at timestamp NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (borrower_id) REFERENCES borrowers(id),
  FOREIGN KEY (book_id) REFERENCES books(id)
);
