-- Assuming the data from `mockdata.sql` was inserted:



--(f) a stored procedure to update the prices: single  +5%; double +7.5%, apartments –3%
UPDATE rooms SET price = price*1.05 where room_type='single';
UPDATE rooms SET price = price*1.075 where room_type='double';
UPDATE rooms SET price = price*0.97 where room_type='apartment';
--these queries will update the prices accordingly


-- Assuming that triggers in tasks_functions_triggers were created:
--(g) 2 triggers to prevent cancellation of booking within less than 24 hours before the arrival date

update bookings set is_cancelled=true where bookingID=9014;--will throw an "45200 can't cancel within 24 hours before check in"

insert into bookings (bookingID, guestID, room_number, check_in, check_out, bookings.is_cancelled)
values (1111, 9, 9, '2019-03-25 12:00:52', '2019-10-29 19:34:35', true); --will throw an "45201 can't cancel within 24 hours before check in"
