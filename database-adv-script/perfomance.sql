SELECT
    b.booking_id,
    b.property_id,
    b.user_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,
    u.user_id AS user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email,
    p.property_id AS property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.pricepernight AS property_pricepernight,
    pay.payment_id AS payment_id,
    pay.amount AS payment_amount,
    pay.payment_date AS payment_date,
    pay.payment_method AS payment_method
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
ORDER BY b.created_at DESC;