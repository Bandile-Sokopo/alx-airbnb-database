-- Index on User email for fast lookups during login
CREATE INDEX idx_user_email ON User(email);

-- Index on Booking.user_id for joins and lookups
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking.property_id for joins
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on Booking.status for filtering bookings by status
CREATE INDEX idx_booking_status ON Booking(status);

-- Index on Property.location for searches
CREATE INDEX idx_property_location ON Property(location);

-- Index on Property.pricepernight for price range queries
CREATE INDEX idx_property_price ON Property(pricepernight);

SELECT u.first_name, u.last_name, b.booking_id, p.name AS property_name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
AND p.location = 'Cape Town'
ORDER BY p.pricepernight ASC;
