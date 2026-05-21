-- ============================================================
-- NUSATEL DATA PRODUCTS — DUMMY TELCO INSIGHT DATA
-- Fake telco company "NusaTel" for workshop demo
-- Run this FIRST to create sample aggregation datasets
-- ============================================================

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE GEN2_SMALL;

-- ============================================================
-- 1. DATABASE & SCHEMAS
-- ============================================================
CREATE OR REPLACE DATABASE NUSATEL_DATA_PRODUCTS;
CREATE SCHEMA IF NOT EXISTS NUSATEL_DATA_PRODUCTS.MOBILITY;
CREATE SCHEMA IF NOT EXISTS NUSATEL_DATA_PRODUCTS.AUDIENCE;
CREATE SCHEMA IF NOT EXISTS NUSATEL_DATA_PRODUCTS.NETWORK;

-- ============================================================
-- 2. MOBILITY — Hourly Footfall (10,000 rows)
-- ============================================================
CREATE OR REPLACE TABLE NUSATEL_DATA_PRODUCTS.MOBILITY.HOURLY_FOOTFALL (
    snapshot_date       DATE,
    hour_of_day         INT,
    province            VARCHAR(100),
    city                VARCHAR(100),
    district            VARCHAR(100),
    h3_resolution_7     VARCHAR(20),
    unique_devices      INT,
    avg_dwell_minutes   FLOAT,
    inflow_devices      INT,
    outflow_devices     INT,
    data_source         VARCHAR(50) DEFAULT 'NusaTel Network'
);

INSERT INTO NUSATEL_DATA_PRODUCTS.MOBILITY.HOURLY_FOOTFALL
(snapshot_date, hour_of_day, province, city, district, h3_resolution_7,
 unique_devices, avg_dwell_minutes, inflow_devices, outflow_devices, data_source)
SELECT
    DATEADD(DAY, -(seq4() % 30), CURRENT_DATE()),
    MOD(seq4(), 24),
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'DKI Jakarta' WHEN 1 THEN 'Jawa Barat'
        WHEN 2 THEN 'Jawa Timur' WHEN 3 THEN 'Bali'
        WHEN 4 THEN 'Sumatera Utara' ELSE 'Sulawesi Selatan' END,
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'Jakarta Selatan' WHEN 1 THEN 'Bandung'
        WHEN 2 THEN 'Surabaya' WHEN 3 THEN 'Denpasar'
        WHEN 4 THEN 'Medan' ELSE 'Makassar' END,
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'Kebayoran Baru' WHEN 1 THEN 'Coblong'
        WHEN 2 THEN 'Gubeng' WHEN 3 THEN 'Kuta'
        WHEN 4 THEN 'Medan Kota' ELSE 'Panakkukang' END,
    '87' || LPAD(MOD(seq4(), 9999)::VARCHAR, 4, '0') || 'ff',
    UNIFORM(500, 50000, RANDOM()),
    ROUND(UNIFORM(3, 120, RANDOM())::FLOAT, 1),
    UNIFORM(100, 20000, RANDOM()),
    UNIFORM(100, 20000, RANDOM()),
    'NusaTel Network'
FROM TABLE(GENERATOR(ROWCOUNT => 10000));

-- ============================================================
-- 3. AUDIENCE — Weekly Segments (5,000 rows)
-- ============================================================
CREATE OR REPLACE TABLE NUSATEL_DATA_PRODUCTS.AUDIENCE.WEEKLY_SEGMENTS (
    week_start_date     DATE,
    province            VARCHAR(100),
    city                VARCHAR(100),
    age_group           VARCHAR(20),
    gender              VARCHAR(10),
    income_tier         VARCHAR(20),
    device_brand_top    VARCHAR(50),
    segment_name        VARCHAR(100),
    subscriber_count    INT,
    avg_data_usage_gb   FLOAT,
    avg_voice_min       FLOAT,
    avg_sms_count       INT,
    avg_arpu_usd        FLOAT,
    data_source         VARCHAR(50) DEFAULT 'NusaTel Aggregated'
);

INSERT INTO NUSATEL_DATA_PRODUCTS.AUDIENCE.WEEKLY_SEGMENTS
(week_start_date, province, city, age_group, gender, income_tier, device_brand_top,
 segment_name, subscriber_count, avg_data_usage_gb, avg_voice_min, avg_sms_count,
 avg_arpu_usd, data_source)
SELECT
    DATE_TRUNC('WEEK', DATEADD(DAY, -(seq4() % 90), CURRENT_DATE())),
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'DKI Jakarta' WHEN 1 THEN 'Jawa Barat'
        WHEN 2 THEN 'Jawa Timur' WHEN 3 THEN 'Bali'
        WHEN 4 THEN 'Sumatera Utara' ELSE 'Sulawesi Selatan' END,
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'Jakarta Selatan' WHEN 1 THEN 'Bandung'
        WHEN 2 THEN 'Surabaya' WHEN 3 THEN 'Denpasar'
        WHEN 4 THEN 'Medan' ELSE 'Makassar' END,
    CASE MOD(seq4(), 5)
        WHEN 0 THEN '18-24' WHEN 1 THEN '25-34'
        WHEN 2 THEN '35-44' WHEN 3 THEN '45-54' ELSE '55+' END,
    CASE MOD(seq4(), 2) WHEN 0 THEN 'Male' ELSE 'Female' END,
    CASE MOD(seq4(), 4)
        WHEN 0 THEN 'Low' WHEN 1 THEN 'Medium'
        WHEN 2 THEN 'High' ELSE 'Premium' END,
    CASE MOD(seq4(), 5)
        WHEN 0 THEN 'Samsung' WHEN 1 THEN 'Apple'
        WHEN 2 THEN 'Xiaomi' WHEN 3 THEN 'OPPO' ELSE 'Vivo' END,
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'Digital Natives' WHEN 1 THEN 'Business Professionals'
        WHEN 2 THEN 'Budget Seekers' WHEN 3 THEN 'Entertainment Enthusiasts'
        WHEN 4 THEN 'Family Connectors' ELSE 'Premium Lifestyle' END,
    UNIFORM(1000, 500000, RANDOM()),
    ROUND(UNIFORM(1, 50, RANDOM())::FLOAT, 2),
    ROUND(UNIFORM(5, 300, RANDOM())::FLOAT, 1),
    UNIFORM(0, 200, RANDOM()),
    ROUND(UNIFORM(2, 45, RANDOM())::FLOAT, 2),
    'NusaTel Aggregated'
FROM TABLE(GENERATOR(ROWCOUNT => 5000));

-- ============================================================
-- 4. NETWORK — Daily Tower Coverage (8,000 rows)
-- ============================================================
CREATE OR REPLACE TABLE NUSATEL_DATA_PRODUCTS.NETWORK.DAILY_COVERAGE (
    report_date         DATE,
    province            VARCHAR(100),
    city                VARCHAR(100),
    tower_id            VARCHAR(20),
    technology          VARCHAR(10),
    latitude            FLOAT,
    longitude           FLOAT,
    avg_signal_dbm      FLOAT,
    avg_download_mbps   FLOAT,
    avg_upload_mbps     FLOAT,
    avg_latency_ms      FLOAT,
    connected_devices   INT,
    availability_pct    FLOAT,
    data_source         VARCHAR(50) DEFAULT 'NusaTel NetOps'
);

INSERT INTO NUSATEL_DATA_PRODUCTS.NETWORK.DAILY_COVERAGE
(report_date, province, city, tower_id, technology, latitude, longitude,
 avg_signal_dbm, avg_download_mbps, avg_upload_mbps, avg_latency_ms,
 connected_devices, availability_pct, data_source)
SELECT
    DATEADD(DAY, -(seq4() % 30), CURRENT_DATE()),
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'DKI Jakarta' WHEN 1 THEN 'Jawa Barat'
        WHEN 2 THEN 'Jawa Timur' WHEN 3 THEN 'Bali'
        WHEN 4 THEN 'Sumatera Utara' ELSE 'Sulawesi Selatan' END,
    CASE MOD(seq4(), 6)
        WHEN 0 THEN 'Jakarta Selatan' WHEN 1 THEN 'Bandung'
        WHEN 2 THEN 'Surabaya' WHEN 3 THEN 'Denpasar'
        WHEN 4 THEN 'Medan' ELSE 'Makassar' END,
    'NTL-' || LPAD(seq4()::VARCHAR, 6, '0'),
    CASE MOD(seq4(), 3)
        WHEN 0 THEN '4G LTE' WHEN 1 THEN '5G NR' ELSE '4G LTE-A' END,
    ROUND(UNIFORM(-8, 4, RANDOM())::FLOAT, 6),
    ROUND(UNIFORM(95, 141, RANDOM())::FLOAT, 6),
    ROUND(UNIFORM(-110, -60, RANDOM())::FLOAT, 1),
    ROUND(UNIFORM(5, 500, RANDOM())::FLOAT, 2),
    ROUND(UNIFORM(2, 100, RANDOM())::FLOAT, 2),
    ROUND(UNIFORM(5, 80, RANDOM())::FLOAT, 1),
    UNIFORM(50, 10000, RANDOM()),
    ROUND(UNIFORM(95, 100, RANDOM())::FLOAT, 2),
    'NusaTel NetOps'
FROM TABLE(GENERATOR(ROWCOUNT => 8000));

-- ============================================================
-- 5. SECURE VIEWS (always share views, never raw tables)
-- ============================================================
CREATE OR REPLACE SECURE VIEW NUSATEL_DATA_PRODUCTS.MOBILITY.V_HOURLY_FOOTFALL AS
SELECT * FROM NUSATEL_DATA_PRODUCTS.MOBILITY.HOURLY_FOOTFALL;

CREATE OR REPLACE SECURE VIEW NUSATEL_DATA_PRODUCTS.AUDIENCE.V_WEEKLY_SEGMENTS AS
SELECT * FROM NUSATEL_DATA_PRODUCTS.AUDIENCE.WEEKLY_SEGMENTS;

CREATE OR REPLACE SECURE VIEW NUSATEL_DATA_PRODUCTS.NETWORK.V_DAILY_COVERAGE AS
SELECT * FROM NUSATEL_DATA_PRODUCTS.NETWORK.DAILY_COVERAGE;

-- ============================================================
-- 6. VERIFY ROW COUNTS
-- ============================================================
SELECT 'MOBILITY.HOURLY_FOOTFALL' AS dataset, COUNT(*) AS rows FROM NUSATEL_DATA_PRODUCTS.MOBILITY.HOURLY_FOOTFALL
UNION ALL SELECT 'AUDIENCE.WEEKLY_SEGMENTS', COUNT(*) FROM NUSATEL_DATA_PRODUCTS.AUDIENCE.WEEKLY_SEGMENTS
UNION ALL SELECT 'NETWORK.DAILY_COVERAGE', COUNT(*) FROM NUSATEL_DATA_PRODUCTS.NETWORK.DAILY_COVERAGE;
