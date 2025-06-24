#View All Customer Booking Records
SELECT 
    *
FROM
    airline_booking.customer_booking;

#Summary Statistics for Flight Duration (Min, Avg, Max)
SELECT 
    ROUND(MIN(flight_duration), 1),
    ROUND(AVG(flight_duration), 1),
    ROUND(MAX(flight_duration), 1)
FROM
    airline_booking.customer_booking;

#Categorize Flight Duration into Length Types (Short, Medium, Long)
SELECT 
    *,
    CASE
        WHEN flight_duration < 6 THEN 'short'
        WHEN flight_duration BETWEEN 6 AND 7 THEN 'medium'
        ELSE 'long'
    END AS flight_length
FROM
    airline_booking.customer_booking;

#Add New Column flight_length to Table
ALTER TABLE airline_booking.customer_booking
ADD flight_length VARCHAR(10);

#Update flight_length Values Based on flight_duration
SET SQL_SAFE_UPDATES = 0;
UPDATE airline_booking.customer_booking 
SET 
    flight_length = CASE
        WHEN flight_duration < 6 THEN 'short'
        WHEN flight_duration BETWEEN 6 AND 7 THEN 'medium'
        ELSE 'long'
    END;
SET SQL_SAFE_UPDATES = 1;

#Average In-Flight Meal Requests and Preferred Seat Requests by Flight Length (Sorted Ascending)
SELECT 
    flight_length,
    AVG(wants_preferred_seat),
    AVG(wants_in_flight_meals)
FROM
    airline_booking.customer_booking
GROUP BY flight_length
ORDER BY AVG(wants_preferred_seat);
