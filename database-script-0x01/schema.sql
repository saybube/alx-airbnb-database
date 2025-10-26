-- =====================================================
-- AirBnB Database Schema - SQL DDL Statements
-- Normalized to Third Normal Form (3NF)
-- =====================================================

-- Drop existing tables if they exist (for clean setup)
-- Order matters due to foreign key constraints
DROP TABLE IF EXISTS ReviewResponse;
DROP TABLE IF EXISTS BookingPriceBreakdown;
DROP TABLE IF EXISTS PropertyAmenity;
DROP TABLE IF EXISTS Amenity;
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS User;

-- =====================================================
-- CORE TABLES
-- =====================================================

-- -----------------------------------------------------
-- Table: User
-- Description: Stores user information (guests, hosts, admins)
-- -----------------------------------------------------
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_email_format CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'),
    CONSTRAINT chk_phone_format CHECK (phone_number IS NULL OR phone_number REGEXP '^[0-9+()-\s]+$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- -----------------------------------------------------
-- Table: Location
-- Description: Stores normalized address information
-- -----------------------------------------------------
CREATE TABLE Location (
    location_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100) NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NULL,
    latitude DECIMAL(10, 8) NULL,
    longitude DECIMAL(11, 8) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_latitude CHECK (latitude IS NULL OR (latitude >= -90 AND latitude <= 90)),
    CONSTRAINT chk_longitude CHECK (longitude IS NULL OR (longitude >= -180 AND longitude <= 180))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Location table
CREATE INDEX idx_location_city_country ON Location(city, country);
CREATE INDEX idx_location_coordinates ON Location(latitude, longitude);
CREATE INDEX idx_location_postal_code ON Location(postal_code);

-- -----------------------------------------------------
-- Table: Property
-- Description: Stores rental property listings
-- -----------------------------------------------------
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    location_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    CONSTRAINT fk_property_host 
        FOREIGN KEY (host_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_property_location 
        FOREIGN KEY (location_id) REFERENCES Location(location_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_pricepernight CHECK (pricepernight > 0),
    CONSTRAINT chk_name_length CHECK (CHAR_LENGTH(name) >= 3),
    CONSTRAINT chk_description_length CHECK (CHAR_LENGTH(description) >= 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Property table
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_created_at ON Property(created_at);
CREATE FULLTEXT INDEX idx_property_search ON Property(name, description);

-- -----------------------------------------------------
-- Table: Amenity
-- Description: Stores available property amenities
-- -----------------------------------------------------
CREATE TABLE Amenity (
    amenity_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    icon VARCHAR(50) NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_amenity_category CHECK (
        category IN ('Essential', 'Features', 'Location', 'Safety', 'Accessibility')
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Amenity table
CREATE INDEX idx_amenity_category ON Amenity(category);
CREATE INDEX idx_amenity_name ON Amenity(name);

-- -----------------------------------------------------
-- Table: PropertyAmenity (Junction Table)
-- Description: Links properties with their amenities (Many-to-Many)
-- -----------------------------------------------------
CREATE TABLE PropertyAmenity (
    property_id CHAR(36) NOT NULL,
    amenity_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Composite Primary Key
    PRIMARY KEY (property_id, amenity_id),
    
    -- Foreign Keys
    CONSTRAINT fk_propertyamenity_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_propertyamenity_amenity 
        FOREIGN KEY (amenity_id) REFERENCES Amenity(amenity_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for PropertyAmenity table
CREATE INDEX idx_propertyamenity_property ON PropertyAmenity(property_id);
CREATE INDEX idx_propertyamenity_amenity ON PropertyAmenity(amenity_id);

-- -----------------------------------------------------
-- Table: Booking
-- Description: Stores property booking/reservation information
-- -----------------------------------------------------
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    canceled_at TIMESTAMP NULL,
    
    -- Foreign Keys
    CONSTRAINT fk_booking_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_user 
        FOREIGN KEY (user_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    CONSTRAINT chk_booking_total_price CHECK (total_price >= 0),
    CONSTRAINT chk_booking_duration CHECK (DATEDIFF(end_date, start_date) <= 365),
    CONSTRAINT chk_canceled_status CHECK (
        (status = 'canceled' AND canceled_at IS NOT NULL) OR 
        (status != 'canceled' AND canceled_at IS NULL)
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Booking table
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Composite index for checking availability
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date, status);

-- -----------------------------------------------------
-- Table: BookingPriceBreakdown
-- Description: Detailed breakdown of booking costs
-- -----------------------------------------------------
CREATE TABLE BookingPriceBreakdown (
    breakdown_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) NOT NULL,
    item_type ENUM('base_rate', 'cleaning_fee', 'service_fee', 'tax', 'discount') NOT NULL,
    description VARCHAR(255) NULL,
    amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    CONSTRAINT fk_breakdown_booking 
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_breakdown_amount CHECK (
        (item_type = 'discount' AND amount <= 0) OR 
        (item_type != 'discount' AND amount >= 0)
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for BookingPriceBreakdown table
CREATE INDEX idx_breakdown_booking ON BookingPriceBreakdown(booking_id);
CREATE INDEX idx_breakdown_item_type ON BookingPriceBreakdown(item_type);

-- -----------------------------------------------------
-- Table: Payment
-- Description: Stores payment transaction information
-- -----------------------------------------------------
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    transaction_id VARCHAR(255) NULL UNIQUE,
    status ENUM('pending', 'completed', 'failed', 'refunded') NOT NULL DEFAULT 'pending',
    
    -- Foreign Keys
    CONSTRAINT fk_payment_booking 
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_payment_amount CHECK (amount > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Payment table
CREATE INDEX idx_payment_booking ON Payment(booking_id);
CREATE INDEX idx_payment_date ON Payment(payment_date);
CREATE INDEX idx_payment_status ON Payment(status);
CREATE INDEX idx_payment_method ON Payment(payment_method);
CREATE INDEX idx_payment_transaction ON Payment(transaction_id);

-- -----------------------------------------------------
-- Table: Review
-- Description: Stores property reviews from guests
-- -----------------------------------------------------
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    booking_id CHAR(36) NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    CONSTRAINT fk_review_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_user 
        FOREIGN KEY (user_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_booking 
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_review_rating CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT chk_review_comment_length CHECK (CHAR_LENGTH(comment) >= 10),
    
    -- Unique constraint: One review per user per booking
    CONSTRAINT uq_review_user_booking UNIQUE (user_id, booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Review table
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_booking ON Review(booking_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);
CREATE FULLTEXT INDEX idx_review_comment ON Review(comment);

-- -----------------------------------------------------
-- Table: ReviewResponse
-- Description: Stores host responses to reviews (One-to-One with Review)
-- -----------------------------------------------------
CREATE TABLE ReviewResponse (
    response_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    review_id CHAR(36) NOT NULL UNIQUE,
    host_id CHAR(36) NOT NULL,
    response_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    CONSTRAINT fk_reviewresponse_review 
        FOREIGN KEY (review_id) REFERENCES Review(review_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_reviewresponse_host 
        FOREIGN KEY (host_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_response_text_length CHECK (CHAR_LENGTH(response_text) >= 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for ReviewResponse table
CREATE INDEX idx_reviewresponse_review ON ReviewResponse(review_id);
CREATE INDEX idx_reviewresponse_host ON ReviewResponse(host_id);
CREATE INDEX idx_reviewresponse_created_at ON ReviewResponse(created_at);

-- -----------------------------------------------------
-- Table: Message
-- Description: Stores messages between users
-- -----------------------------------------------------
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    property_id CHAR(36) NULL,
    booking_id CHAR(36) NULL,
    message_body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    
    -- Foreign Keys
    CONSTRAINT fk_message_sender 
        FOREIGN KEY (sender_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_recipient 
        FOREIGN KEY (recipient_id) REFERENCES User(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_property 
        FOREIGN KEY (property_id) REFERENCES Property(property_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_booking 
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    
    -- Constraints
    CONSTRAINT chk_message_sender_recipient CHECK (sender_id != recipient_id),
    CONSTRAINT chk_message_body_length CHECK (CHAR_LENGTH(message_body) >= 1),
    CONSTRAINT chk_message_read CHECK (
        (is_read = TRUE AND read_at IS NOT NULL) OR 
        (is_read = FALSE AND read_at IS NULL)
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes for Message table
CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
CREATE INDEX idx_message_property ON Message(property_id);
CREATE INDEX idx_message_booking ON Message(booking_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);
CREATE INDEX idx_message_is_read ON Message(is_read);

-- Composite index for conversation threads
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);
CREATE INDEX idx_message_unread ON Message(recipient_id, is_read, sent_at);

-- =====================================================
-- VIEWS FOR COMMON QUERIES
-- =====================================================

-- -----------------------------------------------------
-- View: PropertyWithLocation
-- Description: Combines property and location details
-- -----------------------------------------------------
CREATE VIEW PropertyWithLocation AS
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name,
    u.email AS host_email,
    l.street_address,
    l.city,
    l.state_province,
    l.country,
    l.postal_code,
    l.latitude,
    l.longitude,
    p.created_at,
    p.updated_at
FROM Property p
JOIN User u ON p.host_id = u.user_id
JOIN Location l ON p.location_id = l.location_id;

-- -----------------------------------------------------
-- View: PropertyAverageRating
-- Description: Calculates average rating per property
-- -----------------------------------------------------
CREATE VIEW PropertyAverageRating AS
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name;

-- -----------------------------------------------------
-- View: BookingDetails
-- Description: Complete booking information with user and property details
-- -----------------------------------------------------
CREATE VIEW BookingDetails AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    DATEDIFF(b.end_date, b.start_date) AS nights,
    b.total_price,
    b.status,
    u.user_id AS guest_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    h.user_id AS host_id,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    l.city,
    l.country,
    b.created_at AS booking_date
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User h ON p.host_id = h.user_id
JOIN Location l ON p.location_id = l.location_id;

-- =====================================================
-- TRIGGERS FOR DATA INTEGRITY
-- =====================================================

-- -----------------------------------------------------
-- Trigger: Validate host role before property creation
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER trg_validate_host_role
BEFORE INSERT ON Property
FOR EACH ROW
BEGIN
    DECLARE user_role VARCHAR(10);
    
    SELECT role INTO user_role 
    FROM User 
    WHERE user_id = NEW.host_id;
    
    IF user_role NOT IN ('host', 'admin') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Only users with host or admin role can create properties';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- Trigger: Prevent booking overlap
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER trg_prevent_booking_overlap
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    
    SELECT COUNT(*) INTO overlap_count
    FROM Booking
    WHERE property_id = NEW.property_id
    AND status IN ('pending', 'confirmed')
    AND (
        (NEW.start_date BETWEEN start_date AND end_date) OR
        (NEW.end_date BETWEEN start_date AND end_date) OR
        (start_date BETWEEN NEW.start_date AND NEW.end_date)
    );
    
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Property is already booked for selected dates';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- Trigger: Update booking status when canceled
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER trg_booking_cancel_timestamp
BEFORE UPDATE ON Booking
FOR EACH ROW
BEGIN
    IF NEW.status = 'canceled' AND OLD.status != 'canceled' THEN
        SET NEW.canceled_at = CURRENT_TIMESTAMP;
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- Trigger: Validate review from actual guest
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER trg_validate_reviewer
BEFORE INSERT ON Review
FOR EACH ROW
BEGIN
    DECLARE booking_count INT;
    
    IF NEW.booking_id IS NOT NULL THEN
        SELECT COUNT(*) INTO booking_count
        FROM Booking
        WHERE booking_id = NEW.booking_id
        AND user_id = NEW.user_id
        AND property_id = NEW.property_id
        AND status = 'confirmed'
        AND end_date < CURRENT_DATE;
        
        IF booking_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Can only review properties after completing a confirmed booking';
        END IF;
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- Trigger: Validate review response from property host
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER trg_validate_review_response_host
BEFORE INSERT ON ReviewResponse
FOR EACH ROW
BEGIN
    DECLARE property_host_id CHAR(36);
    
    SELECT p.host_id INTO property_host_id
    FROM Review r
    JOIN Property p ON r.property_id = p.property_id
    WHERE r.review_id = NEW.review_id;
    
    IF NEW.host_id != property_host_id THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Only the property host can respond to reviews';
    END IF;
END//
DELIMITER ;

-- =====================================================
-- INITIAL DATA SETUP (SAMPLE AMENITIES)
-- =====================================================

-- Insert common amenities
INSERT INTO Amenity (amenity_id, name, category, icon) VALUES
(UUID(), 'WiFi', 'Essential', 'wifi'),
(UUID(), 'Kitchen', 'Essential', 'kitchen'),
(UUID(), 'Washer', 'Essential', 'washer'),
(UUID(), 'Dryer', 'Essential', 'dryer'),
(UUID(), 'Air conditioning', 'Essential', 'ac'),
(UUID(), 'Heating', 'Essential', 'heating'),
(UUID(), 'TV', 'Features', 'tv'),
(UUID(), 'Pool', 'Features', 'pool'),
(UUID(), 'Hot tub', 'Features', 'hot-tub'),
(UUID(), 'Gym', 'Features', 'gym'),
(UUID(), 'Free parking', 'Location', 'parking'),
(UUID(), 'EV charger', 'Location', 'ev-charger'),
(UUID(), 'Workspace', 'Features', 'workspace'),
(UUID(), 'Smoke alarm', 'Safety', 'smoke-alarm'),
(UUID(), 'Carbon monoxide alarm', 'Safety', 'co-alarm'),
(UUID(), 'Fire extinguisher', 'Safety', 'extinguisher'),
(UUID(), 'First aid kit', 'Safety', 'first-aid'),
(UUID(), 'Step-free access', 'Accessibility', 'wheelchair'),
(UUID(), 'Wide doorways', 'Accessibility', 'door'),
(UUID(), 'Accessible bathroom', 'Accessibility', 'bathroom');

-- =====================================================
-- PERFORMANCE MONITORING
-- =====================================================

-- Create a table to log slow queries (optional)
CREATE TABLE IF NOT EXISTS QueryPerformanceLog (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    query_text TEXT,
    execution_time DECIMAL(10, 4),
    rows_examined BIGINT,
    rows_returned BIGINT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_log_time (logged_at),
    INDEX idx_log_execution (execution_time)
) ENGINE=InnoDB;

-- =====================================================
-- COMPLETION MESSAGE
-- =====================================================

SELECT 'AirBnB Database Schema Created Successfully!' AS Status,
       'All tables, indexes, views, and triggers are now in place.' AS Message,
       '11 tables, 40+ indexes, 3 views, and 5 triggers created.' AS Details;
