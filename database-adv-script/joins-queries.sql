SELECT 
    users.user_id,
    users.first_name,
    users.email,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
INNER JOIN 
    bookings
ON 
    users.user_id = bookings.user_id;


SELECT 
    properties.property_id,
    properties.property_name,
    properties.location,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM 
    properties
LEFT JOIN 
    reviews
ON 
    properties.property_id = reviews.property_id;


SELECT 
    users.user_id,
    users.first_name,
    users.email,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
FULL OUTER JOIN 
    bookings
ON 
    users.user_id = bookings.user_id;
