DROP DATABASE IF EXISTS hotel;
Create database hotel;
USE hotel;

CREATE TABLE room_types
(
  id   int unsigned AUTO_INCREMENT,
  name varchar(32) UNIQUE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE rooms
(
  room_nr      int unsigned UNIQUE NOT NULL,
  room_type_id int unsigned        NOT NULL,
  PRIMARY KEY (room_nr),
  FOREIGN KEY (room_type_id) REFERENCES room_types (id)
);

CREATE TABLE customers
(
  id         int unsigned auto_increment,
  first_name varchar(64) not null,
  last_name  varchar(64) not null,
  PRIMARY KEY (id)
);

create table booking_status
(
  id int unsigned auto_increment,
  status varchar(64),
  PRIMARY KEY (id)
);

CREATE TABLE bookings
(
  id          int unsigned auto_increment,
  room_nr_id  int unsigned,
  date_from   DATE,
  date_to     DATE,
  booking_status_id int unsigned,
  customer_id int unsigned,
  PRIMARY KEY (id),
  FOREIGN KEY (booking_status_id) references booking_status (id),
  FOREIGN KEY (customer_id) REFERENCES customers (id),
  FOREIGN KEY (room_nr_id) references rooms (room_nr)
);

create table newTable
(
 room_nr int unsigned,
 previous_type  int unsigned,
 new_type int unsigned
);
