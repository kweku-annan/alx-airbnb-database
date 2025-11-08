SELECT 
    property_id,
    property_name,
    location
FROM 
    properties
WHERE 
    property_id IN (
        SELECT 
            property_id
        FROM 
            reviews
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    )
ORDER BY 
    property_name ASC;


SELECT 
    u.user_id,
    u.first_name,
    u.email
FROM 
    users u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            bookings b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    u.first_name ASC;
