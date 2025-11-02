SELECT
    b.booking_id,
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
    p.pricepernight AS property_pricepernight,
    pay_summary.total_paid,
    pay_summary.payments_count,
    pay_summary.last_payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN (
    SELECT
        booking_id,
        SUM(amount) AS total_paid,
        COUNT(*) AS payments_count,
        MAX(payment_date) AS last_payment_date
    FROM Payment
    GROUP BY booking_id
) pay_summary ON pay_summary.booking_id = b.booking_id
ORDER BY b.created_at DESC;