CREATE TABLE Role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name ENUM('guest', 'host', 'admin') NOT NULL UNIQUE
);

CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20)
);

CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location_id INT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE BookingStatus (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name ENUM('pending', 'confirmed', 'canceled') NOT NULL UNIQUE
);

CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES BookingStatus(status_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE PaymentMethod (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name ENUM('credit_card', 'paypal', 'stripe') NOT NULL UNIQUE
);

CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (method_id) REFERENCES PaymentMethod(method_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_id ON Property(property_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_payment_booking ON Payment(booking_id);
