SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    l.city,
    l.country,
    
    -- Subquery in SELECT: Calculate average rating
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS average_rating,
    
    -- Subquery in SELECT: Count total reviews
    (SELECT COUNT(r.review_id) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS total_reviews

FROM Property p
JOIN Location l ON p.location_id = l.location_id

-- Subquery in WHERE: Filter properties with avg > 4.0
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)

ORDER BY average_rating DESC;


-- =====================================================
-- QUERY 2: Correlated Subquery
-- Find users who have made more than 3 bookings
-- =====================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    u.role,
    u.created_at AS member_since,
    
    -- Correlated subquery: Count bookings for each user
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS total_bookings,
    
    -- Correlated subquery: Count confirmed bookings
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id 
     AND b.status = 'confirmed') AS confirmed_bookings,
    
    -- Correlated subquery: Total amount spent
    (SELECT COALESCE(SUM(b.total_price), 0)
     FROM Booking b 
     WHERE b.user_id = u.user_id 
     AND b.status = 'confirmed') AS total_spent,
    
    -- Correlated subquery: Last booking date
    (SELECT MAX(b.created_at)
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS last_booking_date

FROM User u

-- Filter: Only users with more than 3 bookings
WHERE (
    SELECT COUNT(*) 
    FROM Booking b 
    WHERE b.user_id = u.user_id
) > 3

ORDER BY total_bookings DESC, total_spent DESC;


-- =====================================================
-- BONUS: Alternative Non-Correlated Approach
-- Same result, potentially better performance
-- =====================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings,
    SUM(CASE WHEN b.status = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_bookings,
    SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) AS total_spent,
    MAX(b.created_at) AS last_booking_date

FROM User u
INNER JOIN Booking b ON u.user_id = b.user_id

GROUP BY u.user_id, u.first_name, u.last_name, u.email, u.role

HAVING COUNT(b.booking_id) > 3

ORDER BY total_bookings DESC;