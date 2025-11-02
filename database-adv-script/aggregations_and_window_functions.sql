SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    u.role,
    
    -- Count total bookings
    COUNT(b.booking_id) AS total_bookings,
    
    -- Count by status
    COUNT(CASE WHEN b.status = 'confirmed' THEN 1 END) AS confirmed_bookings,
    COUNT(CASE WHEN b.status = 'pending' THEN 1 END) AS pending_bookings,
    COUNT(CASE WHEN b.status = 'canceled' THEN 1 END) AS canceled_bookings,
    
    -- Calculate total spent (confirmed only)
    COALESCE(SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price END), 0) AS total_spent,
    
    -- Get first and last booking dates
    MIN(b.created_at) AS first_booking_date,
    MAX(b.created_at) AS last_booking_date

FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id

GROUP BY u.user_id, u.first_name, u.last_name, u.email, u.role

ORDER BY total_bookings DESC, total_spent DESC;


-- =====================================================
-- QUERY 1b: Users with at least 3 bookings (using HAVING)
-- =====================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_spent
    
FROM User u
INNER JOIN Booking b ON u.user_id = b.user_id

GROUP BY u.user_id, u.first_name, u.last_name

-- Filter groups (not individual rows)
HAVING COUNT(b.booking_id) >= 3

ORDER BY total_bookings DESC;


-- =====================================================
-- QUERY 2: Window Functions - ROW_NUMBER & RANK
-- Rank properties based on total number of bookings
-- =====================================================

-- Using CTE for clarity
WITH PropertyBookingCounts AS (
    SELECT 
        p.property_id,
        p.name AS property_name,
        p.pricepernight,
        l.city,
        l.country,
        CONCAT(u.first_name, ' ', u.last_name) AS host_name,
        
        COUNT(b.booking_id) AS total_bookings,
        COUNT(CASE WHEN b.status = 'confirmed' THEN 1 END) AS confirmed_bookings,
        COALESCE(SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price END), 0) AS total_revenue

    FROM Property p
    LEFT JOIN Booking b ON p.property_id = b.property_id
    LEFT JOIN Location l ON p.location_id = l.location_id
    LEFT JOIN User u ON p.host_id = u.user_id
    
    GROUP BY p.property_id, p.name, p.pricepernight, l.city, l.country, u.first_name, u.last_name
)

SELECT 
    property_id,
    property_name,
    city,
    country,
    host_name,
    pricepernight,
    total_bookings,
    confirmed_bookings,
    total_revenue,
    
    -- Different ranking methods
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number_rank,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS dense_rank,
    
    -- Rank by revenue
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    
    -- Rank within each city
    RANK() OVER (PARTITION BY city ORDER BY total_bookings DESC) AS city_rank

FROM PropertyBookingCounts

ORDER BY total_bookings DESC, total_revenue DESC;


-- =====================================================
-- QUERY 2b: Simple version without CTE
-- =====================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    l.city,
    COUNT(b.booking_id) AS total_bookings,
    
    -- Window functions
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_position,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS dense_rank_position

FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Location l ON p.location_id = l.location_id

GROUP BY p.property_id, p.name, l.city

ORDER BY total_bookings DESC;


-- =====================================================
-- BONUS: Top 5 Properties by Bookings in Each City
-- =====================================================

WITH RankedProperties AS (
    SELECT 
        p.property_id,
        p.name AS property_name,
        l.city,
        COUNT(b.booking_id) AS total_bookings,
        RANK() OVER (PARTITION BY l.city ORDER BY COUNT(b.booking_id) DESC) AS city_rank
        
    FROM Property p
    LEFT JOIN Booking b ON p.property_id = b.property_id
    LEFT JOIN Location l ON p.location_id = l.location_id
    
    GROUP BY p.property_id, p.name, l.city
)

SELECT 
    property_id,
    property_name,
    city,
    total_bookings,
    city_rank
    
FROM RankedProperties

-- Only show top 5 per city
WHERE city_rank <= 5

ORDER BY city, city_rank;