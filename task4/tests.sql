Use hotel;

-- --------------------------------------------- --
-- List cancelled bookings by room type (Task4f) --
-- --------------------------------------------- --
call list_cancelled_bookings();
-- Will return
-- id first_name  last_name room_type(name)
-- 5	Kamillah	  Hollyard	 FAMILY
-- 6  Pat	        Gillogley	 SINGLE



-- ---------------------------------------------------------------------------------------------------- --
-- Change room type and check whether booking id affected by the change was added to new table (Task4g) --
-- ---------------------------------------------------------------------------------------------------- --
update rooms set room_type_id=1 where room_nr = 200;

Select bookings.id from newTable join bookings on room_nr_id = room_nr;

-- Will return booking.id = 2

-- ------------------------------------------------ --
-- Test if we can add overlapping bookings (Task4c) --
-- ------------------------------------------------ --

insert into bookings (room_nr_id, date_from, date_to, booking_status_id, customer_id) values (200, '2019-09-11', '2019-09-12', 3, 6);

-- Will return error "Customer has an overlapping booking" , as customer with the id 6 has already a booking from '2019-09-10', '2019-09-13',

-- -------------------------------------- --
-- Make sure from date is not in the past --
-- -------------------------------------- --

insert into bookings (room_nr_id, date_from, date_to, booking_status_id, customer_id) values (200, '2019-03-11', '2019-09-01', 3, 6);

-- Will return error "From date is in the past"

-- ---------------------------------------------- --
-- Make sure that to date is later than from date --
-- ---------------------------------------------- --

insert into bookings (room_nr_id, date_from, date_to, booking_status_id, customer_id) values (200, '2019-05-11', '2019-05-10', 3, 6);

-- Will return error "To date earlier than from date"

-- ---------------------------------------------------------------- --
-- Query to find all guests currently staying at the hotel (Task4d) --
-- ---------------------------------------------------------------- --

Select* from customers where id IN (SELECT customer_id from bookings where booking_status_id=1);

-- Will return:
-- id   first_name  last_name
-- 4	  Ravi	      Pontain
-- 9	  Erhart	    Smittoune

-- ---------------------------------------------------- --
-- Function to print out most booked room type (Task4e) --
-- ---------------------------------------------------- --

SELECT most_booked_room_type();

-- Will return SINGLE
