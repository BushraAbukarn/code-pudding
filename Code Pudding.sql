SElECT * FROM airline_booking.customer_booking;

# Descriptive Statistics 
SElECT ROUND(MIN(flight_duration),1), ROUND(AVG(flight_duration),1) , ROUND(MAX(flight_duration),1) FROM airline_booking.customer_booking; 

#Create new coulmn fligth_length 
SELECT *, 
CASE 
WHEN flight_duration < 6 THEN 'short'
WHEN flight_duration BETWEEN 6 AND 7 THEN 'medium' 
ELSE 'long'
END AS flight_length 
FROM airline_booking.customer_booking;

#Add the column to the tabel 
ALTER TABLE airline_booking.customer_booking
ADD flight_length VARCHAR(10);

#Update the coulmn 
SET SQL_SAFE_UPDATES = 0;
UPDATE airline_booking.customer_booking
SET flight_length = CASE 
    WHEN flight_duration < 6 THEN 'short'
    WHEN flight_duration BETWEEN 6 AND 7 THEN 'medium'
    ELSE 'long'
END;
SET SQL_SAFE_UPDATES = 1;

SELECT flight_length, AVG(wants_preferred_seat) FROM airline_booking.customer_booking
GROUP BY flight_length;

SELECT flight_length, AVG(wants_in_flight_meals) FROM airline_booking.customer_booking
GROUP BY flight_length
ORDER BY AVG(wants_in_flight_meals);
