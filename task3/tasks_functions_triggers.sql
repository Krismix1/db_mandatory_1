--(d) a query to list the rooms that are currently unoccupied
select distinct bookings.room_number from bookings where
CURRENT_TIMESTAMP NOT BETWEEN bookings.check_in AND bookings.check_out;


--(e) a user-defined function to count how many different guests have made bookings for August
DROP FUNCTION IF EXISTS ShowCount;

CREATE FUNCTION ShowCount() RETURNS int
  BEGIN
    RETURN (SELECT COUNT(DISTINCT guestID)
    FROM bookings
    WHERE (check_in >='2019-08-01' AND check_in <='2019-08-31'));
  END

--a query to call function:
--select ShowCount();


--(f) a stored procedure to update the prices: single  +5%; double +7.5%, apartments –3%
DELIMITER //
CREATE PROCEDURE UpdateAllPrices()
  BEGIN
    UPDATE rooms SET price = price*1.05 where room_type='single';
    UPDATE rooms SET price = price*1.075 where room_type='double';
    UPDATE rooms SET price = price*0.97 where room_type='apartment';
  END //
    DELIMITER ;

-- call the procedure:
--call UpdateAllPrices();

--(g) 2 triggers to prevent cancellation of booking within less than 24 hours before the arrival date
-- 1 for UPDATE, 1 for INSERT
DELIMITER //
Create Trigger before_cancellation BEFORE UPDATE ON bookings FOR EACH ROW
  BEGIN
    IF
      CURDATE() = DATE(DATE_SUB(OLD.check_in, INTERVAL 1 DAY)) then
        SIGNAL SQLSTATE '45200' SET MESSAGE_TEXT = 'can\'t cancel within 24 hours before check in';
    END IF;
  END //
--to prove:
--drop trigger if exists before_cancellation_insert ;

DELIMITER //
Create Trigger before_cancellation_insert BEFORE INSERT ON bookings FOR EACH ROW
  BEGIN
    IF
    CURDATE() = DATE(DATE_SUB(NEW.check_in, INTERVAL 1 DAY)) then
      SIGNAL SQLSTATE '45201' SET MESSAGE_TEXT = 'can\'t cancel within 24 hours before check in';
    END IF;
  END //

--to prove:
--insert into bookings (bookingID, guestID, room_number, check_in, check_out, bookings.is_cancelled) values (1111, 9, 9, '2019-03-25 12:00:52', '2019-10-29 19:34:35', true);

