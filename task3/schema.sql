DROP DATABASE IF EXISTS CozyHotel;
CREATE DATABASE CozyHotel;

use CozyHotel;
CREATE TABLE Rooms (
  room_number int NOT NULL,
  price decimal(4,2) NOT NULL,
  CONSTRAINT price_Ck CHECK (price BETWEEN 10 AND 100),
  room_type enum('single', 'double', 'apartment'),
  PRIMARY KEY (room_number)
);
use CozyHotel;
CREATE TABLE Guests (
  guestID int NOT NULL,
  first_name VARCHAR(64)NOT NULL,
  last_name VARCHAR(64)NOT NULL,
  email VARCHAR(64)NOT NULL,
  phone_number int NOT NULL,
  PRIMARY KEY (guestID)
);
use CozyHotel;
CREATE TABLE Bookings (
  bookingID int NOT NULL,
  check_in timestamp NOT NULL,
  check_out timestamp NOT NULL,
  guestID int NOT NULL,
  room_number int NOT NULL,
  is_cancelled boolean,
  PRIMARY KEY (bookingID),
  FOREIGN KEY (guestID) REFERENCES Guests(guestID),
  FOREIGN KEY (room_number) REFERENCES Rooms(room_number)
);