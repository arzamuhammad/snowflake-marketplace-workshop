-- ============================================================
-- NUSATEL — CREATE SECURE SHARES
-- Run AFTER 01_setup_dummy_data.sql
-- ============================================================

USE ROLE ACCOUNTADMIN;
USE DATABASE NUSATEL_DATA_PRODUCTS;

-- ============================================================
-- SHARE 1: MOBILITY → FREE Public Listing
-- ============================================================
CREATE OR REPLACE SHARE NUSATEL_MOBILITY_FREE_SHARE
    COMMENT = 'NusaTel mobility footfall insights - FREE public listing';

GRANT USAGE  ON DATABASE NUSATEL_DATA_PRODUCTS               TO SHARE NUSATEL_MOBILITY_FREE_SHARE;
GRANT USAGE  ON SCHEMA   NUSATEL_DATA_PRODUCTS.MOBILITY      TO SHARE NUSATEL_MOBILITY_FREE_SHARE;
GRANT SELECT ON VIEW     NUSATEL_DATA_PRODUCTS.MOBILITY.V_HOURLY_FOOTFALL
                                                             TO SHARE NUSATEL_MOBILITY_FREE_SHARE;
DESC SHARE NUSATEL_MOBILITY_FREE_SHARE;

-- ============================================================
-- SHARE 2: AUDIENCE → PAID Public Listing
-- ============================================================
CREATE OR REPLACE SHARE NUSATEL_AUDIENCE_PAID_SHARE
    COMMENT = 'NusaTel audience segments - PAID public listing';

GRANT USAGE  ON DATABASE NUSATEL_DATA_PRODUCTS               TO SHARE NUSATEL_AUDIENCE_PAID_SHARE;
GRANT USAGE  ON SCHEMA   NUSATEL_DATA_PRODUCTS.AUDIENCE      TO SHARE NUSATEL_AUDIENCE_PAID_SHARE;
GRANT SELECT ON VIEW     NUSATEL_DATA_PRODUCTS.AUDIENCE.V_WEEKLY_SEGMENTS
                                                             TO SHARE NUSATEL_AUDIENCE_PAID_SHARE;
DESC SHARE NUSATEL_AUDIENCE_PAID_SHARE;

-- ============================================================
-- SHARE 3: NETWORK → PRIVATE Listing
-- ============================================================
CREATE OR REPLACE SHARE NUSATEL_NETWORK_PRIVATE_SHARE
    COMMENT = 'NusaTel network coverage - PRIVATE listing';

GRANT USAGE  ON DATABASE NUSATEL_DATA_PRODUCTS               TO SHARE NUSATEL_NETWORK_PRIVATE_SHARE;
GRANT USAGE  ON SCHEMA   NUSATEL_DATA_PRODUCTS.NETWORK       TO SHARE NUSATEL_NETWORK_PRIVATE_SHARE;
GRANT SELECT ON VIEW     NUSATEL_DATA_PRODUCTS.NETWORK.V_DAILY_COVERAGE
                                                             TO SHARE NUSATEL_NETWORK_PRIVATE_SHARE;
DESC SHARE NUSATEL_NETWORK_PRIVATE_SHARE;

-- ============================================================
-- VERIFY ALL SHARES
-- ============================================================
SHOW SHARES LIKE 'NUSATEL%';
