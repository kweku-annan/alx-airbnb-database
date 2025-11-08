-- ===============================================
-- DATABASE PERFORMANCE MONITORING SCRIPT
-- File: performance_monitoring.sql
-- ===============================================

-- Step 1: Monitor query performance using EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.amount,
    u.first_name,
    u.email,
    p.property_name,
    pay.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.booking_date >= '2025-01-01'
ORDER BY 
    b.booking_date DESC;

-- Step 2: Identify bottlenecks from EXPLAIN output
-- Observation: Sequential scans on bookings and payments are taking most of the execution time.

-- Step 3: Implement performance improvements
-- Create missing indexes to reduce full table scans
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- Step 4: Re-run query to measure improvements
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.amount,
    u.first_name,
    u.email,
    p.property_name,
    pay.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.booking_date >= '2025-01-01'
ORDER BY 
    b.booking_date DESC;

-- Step 5: Performance report
-- Before indexing: Query used sequential scans on bookings and payments, resulting in longer execution times.
-- After indexing: Query used index scans, reducing the number of rows scanned and decreasing execution time.
-- Improvement observed: Execution time reduced significantly, especially for large datasets.
