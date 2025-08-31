INSERT INTO Role (role_name) VALUES
('guest'),
('host'),
('admin');

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role_id)
VALUES
(UUID(), 'Alice', 'Smith', 'alice@example.com', 'hashed_pw_123', '1234567890', 1),
(UUID(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw_456', '0987654321', 2),
(UUID(), 'Charlie', 'Admin', 'charlie@example.com', 'hashed_pw_789', NULL, 3);

INSERT INTO Location (address, city, state, country, postal_code)
VALUES
('123 Main St', 'Cape Town', 'Western Cape', 'South Africa', '8000'),
('456 Beach Ave', 'Durban', 'KwaZulu-Natal', 'South Africa', '4001');

INSERT INTO Property (property_id, host_id, name, description, location_id, price_per_night)
VALUES
(UUID(), (SELECT user_id FROM User WHERE email='bob@example.com'), 'Beachfront Villa', 'Luxury villa with ocean views', 2, 1500.00),
(UUID(), (SELECT user_id FROM User WHERE email='bob@example.com'), 'City Apartment', 'Modern apartment in the city center', 1, 900.00);

INSERT INTO BookingStatus (status_name) VALUES
('pending'),
('confirmed'),
('canceled');

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status_id)
VALUES
(UUID(),
 (SELECT property_id FROM Property WHERE name='Beachfront Villa'),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 '2025-09-01', '2025-09-07', 10500.00, 2),
(UUID(),
 (SELECT property_id FROM Property WHERE name='City Apartment'),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 '2025-10-10', '2025-10-15', 4500.00, 1);

INSERT INTO PaymentMethod (method_name) VALUES
('credit_card'),
('paypal'),
('stripe');

INSERT INTO Payment (payment_id, booking_id, amount, method_id)
VALUES
(UUID(),
 (SELECT booking_id FROM Booking WHERE total_price=10500.00),
 10500.00, 1),
(UUID(),
 (SELECT booking_id FROM Booking WHERE total_price=4500.00),
 4500.00, 2);

INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(UUID(),
 (SELECT property_id FROM Property WHERE name='Beachfront Villa'),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 5, 'Amazing experience! The villa was beautiful.'),
(UUID(),
 (SELECT property_id FROM Property WHERE name='City Apartment'),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 4, 'Great location and modern amenities.');

INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(UUID(),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 (SELECT user_id FROM User WHERE email='bob@example.com'),
 'Hi Bob, is the villa available for early check-in?'),
(UUID(),
 (SELECT user_id FROM User WHERE email='bob@example.com'),
 (SELECT user_id FROM User WHERE email='alice@example.com'),
 'Hi Alice, yes early check-in is possible.');
