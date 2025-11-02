SELECT 
    b.booking_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    u.phone_number,
    b.start_date,
    b.end_date,
    DATEDIFF(b.end_date, b.start_date) AS nights,
    b.total_price,
    b.status,
    b.created_at AS booking_date
    
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id

ORDER BY b.created_at DESC;

SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    l.city,
    l.country,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name

FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
LEFT JOIN Location l ON p.location_id = l.location_id
LEFT JOIN User u ON r.user_id = u.user_id

ORDER BY p.property_id, r.created_at DESC;

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    u.role,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN u.user_id IS NULL THEN 'Orphaned Booking'
        WHEN b.booking_id IS NULL THEN 'No Bookings'
        ELSE 'Valid Record'
    END AS record_status

FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    u.role,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN u.user_id IS NULL THEN 'Orphaned Booking'
        WHEN b.booking_id IS NULL THEN 'No Bookings'
        ELSE 'Valid Record'
    END AS record_status

FROM User u
RIGHT JOIN Booking b ON u.user_id = b.user_id
WHERE u.user_id IS NULL

ORDER BY record_status, user_name;
