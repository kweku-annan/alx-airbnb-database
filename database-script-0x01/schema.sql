CREATE TYPE 'user_role' AS ENUM (
    'guest',
    'host',
    'admin'
);

CREATE TYPE bookings_status AS ENUM (
    'pending',
    'confirmed',
    'cancelled',
);

CREATE TYPE payment_method AS ENUM (
    'credit_card',
    'paypal',
    'stripe'
);

CREATE TABLE IF NOT EXISTS "users" (
    user_id uuid PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role 'user_role' NOT NULL DEFAULT 'guest'
);

CREATE TABLE IF NOT EXISTS "properties" (
    property_id uuid PRIMARY KEY,
    host_id uuid REFERENCES users(user_id),
    "name" VARCHAR NOT NULL,
    "description" TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "bookings" (
    booking_id uuid PRIMARY KEY,
    property_id uuid REFERENCES properties(property_id),
    user_id uuid REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status bookings_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "payments" (
    payment_id uuid PRIMARY KEY,
    booking_id uuid REFERENCES bookings(booking_id),
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method NOT NULL
);

CREATE TABLE IF NOT EXISTS "reviews" (
    review_id uuid PRIMARY KEY,
    property_id uuid REFERENCES properties(property_id),
    user_id uuid REFERENCES users(user_id),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT, NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "message" (
    message_id uuid PRIMARY KEY,
    sender_id uuid REFERENCES users(user_id),
    receiver_id uuid REFERENCES users(user_id),
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX [users_index_01] ON users (email);
CREATE INDEX [users_index_02] ON users (user_id);
CREATE INDEX [properties_index_01] ON properties (property_id);
CREATE INDEX [bookings_index_01] ON bookings (booking_id);
