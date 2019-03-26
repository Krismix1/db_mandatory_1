Use hotel;

INSERT into booking_status(status) values('CHECKED_IN');
INSERT into booking_status(status) values('CHECKED_OUT');
INSERT into booking_status(status) values('CANCELLED');

INSERT INTO room_types (name) VALUES ('SINGLE');
INSERT INTO room_types (name) VALUES ('DOUBLE');
INSERT INTO room_types (name) VALUES ('FAMILY');

insert into rooms (room_nr, room_type_id) values (100, 1);
insert into rooms (room_nr, room_type_id) values (200, 2);
insert into rooms (room_nr, room_type_id) values (300, 3);
insert into rooms (room_nr, room_type_id) values (101, 1);
insert into rooms (room_nr, room_type_id) values (202, 2);
insert into rooms (room_nr, room_type_id) values (303, 3);
insert into rooms (room_nr, room_type_id) values (102, 1);
insert into rooms (room_nr, room_type_id) values (201, 2);
insert into rooms (room_nr, room_type_id) values (301, 3);
insert into rooms (room_nr, room_type_id) values (103, 1);