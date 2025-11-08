-- ===============================================
-- QUERY PERFORMANCE OPTIMIZATION SCRIPT
-- File: performance.sql
-- ===============================================

-- Initial complex query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.amount,
    u.user_id,
    u.first_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    pay.payment_id,
    pay.payment_method,
    pay.status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    payments pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.booking_date DESC;

-- Refactored optimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.amount,
    u.first_name,
    p.property_name,
    pay.payment_method,
    pay.status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.booking_date >= '2024-01-01'
ORDER BY 
    b.booking_date DESC;

-- Suggested indexes for optimization
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
