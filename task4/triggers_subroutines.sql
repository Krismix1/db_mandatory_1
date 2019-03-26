Use hotel;
-- ------------------------------ --
-- Check for overlapping bookings (Task4c) --
-- ------------------------------ --
DROP PROCEDURE IF EXISTS `overlapping_bookings`;
DELIMITER $
create procedure overlapping_bookings(IN customer_id int unsigned, IN date_from DATE)
BEGIN
  if customer_id in(SELECT b.customer_id FROM bookings b WHERE date_from between b.date_from and b.date_to AND b.customer_id = customer_id)
  then
    SIGNAL SQLSTATE '45002'
      SET MESSAGE_TEXT = 'Customer has an overlapping booking';
  end if;
END $
DELIMITER ;

-- -------------------------------------- --
-- Make sure from date is not in the past --
-- -------------------------------------- --
DROP PROCEDURE IF EXISTS `check_from_date`;
DELIMITER $
create procedure check_from_date (IN date_from date)
BEGIN
  if date_from < CURRENT_DATE
    then
      SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'From date is in the past';
  end if;
end $
DELIMITER ;

-- ---------------------------------------------- --
-- Make sure that to date is later than from date --
-- ---------------------------------------------- --
DROP PROCEDURE IF EXISTS `check_to_date`;
DELIMITER $
create procedure check_to_date (IN date_to date, IN date_from date)
BEGIN
  if date_to < date_from
  then
    SIGNAL SQLSTATE '45001'
      SET MESSAGE_TEXT = 'To date is earlier than from date';
  end if;
end $
DELIMITER ;

-- ------------------------------ --
-- Triggers to check for overlaps --
-- ------------------------------ --
DROP TRIGGER IF EXISTS `before_bookings_insert`;
DELIMITER $
CREATE TRIGGER `before_bookings_insert` BEFORE INSERT ON `bookings`
  FOR EACH ROW
BEGIN
  CALL check_from_date(new.date_from);
  CAll check_to_date(new.date_to, new.date_from);
  CALL overlapping_bookings(new.customer_id, new.date_from);
END $
DELIMITER ;

-- ---------------------------------------------------------------- --
-- Query to find all guests currently staying at the hotel (Task4d) --
-- ---------------------------------------------------------------- --
Select* from customers where id IN (SELECT customer_id from bookings where booking_status_id=1);

-- ---------------------------------------------------- --
-- Function to print out most booked room type (Task4e) --
-- ---------------------------------------------------- --
DROP FUNCTION IF EXISTS `most_booked_room_type`;
DELIMITER $
create function most_booked_room_type()
returns varchar(32)
BEGIN
return(select room_types.name from bookings
  join rooms on bookings.room_nr_id = rooms.room_nr
  join room_types on rooms.room_type_id = room_types.id group by room_types.name order by count(1) desc limit 1);
end$

DELIMITER ;

-- ------------------------------------------------ --
-- Procedure to get all cancelled bookings (Task4f) --
-- ------------------------------------------------ --
DROP PROCEDURE IF EXISTS `list_cancelled_bookings`;
DELIMITER $
create procedure list_cancelled_bookings()
BEGIN
  Select c.*, room_types.name from  bookings
  join rooms on bookings.room_nr_id = rooms.room_nr
  join room_types on rooms.room_type_id = room_types.id
  join customers c on bookings.customer_id = c.id
  where booking_status_id=3 order by room_types.name;
  end$
DELIMITER ;

-- ------------------------------------------------------------------------------------ --
-- Trigger to add bookings to newTable which were affected by room type change (Task4g) --
-- ------------------------------------------------------------------------------------ --
DROP TRIGGER IF EXISTS `before_update_rooms`;
DELIMITER $
CREATE TRIGGER `before_update_rooms` BEFORE UPDATE ON `rooms`
  FOR EACH ROW
BEGIN
if (new.room_type_id != old.room_type_id)
  then
    Insert into newTable (room_nr, previous_type, new_type) values (new.room_nr, old.room_type_id, new.room_type_id);
  end if;
end;
DELIMITER ;
