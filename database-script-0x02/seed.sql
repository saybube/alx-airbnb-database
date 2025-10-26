-- =====================================================
-- AirBnB Database - Sample Data Population Script
-- Realistic test data for development and testing
-- =====================================================

-- Disable foreign key checks temporarily for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- SAMPLE DATA: USERS
-- =====================================================

-- Insert sample users (guests, hosts, and admin)
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
('550e8400-e29b-41d4-a716-446655440001', 'Alice', 'Johnson', 'alice.admin@airbnb.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0101', 'admin', '2023-01-15 10:00:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440002', 'Robert', 'Martinez', 'robert.host@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0102', 'host', '2023-02-10 14:30:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0103', 'host', '2023-03-05 09:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'James', 'Wilson', 'james.wilson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0104', 'host', '2023-03-20 16:45:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Linda', 'Brown', 'linda.brown@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44-20-7946-0105', 'host', '2023-04-12 11:20:00'),
('550e8400-e29b-41d4-a716-446655440006', 'David', 'Lee', 'david.lee@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0106', 'host', '2023-05-08 13:00:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440007', 'Sarah', 'Davis', 'sarah.davis@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0107', 'guest', '2023-06-01 08:30:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Michael', 'Taylor', 'michael.taylor@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0108', 'guest', '2023-06-15 10:45:00'),
('550e8400-e29b-41d4-a716-446655440009', 'Emily', 'Anderson', 'emily.anderson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0109', 'guest', '2023-07-03 15:20:00'),
('550e8400-e29b-41d4-a716-446655440010', 'John', 'Thomas', 'john.thomas@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0110', 'guest', '2023-07-20 12:00:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Jessica', 'Moore', 'jessica.moore@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0111', 'guest', '2023-08-05 09:30:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Daniel', 'Jackson', 'daniel.jackson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0112', 'guest', '2023-08-18 14:15:00'),
('550e8400-e29b-41d4-a716-446655440013', 'Amanda', 'White', 'amanda.white@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+44-20-7946-0113', 'guest', '2023-09-02 11:00:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Christopher', 'Harris', 'chris.harris@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0114', 'guest', '2023-09-15 16:30:00'),
('550e8400-e29b-41d4-a716-446655440015', 'Jennifer', 'Martin', 'jennifer.martin@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1-555-0115', 'guest', '2023-10-01 10:20:00');

-- =====================================================
-- SAMPLE DATA: LOCATIONS
-- =====================================================

INSERT INTO Location (location_id, street_address, city, state_province, country, postal_code, latitude, longitude, created_at) VALUES
-- US Locations
('650e8400-e29b-41d4-a716-446655440001', '123 Ocean Drive', 'Miami', 'Florida', 'USA', '33139', 25.7617, -80.1918, '2023-02-15 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '456 Park Avenue', 'New York', 'New York', 'USA', '10022', 40.7614, -73.9776, '2023-03-10 11:30:00'),
('650e8400-e29b-41d4-a716-446655440003', '789 Hollywood Blvd', 'Los Angeles', 'California', 'USA', '90028', 34.0928, -118.3287, '2023-03-25 14:00:00'),
('650e8400-e29b-41d4-a716-446655440004', '321 Market Street', 'San Francisco', 'California', 'USA', '94102', 37.7749, -122.4194, '2023-04-05 09:45:00'),
('650e8400-e29b-41d4-a716-446655440005', '555 Lake Shore Drive', 'Chicago', 'Illinois', 'USA', '60611', 41.8781, -87.6298, '2023-04-20 15:20:00'),

-- International Locations
('650e8400-e29b-41d4-a716-446655440006', '10 Downing Street Area', 'London', 'England', 'UK', 'SW1A 2AA', 51.5074, -0.1278, '2023-05-01 12:00:00'),
('650e8400-e29b-41d4-a716-446655440007', '88 Rue de Rivoli', 'Paris', 'Île-de-France', 'France', '75004', 48.8566, 2.3522, '2023-05-15 10:30:00'),
('650e8400-e29b-41d4-a716-446655440008', 'Shibuya Crossing', 'Tokyo', 'Tokyo', 'Japan', '150-0002', 35.6762, 139.6503, '2023-06-01 13:45:00'),
('650e8400-e29b-41d4-a716-446655440009', 'Bondi Beach Road', 'Sydney', 'New South Wales', 'Australia', '2026', -33.8688, 151.2093, '2023-06-20 11:15:00'),
('650e8400-e29b-41d4-a716-446655440010', 'Paseo de la Reforma', 'Mexico City', 'CDMX', 'Mexico', '06600', 19.4326, -99.1332, '2023-07-05 14:30:00'),

-- More US Locations
('650e8400-e29b-41d4-a716-446655440011', '200 Congress Avenue', 'Austin', 'Texas', 'USA', '78701', 30.2672, -97.7431, '2023-07-20 09:00:00'),
('650e8400-e29b-41d4-a716-446655440012', '1500 Peachtree Street', 'Atlanta', 'Georgia', 'USA', '30309', 33.7490, -84.3880, '2023-08-10 16:00:00');

-- =====================================================
-- SAMPLE DATA: PROPERTIES
-- =====================================================

INSERT INTO Property (property_id, host_id, location_id, name, description, pricepernight, created_at, updated_at) VALUES
-- Robert's Properties
('750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 
 'Luxury Beachfront Condo', 
 'Experience the ultimate Miami lifestyle in this stunning beachfront condo. Floor-to-ceiling windows offer breathtaking ocean views, while the modern interior design provides both comfort and elegance. Walking distance to South Beach restaurants and nightlife.',
 350.00, '2023-02-20 10:00:00', '2024-01-15 14:30:00'),

('750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440005',
 'Cozy Downtown Chicago Loft',
 'Perfect for business travelers and couples, this industrial-chic loft combines historic charm with modern amenities. Exposed brick walls, high ceilings, and large windows create a unique urban retreat in the heart of Chicago.',
 225.00, '2023-04-25 11:00:00', '2024-02-10 09:15:00'),

-- Maria's Properties
('750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002',
 'Manhattan Skyline Apartment',
 'Wake up to stunning views of the Manhattan skyline from this elegant apartment in Midtown. Recently renovated with high-end finishes, this space offers luxury living steps away from Central Park, Times Square, and world-class dining.',
 450.00, '2023-03-15 14:30:00', '2024-01-20 16:45:00'),

('750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440007',
 'Parisian Charm Studio',
 'Experience authentic Parisian living in this charming studio near the Louvre. Original hardwood floors, a classic French balcony, and period details create a romantic atmosphere perfect for exploring the City of Light.',
 180.00, '2023-05-20 09:00:00', '2023-12-05 10:30:00'),

-- James's Properties
('750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440003',
 'Hollywood Hills Villa',
 'This stunning villa offers the quintessential LA experience with panoramic city views, an infinity pool, and modern architecture. Perfect for entertaining or relaxing in style, with easy access to Hollywood attractions and Beverly Hills shopping.',
 800.00, '2023-04-10 15:30:00', '2024-02-28 11:00:00'),

('750e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004',
 'San Francisco Bay View',
 'Contemporary townhouse with spectacular views of the San Francisco Bay and Golden Gate Bridge. This tech-friendly space features smart home automation, a gourmet kitchen, and is walking distance to the Ferry Building and financial district.',
 380.00, '2023-04-15 12:45:00', '2024-01-10 15:20:00'),

-- Linda's Properties
('750e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440006',
 'Historic London Townhouse',
 'Step into British elegance in this beautifully restored Victorian townhouse in central London. Original features blend seamlessly with modern comforts. Minutes from the Underground, perfect for exploring museums, theaters, and royal landmarks.',
 320.00, '2023-05-10 10:15:00', '2023-11-30 14:00:00'),

('750e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440009',
 'Bondi Beach Retreat',
 'Live the Australian beach lifestyle in this bright, airy apartment just steps from iconic Bondi Beach. Enjoy morning surf sessions, coastal walks, and vibrant café culture. The perfect base for exploring Sydney\'s beaches and harbor.',
 280.00, '2023-06-25 13:30:00', '2024-03-01 10:45:00'),

-- David's Properties
('750e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440008',
 'Tokyo Modern Studio',
 'Experience the energy of Tokyo in this sleek, minimalist studio in Shibuya. Ultra-modern design meets Japanese aesthetics, with high-tech amenities and access to Tokyo\'s best shopping, dining, and entertainment districts.',
 200.00, '2023-06-05 11:00:00', '2024-02-15 09:30:00'),

('750e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440010',
 'Mexico City Boutique Loft',
 'Discover the vibrant culture of Mexico City from this artistically designed loft in the trendy Roma neighborhood. Original artwork, colorful décor, and a rooftop terrace make this a unique home base for urban exploration.',
 150.00, '2023-07-10 14:00:00', '2024-01-05 11:15:00'),

-- Additional Properties
('750e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440011',
 'Austin Music District Condo',
 'Live like a local in Austin\'s live music capital. This modern condo puts you in the heart of downtown, walking distance to 6th Street clubs, BBQ joints, and the iconic Texas State Capitol. Perfect for SXSW and ACL festival-goers.',
 195.00, '2023-07-25 10:30:00', '2023-12-20 15:45:00'),

('750e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440012',
 'Atlanta Midtown Apartment',
 'Modern apartment in the heart of Midtown Atlanta, close to Piedmont Park, the BeltLine, and cultural attractions. Ideal for business travelers with nearby access to major corporations and conference centers.',
 175.00, '2023-08-15 12:00:00', '2024-02-05 13:30:00');

-- =====================================================
-- SAMPLE DATA: PROPERTY AMENITIES
-- =====================================================

-- Get amenity IDs (we'll use the ones we know exist)
-- WiFi, Kitchen, Air conditioning, TV, Pool, Hot tub, Free parking, Workspace, Smoke alarm, Fire extinguisher

-- Luxury Beachfront Condo (Miami) - Full amenities
INSERT INTO PropertyAmenity (property_id, amenity_id) 
SELECT '750e8400-e29b-41d4-a716-446655440001', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Pool', 'Free parking', 'Workspace', 'Smoke alarm', 'Fire extinguisher', 'First aid kit');

-- Manhattan Skyline Apartment - Urban amenities
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440003', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'Heating', 'TV', 'Washer', 'Dryer', 'Workspace', 'Smoke alarm', 'Fire extinguisher');

-- Hollywood Hills Villa - Luxury amenities
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440005', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Pool', 'Hot tub', 'Gym', 'Free parking', 'Workspace', 'Smoke alarm', 'Fire extinguisher', 'First aid kit');

-- San Francisco Bay View - Tech-friendly
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440006', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'Heating', 'TV', 'Washer', 'Workspace', 'EV charger', 'Smoke alarm', 'Fire extinguisher');

-- Cozy Chicago Loft - Essential amenities
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440002', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Heating', 'TV', 'Washer', 'Workspace', 'Smoke alarm', 'Fire extinguisher');

-- Parisian Charm Studio - Basic European
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440004', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Heating', 'TV', 'Washer', 'Smoke alarm');

-- Historic London Townhouse - Classic amenities
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440007', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Heating', 'TV', 'Washer', 'Dryer', 'Free parking', 'Workspace', 'Smoke alarm', 'Fire extinguisher');

-- Bondi Beach Retreat - Beach lifestyle
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440008', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Washer', 'Free parking', 'Workspace', 'Smoke alarm');

-- Tokyo Modern Studio - Minimalist
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440009', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Washer', 'Workspace', 'Smoke alarm');

-- Mexico City Boutique Loft - Artistic
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440010', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'TV', 'Washer', 'Workspace', 'Smoke alarm', 'Fire extinguisher');

-- Austin Music District Condo - Modern
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440011', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Washer', 'Free parking', 'Workspace', 'Smoke alarm');

-- Atlanta Midtown Apartment - Business-friendly
INSERT INTO PropertyAmenity (property_id, amenity_id)
SELECT '750e8400-e29b-41d4-a716-446655440012', amenity_id FROM Amenity WHERE name IN ('WiFi', 'Kitchen', 'Air conditioning', 'TV', 'Gym', 'Free parking', 'Workspace', 'Smoke alarm', 'Fire extinguisher');

-- =====================================================
-- SAMPLE DATA: BOOKINGS
-- =====================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at, updated_at) VALUES
-- Confirmed bookings (past and current)
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 
 '2024-01-15', '2024-01-22', 2450.00, 'confirmed', '2023-12-10 14:30:00', '2023-12-10 14:30:00'),

('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008',
 '2024-02-01', '2024-02-05', 1800.00, 'confirmed', '2024-01-05 10:15:00', '2024-01-05 10:15:00'),

('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440009',
 '2024-02-14', '2024-02-21', 5600.00, 'confirmed', '2024-01-20 16:45:00', '2024-01-20 16:45:00'),

('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440010',
 '2024-03-10', '2024-03-17', 2240.00, 'confirmed', '2024-02-15 11:30:00', '2024-02-15 11:30:00'),

('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011',
 '2024-03-20', '2024-03-25', 1125.00, 'confirmed', '2024-02-28 09:00:00', '2024-02-28 09:00:00'),

-- Future bookings (pending and confirmed)
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440012',
 '2024-11-05', '2024-11-12', 2660.00, 'confirmed', '2024-10-01 14:20:00', '2024-10-02 10:30:00'),

('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440013',
 '2024-12-20', '2024-12-27', 1960.00, 'confirmed', '2024-10-15 11:45:00', '2024-10-15 11:45:00'),

('850e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440014',
 '2024-11-15', '2024-11-20', 1000.00, 'pending', '2024-10-20 15:30:00', '2024-10-20 15:30:00'),

('850e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440015',
 '2024-12-01', '2024-12-08', 1050.00, 'pending', '2024-10-22 10:00:00', '2024-10-22 10:00:00'),

-- Canceled bookings
('850e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440007',
 '2024-04-10', '2024-04-15', 900.00, 'canceled', '2024-03-01 12:00:00', '2024-03-15 09:30:00'),

-- Additional past bookings for review data
('850e8400-e29b-41d4-a716-446655440011', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440008',
 '2024-08-01', '2024-08-05', 1400.00, 'confirmed', '2024-07-10 10:00:00', '2024-07-10 10:00:00'),

('850e8400-e29b-41d4-a716-446655440012', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012',
 '2024-09-15', '2024-09-20', 4000.00, 'confirmed', '2024-08-20 14:30:00', '2024-08-20 14:30:00'),

('850e8400-e29b-41d4-a716-446655440013', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440013',
 '2024-07-20', '2024-07-27', 3150.00, 'confirmed', '2024-06-15 11:20:00', '2024-06-15 11:20:00'),

('850e8400-e29b-41d4-a716-446655440014', '750e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440014',
 '2024-06-10', '2024-06-13', 585.00, 'confirmed', '2024-05-15 09:45:00', '2024-05-15 09:45:00'),

('850e8400-e29b-41d4-a716-446655440015', '750e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440015',
 '2024-05-20', '2024-05-25', 875.00, 'confirmed', '2024-04-25 13:15:00', '2024-04-25 13:15:00');

-- =====================================================
-- SAMPLE DATA: BOOKING PRICE BREAKDOWNS
-- =====================================================

-- Breakdown for Booking 1 (Miami Beach - 7 nights)
INSERT INTO BookingPriceBreakdown (breakdown_id, booking_id, item_type, description, amount, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001', 'base_rate', '7 nights × $350.00', 2450.00, '2023-12-10 14:30:00'),
('950e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440001', 'cleaning_fee', 'One-time cleaning fee', 150.00, '2023-12-10 14:30:00'),
('950e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440001', 'service_fee', 'AirBnB service fee', 260.00, '2023-12-10 14:30:00'),
('950e8400-e29b-41d4-a716-446655440004', '850e8400-e29b-41d4-a716-446655440001', 'tax', 'Occupancy tax (8%)', 196.00, '2023-12-10 14:30:00'),
('950e8400-e29b-41d4-a716-446655440005', '850e8400-e29b-41d4-a716-446655440001', 'discount', 'Weekly stay discount', -206.00, '2023-12-10 14:30:00');

-- Breakdown for Booking 2 (Manhattan - 4 nights)
INSERT INTO BookingPriceBreakdown (breakdown_id, booking_id, item_type, description, amount, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440006', '850e8400-e29b-41d4-a716-446655440002', 'base_rate', '4 nights × $450.00', 1800.00, '2024-01-05 10:15:00'),
('950e8400-e29b-41d4-a716-446655440007', '850e8400-e29b-41d4-a716-446655440002', 'cleaning_fee', 'One-time cleaning fee', 125.00, '2024-01-05 10:15:00'),
('950e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440002', 'service_fee', 'AirBnB service fee', 192.50, '2024-01-05 10:15:00'),
('950e8400-e29b-41d4-a716-446655440009', '850e8400-e29b-41d4-a716-446655440002', 'tax', 'NYC hotel tax (14.75%)', 265.50, '2024-01-05 10:15:00');

-- Breakdown for Booking 3 (Hollywood Hills - 7 nights)
INSERT INTO BookingPriceBreakdown (breakdown_id, booking_id, item_type, description, amount, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440010', '850e8400-e29b-41d4-a716-446655440003', 'base_rate', '7 nights × $800.00', 5600.00, '2024-01-20 16:45:00'),
('950e8400-e29b-41d4-a716-446655440011', '850e8400-e29b-41d4-a716-446655440003', 'cleaning_fee', 'One-time cleaning fee', 250.00, '2024-01-20 16:45:00'),
('950e8400-e29b-41d4-a716-446655440012', '850e8400-e29b-41d4-a716-446655440003', 'service_fee', 'AirBnB service fee', 585.00, '2024-01-20 16:45:00'),
('950e8400-e29b-41d4-a716-446655440013', '850e8400-e29b-41d4-a716-446655440003', 'tax', 'TOT tax (12%)', 672.00, '2024-01-20 16:45:00'),
('950e8400-e29b-41d4-a716-446655440014', '850e8400-e29b-41d4-a716-446655440003', 'discount', 'Weekly stay discount', -507.00, '2024-01-20 16:45:00');

-- Breakdown for Booking 6 (San Francisco - 7 nights)
INSERT INTO BookingPriceBreakdown (breakdown_id, booking_id, item_type, description, amount, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440015', '850e8400-e29b-41d4-a716-446655440006', 'base_rate', '7 nights × $380.00', 2660.00, '2024-10-01 14:20:00'),
('950e8400-e29b-41d4-a716-446655440016', '850e8400-e29b-41d4-a716-446655440006', 'cleaning_fee', 'One-time cleaning fee', 175.00, '2024-10-01 14:20:00'),
('950e8400-e29b-41d4-a716-446655440017', '850e8400-e29b-41d4-a716-446655440006', 'service_fee', 'AirBnB service fee', 283.50, '2024-10-01 14:20:00'),
('950e8400-e29b-41d4-a716-446655440018', '850e8400-e29b-41d4-a716-446655440006', 'tax', 'TOT tax (14%)', 373.20, '2024-10-01 14:20:00');

-- =====================================================
-- SAMPLE DATA: PAYMENTS
-- =====================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method, transaction_id, status) VALUES
-- Completed payments
('a50e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001', 2450.00, '2023-12-10 14:35:00', 'credit_card', 'TXN-2023-12-10-001', 'completed'),
('a50e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440002', 1800.00, '2024-01-05 10:20:00', 'paypal', 'TXN-2024-01-05-002', 'completed'),
('a50e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440003', 5600.00, '2024-01-20 16:50:00', 'stripe', 'TXN-2024-01-20-003', 'completed'),
('a50e8400-e29b-41d4-a716-446655440004', '850e8400-e29b-41d4-a716-446655440004', 2240.00, '2024-02-15 11:35:00', 'credit_card', 'TXN-2024-02-15-004', 'completed'),
('a50e8400-e29b-41d4-a716-446655440005', '850e8400-e29b-41d4-a716-446655440005', 1125.00, '2024-02-28 09:05:00', 'stripe', 'TXN-2024-02-28-005', 'completed'),
('a50e8400-e29b-41d4-a716-446655440006', '850e8400-e29b-41d4-a716-446655440006', 2660.00, '2024-10-02 10:35:00', 'credit_card', 'TXN-2024-10-02-006', 'completed'),
('a50e8400-e29b-41d4-a716-446655440007', '850e8400-e29b-41d4-a716-446655440007', 1960.00, '2024-10-15 11:50:00', 'paypal', 'TXN-2024-10-15-007', 'completed'),

-- Pending payments
('a50e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440008', 1000.00, '2024-10-20 15:35:00', 'credit_card', 'TXN-2024-10-20-008', 'pending'),
('a50e8400-e29b-41d4-a716-446655440009', '850e8400-e29b-41d4-a716-446655440009', 1050.00, '2024-10-22 10:05:00', 'stripe', 'TXN-2024-10-22-009', 'pending'),

-- Refunded payment (for canceled booking)
('a50e8400-e29b-41d4-a716-446655440010', '850e8400-e29b-41d4-a716-446655440010', 900.00, '2024-03-01 12:05:00', 'credit_card', 'TXN-2024-03-01-010', 'refunded'),

-- Additional completed payments
('a50e8400-e29b-41d4-a716-446655440011', '850e8400-e29b-41d4-a716-446655440011', 1400.00, '2024-07-10 10:05:00', 'stripe', 'TXN-2024-07-10-011', 'completed'),
('a50e8400-e29b-41d4-a716-446655440012', '850e8400-e29b-41d4-a716-446655440012', 4000.00, '2024-08-20 14:35:00', 'credit_card', 'TXN-2024-08-20-012', 'completed'),
('a50e8400-e29b-41d4-a716-446655440013', '850e8400-e29b-41d4-a716-446655440013', 3150.00, '2024-06-15 11:25:00', 'paypal', 'TXN-2024-06-15-013', 'completed'),
('a50e8400-e29b-41d4-a716-446655440014', '850e8400-e29b-41d4-a716-446655440014', 585.00, '2024-05-15 09:50:00', 'stripe', 'TXN-2024-05-15-014', 'completed'),
('a50e8400-e29b-41d4-a716-446655440015', '850e8400-e29b-41d4-a716-446655440015', 875.00, '2024-04-25 13:20:00', 'credit_card', 'TXN-2024-04-25-015', 'completed');

-- =====================================================
-- SAMPLE DATA: REVIEWS
-- =====================================================

INSERT INTO Review (review_id, property_id, user_id, booking_id, rating, comment, created_at) VALUES
-- Reviews for completed bookings
('b50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '850e8400-e29b-41d4-a716-446655440001',
 5, 'Absolutely stunning beachfront property! The views were breathtaking, and the location was perfect for exploring Miami. Robert was an excellent host, very responsive and provided great recommendations. The condo was immaculate and had everything we needed. Would definitely stay here again!',
 '2024-01-25 10:30:00'),

('b50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440002',
 5, 'Perfect Manhattan apartment! Maria was a wonderful host. The location is unbeatable - walking distance to everything. The apartment was clean, modern, and exactly as described. The skyline views from the window were amazing. Highly recommend for anyone visiting NYC!',
 '2024-02-07 14:15:00'),

('b50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440009', '850e8400-e29b-41d4-a716-446655440003',
 5, 'This villa exceeded all expectations! The infinity pool with city views was incredible. James thought of everything - from the fully stocked kitchen to entertainment options. Perfect for a special occasion. The location in Hollywood Hills was spectacular. Worth every penny!',
 '2024-02-23 11:45:00'),

('b50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440010', '850e8400-e29b-41d4-a716-446655440004',
 4, 'Lovely historic townhouse in a great London location. Linda was very helpful with recommendations for restaurants and attractions. The house has beautiful original features. Only minor issue was the WiFi could be stronger, but overall a great stay. Would recommend!',
 '2024-03-19 16:20:00'),

('b50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', '850e8400-e29b-41d4-a716-446655440005',
 5, 'Perfect Chicago getaway! The loft was spacious, clean, and in an amazing location. Robert provided excellent check-in instructions and was available when we had questions. The exposed brick and high ceilings made it feel special. Would love to return!',
 '2024-03-27 09:30:00'),

('b50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440011',
 5, 'Second time staying at Robert\'s place and it was just as amazing! The beach access is unbeatable, and waking up to ocean views never gets old. The condo is well-maintained and has all the amenities you need. Robert is a superhost for a reason!',
 '2024-08-07 13:00:00'),

('b50e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', '850e8400-e29b-41d4-a716-446655440012',
 5, 'Dream vacation spot! The villa is even more beautiful in person. We spent most of our time by the pool enjoying the incredible views. James was a great host - quick to respond and very accommodating. Perfect for a luxurious LA experience!',
 '2024-09-22 15:45:00'),

('b50e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440013', '850e8400-e29b-41d4-a716-446655440013',
 4, 'Great NYC apartment in an excellent location. Maria was responsive and helpful. The apartment was clean and comfortable. The only reason for 4 stars instead of 5 is that it can be a bit noisy from the street, but that\'s to be expected in Manhattan. Overall, very happy with our stay.',
 '2024-07-29 10:15:00'),

('b50e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440014', '850e8400-e29b-41d4-a716-446655440014',
 5, 'Perfect spot for experiencing Austin\'s music scene! Walking distance to all the best bars and venues on 6th Street. The condo was modern, clean, and had everything we needed. Robert gave us great tips for local BBQ spots. Highly recommend for SXSW or ACL!',
 '2024-06-15 12:30:00'),

('b50e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440015', '850e8400-e29b-41d4-a716-446655440015',
 4, 'Nice apartment in Midtown Atlanta. Maria was a good host and the location was convenient for our business meetings. The apartment was clean and well-equipped. The gym in the building was a nice bonus. Would stay again for business trips.',
 '2024-05-27 14:00:00');

-- =====================================================
-- SAMPLE DATA: REVIEW RESPONSES
-- =====================================================

INSERT INTO ReviewResponse (response_id, review_id, host_id, response_text, created_at) VALUES
-- Robert's responses
('c50e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002',
 'Thank you so much for the wonderful review, Sarah! It was a pleasure hosting you. I\'m thrilled you enjoyed the beachfront views and Miami experience. You\'re welcome back anytime!',
 '2024-01-26 09:00:00'),

('c50e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002',
 'Thanks Jessica! So happy you enjoyed the Chicago loft. It\'s always great to host returning guests. Looking forward to your next visit!',
 '2024-03-28 10:15:00'),

('c50e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002',
 'Welcome back, Michael! Always a pleasure to host you. So glad you enjoyed another Miami beach getaway. See you next time!',
 '2024-08-08 08:30:00'),

('c50e8400-e29b-41d4-a716-446655440004', 'b50e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002',
 'Thanks Christopher! Glad you had a great time experiencing Austin\'s music scene. Hope you got to try Franklin BBQ! Come back anytime!',
 '2024-06-16 11:00:00'),

-- Maria's responses
('c50e8400-e29b-41d4-a716-446655440005', 'b50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003',
 'Thank you for the lovely review, Michael! I\'m so pleased you enjoyed the Manhattan apartment and found the location convenient. Hope to host you again on your next NYC visit!',
 '2024-02-08 11:30:00'),

('c50e8400-e29b-41d4-a716-446655440006', 'b50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003',
 'Thanks Amanda! I appreciate your honest feedback. I understand about the street noise - it\'s the price of being in such a central location! Glad you otherwise enjoyed your stay.',
 '2024-07-30 09:45:00'),

('c50e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440003',
 'Thank you Jennifer! Happy the apartment worked well for your business trip. You\'re always welcome back when you\'re in Atlanta!',
 '2024-05-28 10:00:00'),

-- James's responses
('c50e8400-e29b-41d4-a716-446655440008', 'b50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004',
 'Thank you Emily! I\'m thrilled the villa exceeded your expectations. It truly is a special property. Would love to host you again for another celebration!',
 '2024-02-24 14:20:00'),

('c50e8400-e29b-41d4-a716-446655440009', 'b50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004',
 'Thanks Daniel! So happy you enjoyed the villa and the LA experience. The pool with those views really is something special. Come back soon!',
 '2024-09-23 10:30:00'),

-- Linda's response
('c50e8400-e29b-41d4-a716-446655440010', 'b50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005',
 'Thank you for your feedback, John! I\'m glad you enjoyed the historic character of the townhouse. I\'ll look into upgrading the WiFi. Hope to welcome you back to London soon!',
 '2024-03-20 15:00:00');

-- =====================================================
-- SAMPLE DATA: MESSAGES
-- =====================================================

INSERT INTO Message (message_id, sender_id, recipient_id, property_id, booking_id, message_body, is_read, sent_at, read_at) VALUES
-- Pre-booking inquiries
('d50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', NULL,
 'Hi Robert! Your beachfront condo looks amazing. Is it available for January 15-22? Also, is parking included?',
 TRUE, '2023-12-08 10:30:00', '2023-12-08 11:15:00'),

('d50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440001', NULL,
 'Hi Sarah! Yes, the condo is available for those dates. Parking is included - one covered spot in the building garage. The beach access is just steps away. Let me know if you have any other questions!',
 TRUE, '2023-12-08 11:15:00', '2023-12-08 12:00:00'),

('d50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', NULL,
 'Perfect! That sounds great. I\'ll go ahead and book. Thanks!',
 TRUE, '2023-12-08 12:00:00', '2023-12-08 12:30:00'),

-- Booking confirmation and details
('d50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001',
 'Thanks for booking Sarah! I\'ll send you detailed check-in instructions a few days before your arrival. Looking forward to hosting you!',
 TRUE, '2023-12-10 14:40:00', '2023-12-10 15:00:00'),

('d50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001',
 'Hi Sarah! Your check-in is coming up. The door code is 4532#. Parking spot B7. WiFi password is BeachLife2024. Check-in after 3pm, checkout by 11am. Beach towels are in the hall closet. Enjoy your stay!',
 TRUE, '2024-01-12 10:00:00', '2024-01-12 11:30:00'),

-- During stay communication
('d50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001',
 'Hi Robert! We\'ve checked in and everything looks great. Quick question - what\'s the best beach restaurant nearby?',
 TRUE, '2024-01-15 16:30:00', '2024-01-15 17:00:00'),

('d50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001',
 'Glad you\'re settled in! For great seafood, try Joe\'s Stone Crab (make reservations!) or The Deck at Island Gardens for sunset views. For casual, hit up Mango\'s Tropical Cafe on Ocean Drive. Enjoy!',
 TRUE, '2024-01-15 17:00:00', '2024-01-15 17:15:00'),

-- Manhattan apartment inquiry and booking
('d50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', NULL,
 'Hi Maria! Planning a trip to NYC Feb 1-5. Is your apartment near Central Park? How far to Times Square?',
 TRUE, '2024-01-03 14:20:00', '2024-01-03 15:00:00'),

('d50e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440003', NULL,
 'Hi Michael! Yes, we\'re in Midtown - about 10 min walk to Central Park and 15 min to Times Square. Also close to subway stations. Perfect location for tourists!',
 TRUE, '2024-01-03 15:00:00', '2024-01-03 15:30:00'),

-- Hollywood Villa inquiry
('d50e8400-e29b-41d4-a716-446655440010', '550e8
