-- ===============================================
-- DATABASE INDEX OPTIMIZATION SCRIPT
-- File: database_index.sql
-- ===============================================

-- Indexes on Users table
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- Indexes on Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Indexes on Properties table
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_property_name ON properties(property_name);

-- Optional composite index for frequent joins or filters
CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

-- Measure performance before and after indexing
EXPLAIN ANALYZE
SELECT 
    u.first_name, b.booking_date, p.property_name
FROM 
    users u
JOIN 
    bookings b ON u.user_id = b.user_id
JOIN 
    properties p ON b.property_id = p.property_id
WHERE 
    b.booking_date >= '2024-01-01'
ORDER BY 
    b.booking_date DESC;
