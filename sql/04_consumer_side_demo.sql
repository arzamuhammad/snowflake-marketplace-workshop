-- ============================================================
-- NUSATEL — CONSUMER SIDE DEMO
-- What the consumer sees after getting/subscribing to a listing
-- Run from the CONSUMER account after they "Get" or "Subscribe"
-- ============================================================

-- ============================================================
-- SCENARIO A: Consumer got a FREE listing
-- After clicking "Get" → data is mounted as read-only DB
-- Consumer chose DB name = NUSATEL_MOBILITY
-- ============================================================

-- Explore the data
SELECT * FROM NUSATEL_MOBILITY.MOBILITY.V_HOURLY_FOOTFALL LIMIT 10;

-- Top cities by footfall (yesterday)
SELECT city, province,
       SUM(unique_devices) AS total_footfall,
       ROUND(AVG(avg_dwell_minutes), 1) AS avg_dwell
FROM NUSATEL_MOBILITY.MOBILITY.V_HOURLY_FOOTFALL
WHERE snapshot_date = CURRENT_DATE() - 1
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;

-- Hourly traffic pattern
SELECT hour_of_day,
       SUM(unique_devices) AS total_devices,
       ROUND(AVG(avg_dwell_minutes), 1) AS avg_dwell
FROM NUSATEL_MOBILITY.MOBILITY.V_HOURLY_FOOTFALL
WHERE snapshot_date = CURRENT_DATE() - 1
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- SCENARIO B: Consumer subscribed to PAID listing
-- After Subscribe → accept terms → payment → DB mounted
-- Consumer chose DB name = NUSATEL_AUDIENCE
-- ============================================================

-- Explore
SELECT * FROM NUSATEL_AUDIENCE.AUDIENCE.V_WEEKLY_SEGMENTS LIMIT 10;

-- Segment overview (last 4 weeks)
SELECT segment_name,
       SUM(subscriber_count) AS total_subscribers,
       ROUND(AVG(avg_arpu_usd), 2) AS avg_arpu,
       ROUND(AVG(avg_data_usage_gb), 2) AS avg_data_gb
FROM NUSATEL_AUDIENCE.AUDIENCE.V_WEEKLY_SEGMENTS
WHERE week_start_date >= DATEADD(WEEK, -4, CURRENT_DATE())
GROUP BY 1
ORDER BY 2 DESC;

-- Age x Income cross-tab
SELECT age_group, income_tier,
       SUM(subscriber_count) AS subscribers,
       ROUND(AVG(avg_arpu_usd), 2) AS avg_arpu
FROM NUSATEL_AUDIENCE.AUDIENCE.V_WEEKLY_SEGMENTS
WHERE week_start_date >= DATEADD(WEEK, -4, CURRENT_DATE())
GROUP BY 1, 2
ORDER BY 1, 2;

-- Device market share
SELECT device_brand_top,
       SUM(subscriber_count) AS subscribers,
       ROUND(SUM(subscriber_count) * 100.0 /
             SUM(SUM(subscriber_count)) OVER(), 2) AS market_share_pct
FROM NUSATEL_AUDIENCE.AUDIENCE.V_WEEKLY_SEGMENTS
WHERE week_start_date >= DATEADD(WEEK, -4, CURRENT_DATE())
GROUP BY 1
ORDER BY 2 DESC;


-- ============================================================
-- KEY NOTES FOR CONSUMERS:
-- ============================================================
-- 1. Shared data is READ-ONLY (no INSERT/UPDATE/DELETE)
-- 2. Consumer pays their OWN compute (warehouse) cost
-- 3. For paid listings, subscription fee on Snowflake bill
-- 4. Data refreshes on provider's schedule
-- 5. To stop: DROP DATABASE NUSATEL_MOBILITY;
-- ============================================================
