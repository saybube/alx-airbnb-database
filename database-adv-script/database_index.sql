-- =====================================================
-- AirBnB Database - Performance Indexes
-- File: database_index.sql
-- =====================================================

-- =====================================================
-- NOTE: Primary Keys and Foreign Keys
-- =====================================================
-- Primary keys (PK) are automatically indexed by the database.
-- We focus on additional indexes for query optimization.

-- =====================================================
-- USER TABLE INDEXES
-- =====================================================

-- Index on email (UNIQUE) - Used in login, registration checks
-- This is likely already created via UNIQUE constraint, but explicitly defining it
CREATE UNIQUE INDEX idx_user_email ON User(email);

-- Index on role - Filter users by role (guest, host, admin)
CREATE INDEX idx_user_role ON User(role);

-- Index on created_at - Sort/filter users by registration date
CREATE INDEX idx_user_created_at ON User(created_at);

-- Composite index for email verification lookups
CREATE INDEX idx_user_verification ON User(email_verification_token) 
WHERE email_verification_token IS NOT NULL;


-- =====================================================
-- LOCATION TABLE INDEXES
-- =====================================================

-- Index on city - Search properties by city
CREATE INDEX idx_location_city ON Location(city);

-- Index on country - Search properties by country
CREATE INDEX idx_location_country ON Location(country);

-- Composite index on (city, country) - Most common search pattern
CREATE INDEX idx_location_city_country ON Location(city, country);

-- Index on postal_code - Search by zip code
CREATE INDEX idx_location_postal_code ON Location(postal_code);

-- Geospatial index for latitude/longitude proximity searches
CREATE INDEX idx_location_coordinates ON Location(latitude, longitude);


-- =====================================================
-- PROPERTY TABLE INDEXES
-- =====================================================

-- Index on host_id - Find all properties by a host (already created as FK)
CREATE INDEX idx_property_host ON Property(host_id);

-- Index on location_id - Join with Location table (already created as FK)
CREATE INDEX idx_property_location ON Property(location_id);

-- Index on pricepernight - Price range searches
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Index on created_at - Sort by newest properties
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Index on updated_at - Find recently modified properties
CREATE INDEX idx_property_updated_at ON Property(updated_at);

-- Composite index for price range + location searches
CREATE INDEX idx_property_price_location ON Property(pricepernight, location_id);

-- Full-text index for property name and description searches
CREATE FULLTEXT INDEX idx_property_search ON Property(name, description);


-- =====================================================
-- BOOKING TABLE INDEXES
-- =====================================================

-- Index on user_id - Find bookings by user (already created as FK)
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Index on property_id - Find bookings by property (already created as FK)
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index on status - Filter by booking status
CREATE INDEX idx_booking_status ON Booking(status);

-- Index on start_date - Date range queries
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on end_date - Date range queries
CREATE INDEX idx_booking_end_date ON Booking(end_date);

-- Index on created_at - Sort by booking date
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- CRITICAL: Composite index for availability checks
-- This is the most important index for booking performance!
CREATE INDEX idx_booking_availability ON Booking(property_id, start_date, end_date, status);

-- Composite index for user's booking history
CREATE INDEX idx_booking_user_status ON Booking(user_id, status, created_at);

-- Composite index for property bookings timeline
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, status);


-- =====================================================
-- PAYMENT TABLE INDEXES
-- =====================================================

-- Index on booking_id - Find payments for a booking (already created as FK)
CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- Index on payment_date - Sort by payment date
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Index on payment_method - Filter by payment type
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Index on status - Filter by payment status
CREATE INDEX idx_payment_status ON Payment(status);

-- Index on transaction_id - Lookup by external transaction reference
CREATE UNIQUE INDEX idx_payment_transaction ON Payment(transaction_id) 
WHERE transaction_id IS NOT NULL;


-- =====================================================
-- REVIEW TABLE INDEXES
-- =====================================================

-- Index on property_id - Find reviews for a property (already created as FK)
CREATE INDEX idx_review_property ON Review(property_id);

-- Index on user_id - Find reviews by user (already created as FK)
CREATE INDEX idx_review_user ON Review(user_id);

-- Index on rating - Filter/sort by rating
CREATE INDEX idx_review_rating ON Review(rating);

-- Index on created_at - Sort by review date
CREATE INDEX idx_review_created_at ON Review(created_at);

-- Composite index for property reviews sorted by date
CREATE INDEX idx_review_property_date ON Review(property_id, created_at DESC);

-- Composite index for calculating average rating
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Full-text index for searching review comments
CREATE FULLTEXT INDEX idx_review_comment_search ON Review(comment);


-- =====================================================
-- MESSAGE TABLE INDEXES
-- =====================================================

-- Index on sender_id - Find sent messages (already created as FK)
CREATE INDEX idx_message_sender ON Message(sender_id);

-- Index on recipient_id - Find received messages (already created as FK)
CREATE INDEX idx_message_recipient ON Message(recipient_id);

-- Index on sent_at - Sort messages by date
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- Index on is_read - Filter unread messages
CREATE INDEX idx_message_is_read ON Message(is_read);

-- CRITICAL: Composite index for inbox queries
CREATE INDEX idx_message_inbox ON Message(recipient_id, is_read, sent_at DESC);

-- Composite index for conversation threads
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);


-- =====================================================
-- AMENITY TABLE INDEXES
-- =====================================================

-- Index on name (UNIQUE) - Lookup amenities by name
CREATE UNIQUE INDEX idx_amenity_name ON Amenity(name);

-- Index on category - Filter amenities by category
CREATE INDEX idx_amenity_category ON Amenity(category);


-- =====================================================
-- PROPERTYAMENITY TABLE INDEXES
-- =====================================================

-- Composite primary key already creates indexes, but we add specific ones:

-- Index on property_id - Find amenities for a property
CREATE INDEX idx_propertyamenity_property ON PropertyAmenity(property_id);

-- Index on amenity_id - Find properties with specific amenity
CREATE INDEX idx_propertyamenity_amenity ON PropertyAmenity(amenity_id);


-- =====================================================
-- BOOKINGPRICEBREAKDOWN TABLE INDEXES
-- =====================================================

-- Index on booking_id - Find price breakdown for a booking (already created as FK)
CREATE INDEX idx_breakdown_booking ON BookingPriceBreakdown(booking_id);

-- Index on item_type - Filter by breakdown type
CREATE INDEX idx_breakdown_item_type ON BookingPriceBreakdown(item_type);


-- =====================================================
-- REVIEWRESPONSE TABLE INDEXES
-- =====================================================

-- Index on review_id (UNIQUE) - One-to-one relationship
CREATE UNIQUE INDEX idx_reviewresponse_review ON ReviewResponse(review_id);

-- Index on host_id - Find responses by host (already created as FK)
CREATE INDEX idx_reviewresponse_host ON ReviewResponse(host_id);

-- Index on created_at - Sort by response date
CREATE INDEX idx_reviewresponse_created_at ON ReviewResponse(created_at);


-- =====================================================
-- VERIFICATION AND MAINTENANCE QUERIES
-- =====================================================

-- View all indexes in the database (MySQL/PostgreSQL syntax varies)
-- For MySQL:
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'airbnb_db'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;

-- For PostgreSQL:
-- SELECT tablename, indexname, indexdef 
-- FROM pg_indexes 
-- WHERE schemaname = 'public'
-- ORDER BY tablename, indexname;




-- Test Query 1: Find user by email (login query)
EXPLAIN ANALYZE
SELECT * FROM User WHERE email = 'sarah.davis@email.com';

-- Expected BEFORE index: 
-- - Type: ALL (full table scan)
-- - Rows examined: ~15 (all users)
-- - Time: ~0.5-2ms


-- Test Query 2: Property search by city and price range
EXPLAIN ANALYZE
SELECT p.*, l.city, l.country
FROM Property p
JOIN Location l ON p.location_id = l.location_id
WHERE l.city = 'Miami' 
  AND p.pricepernight BETWEEN 200 AND 500;

-- Expected BEFORE index:
-- - Type: ALL (full table scan on both tables)
-- - Rows examined: ~12 properties + ~12 locations
-- - Time: ~2-5ms


-- Test Query 3: Check booking availability (CRITICAL query)
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = '750e8400-e29b-41d4-a716-446655440001'
  AND status IN ('confirmed', 'pending')
  AND (
    (start_date BETWEEN '2024-12-01' AND '2024-12-07') OR
    (end_date BETWEEN '2024-12-01' AND '2024-12-07') OR
    (start_date <= '2024-12-01' AND end_date >= '2024-12-07')
  );

-- Expected BEFORE index:
-- - Type: ALL (full table scan)
-- - Rows examined: ~15 (all bookings)
-- - Time: ~3-8ms


-- Test Query 4: User's booking history
EXPLAIN ANALYZE
SELECT 
    b.*,
    p.name AS property_name,
    l.city
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN Location l ON p.location_id = l.location_id
WHERE b.user_id = '550e8400-e29b-41d4-a716-446655440007'
  AND b.status = 'confirmed'
ORDER BY b.created_at DESC;

-- Expected BEFORE index:
-- - Type: ALL on all tables
-- - Rows examined: ~15 bookings + ~12 properties + ~12 locations
-- - Time: ~5-10ms


-- Test Query 5: Property reviews with ratings
EXPLAIN ANALYZE
SELECT 
    r.*,
    u.first_name,
    u.last_name
FROM Review r
JOIN User u ON r.user_id = u.user_id
WHERE r.property_id = '750e8400-e29b-41d4-a716-446655440001'
  AND r.rating >= 4
ORDER BY r.created_at DESC;

-- Expected BEFORE index:
-- - Type: ALL
-- - Rows examined: ~10 reviews + ~15 users
-- - Time: ~3-7ms


-- Test Query 6: Message inbox (unread messages)
EXPLAIN ANALYZE
SELECT 
    m.*,
    CONCAT(u.first_name, ' ', u.last_name) AS sender_name
FROM Message m
JOIN User u ON m.sender_id = u.user_id
WHERE m.recipient_id = '550e8400-e29b-41d4-a716-446655440007'
  AND m.is_read = FALSE
ORDER BY m.sent_at DESC
LIMIT 20;

-- Expected BEFORE index:
-- - Type: ALL
-- - Rows examined: All messages
-- - Time: ~4-8ms


-- =====================================================
-- STEP 2: ADD INDEXES
-- (Run the database_index.sql script here)
-- =====================================================

-- After running database_index.sql, proceed to Step 3


-- =====================================================
-- STEP 3: Performance Test AFTER Indexes
-- =====================================================

-- Test Query 1 AFTER: Find user by email
EXPLAIN ANALYZE
SELECT * FROM User WHERE email = 'sarah.davis@email.com';

-- Expected AFTER index:
-- - Type: ref or const (index lookup)
-- - Rows examined: 1 (direct index hit)
-- - Time: ~0.1-0.5ms
-- - Improvement: 80-90% faster ⚡


-- Test Query 2 AFTER: Property search by city and price
EXPLAIN ANALYZE
SELECT p.*, l.city, l.country
FROM Property p
JOIN Location l ON p.location_id = l.location_id
WHERE l.city = 'Miami' 
  AND p.pricepernight BETWEEN 200 AND 500;

-- Expected AFTER index:
-- - Type: ref (index lookup on city)
-- - Type: range (index range scan on price)
-- - Rows examined: ~2-3 (only matching rows)
-- - Time: ~0.5-2ms
-- - Improvement: 60-70% faster ⚡


-- Test Query 3 AFTER: Booking availability check
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = '750e8400-e29b-41d4-a716-446655440001'
  AND status IN ('confirmed', 'pending')
  AND (
    (start_date BETWEEN '2024-12-01' AND '2024-12-07') OR
    (end_date BETWEEN '2024-12-01' AND '2024-12-07') OR
    (start_date <= '2024-12-01' AND end_date >= '2024-12-07')
  );

-- Expected AFTER index:
-- - Type: range (composite index on property_id, dates, status)
-- - Rows examined: ~2-3 (only relevant bookings)
-- - Time: ~0.3-1ms
-- - Improvement: 85-95% faster ⚡⚡⚡ (HUGE improvement!)


-- Test Query 4 AFTER: User's booking history
EXPLAIN ANALYZE
SELECT 
    b.*,
    p.name AS property_name,
    l.city
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN Location l ON p.location_id = l.location_id
WHERE b.user_id = '550e8400-e29b-41d4-a716-446655440007'
  AND b.status = 'confirmed'
ORDER BY b.created_at DESC;

-- Expected AFTER index:
-- - Type: ref (index on user_id, status)
-- - Rows examined: ~3-5 (user's bookings only)
-- - Time: ~1-3ms
-- - Improvement: 70-80% faster ⚡


-- Test Query 5 AFTER: Property reviews
EXPLAIN ANALYZE
SELECT 
    r.*,
    u.first_name,
    u.last_name
FROM Review r
JOIN User u ON r.user_id = u.user_id
WHERE r.property_id = '750e8400-e29b-41d4-a716-446655440001'
  AND r.rating >= 4
ORDER BY r.created_at DESC;

-- Expected AFTER index:
-- - Type: ref (index on property_id, rating)
-- - Rows examined: ~2-4 (property's high-rated reviews)
-- - Time: ~0.5-2ms
-- - Improvement: 75-85% faster ⚡


-- Test Query 6 AFTER: Message inbox
EXPLAIN ANALYZE
SELECT 
    m.*,
    CONCAT(u.first_name, ' ', u.last_name) AS sender_name
FROM Message m
JOIN User u ON m.sender_id = u.user_id
WHERE m.recipient_id = '550e8400-e29b-41d4-a716-446655440007'
  AND m.is_read = FALSE
ORDER BY m.sent_at DESC
LIMIT 20;

-- Expected AFTER index:
-- - Type: ref (composite index on recipient_id, is_read, sent_at)
-- - Rows examined: ~5-10 (user's unread messages)
-- - Time: ~0.5-1.5ms
-- - Improvement: 80-90% faster ⚡


-- =====================================================
-- STEP 4: Compare Results
-- =====================================================

-- Performance Improvement Summary:
-- Query 1 (Login): 80-90% faster
-- Query 2 (Property Search): 60-70% faster
-- Query 3 (Availability Check): 85-95% faster ⭐ CRITICAL
-- Query 4 (Booking History): 70-80% faster
-- Query 5 (Reviews): 75-85% faster
-- Query 6 (Inbox): 80-90% faster


-- =====================================================
-- UNDERSTANDING EXPLAIN OUTPUT
-- =====================================================

/*
EXPLAIN ANALYZE shows:

1. **type**: How MySQL accesses rows
   - ALL: Full table scan (SLOWEST) 🐌
   - index: Full index scan
   - range: Index range scan (WHERE BETWEEN, IN)
   - ref: Index lookup (WHERE =)
   - const: Single row lookup (PRIMARY KEY) (FASTEST) ⚡

2. **rows**: Estimated rows examined
   - Lower is better
   - BEFORE index: Often examines ALL rows
   - AFTER index: Only examines matching rows

3. **Extra**: Additional information
   - "Using where": Filtering after retrieval
   - "Using index": Query satisfied entirely from index (best!)
   - "Using filesort": Expensive sorting operation
   - "Using temporary": Creates temp table (slow)

4. **Execution time**: Actual query duration
   - Measured in milliseconds (ms)
   - AFTER indexes: Should be significantly lower
*/


-- =====================================================
-- STEP 5: Monitor Index Usage
-- =====================================================

-- Check which indexes are being used (MySQL)
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX,
    COLUMN_NAME
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'airbnb_db'
  AND INDEX_NAME != 'PRIMARY'
ORDER BY TABLE_NAME, INDEX_NAME;


-- Find unused indexes (requires sys schema - MySQL 5.7+)
-- SELECT 
--     object_schema AS database_name,
--     object_name AS table_name,
--     index_name
-- FROM sys.schema_unused_indexes
-- WHERE object_schema = 'airbnb_db';


-- =====================================================
-- STEP 6: Index Maintenance Queries
-- =====================================================

-- Analyze table statistics (helps optimizer choose best index)
ANALYZE TABLE User;
ANALYZE TABLE Property;
ANALYZE TABLE Booking;
ANALYZE TABLE Review;
ANALYZE TABLE Message;

-- Check index cardinality (uniqueness of values)
SHOW INDEX FROM Booking;

-- Rebuild/optimize tables and indexes
OPTIMIZE TABLE Booking;