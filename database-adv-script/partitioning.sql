-- Enable partitioning (PostgreSQL syntax)
-- Step 1: Rename original table
ALTER TABLE Booking RENAME TO Booking_old;

-- Step 2: Create new partitioned table
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions (example for 2024 and 2025)
CREATE TABLE Booking_2024 PARTITION OF Booking
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 4: Move data from old table to new partitioned table
INSERT INTO Booking
SELECT * FROM Booking_old;

-- Step 5: Drop old table after verification
DROP TABLE Booking_old;

