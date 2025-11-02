-- Step 1: Create a new partitioned version of the Booking table
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for specific year ranges
CREATE TABLE booking_2023 PARTITION OF Booking
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF Booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF Booking
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Index each partition for faster range queries
CREATE INDEX idx_booking_2023_startdate ON booking_2023 (start_date);
CREATE INDEX idx_booking_2024_startdate ON booking_2024 (start_date);
CREATE INDEX idx_booking_2025_startdate ON booking_2025 (start_date);

-- Measure query performance before/after partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31'
AND status = 'confirmed';
