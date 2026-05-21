-- ============================================================
-- NUSATEL — CREATE LISTINGS VIA SQL (Programmatic)
-- Run AFTER 02_create_shares.sql
-- ============================================================

USE ROLE ACCOUNTADMIN;

-- ============================================================
-- LISTING 1: FREE PRIVATE LISTING
-- Share mobility data with a specific consumer account
-- Replace CONSUMER_ORG.CONSUMER_ACCOUNT with real values
-- ============================================================
CREATE EXTERNAL LISTING NUSATEL_MOBILITY_FREE_PRIVATE
SHARE NUSATEL_MOBILITY_FREE_SHARE AS
$$
title: "Indonesia Mobility Footfall Insights"
subtitle: "Hourly anonymized foot traffic across major Indonesian cities"
description: |
  NusaTel mobility data providing hourly anonymized device counts,
  dwell times, and flow patterns across Indonesia's top cities.

  ## Included Data
  - Hourly unique device counts by province/city/district
  - Average dwell time in minutes
  - Inflow/outflow device patterns
  - H3 resolution-7 spatial aggregation
  - 30 days rolling history

  ## Use Cases
  - Retail site selection & foot traffic benchmarking
  - OOH advertising planning
  - Urban mobility & transport analysis
  - Event impact measurement

listing_terms:
  type: "OFFLINE"
targets:
  accounts: ["YOURORG.CONSUMER_ACCOUNT"]
usage_examples:
  - title: "Top cities by daily footfall"
    description: "Aggregate unique devices per city for yesterday"
    query: |
      SELECT city, province, SUM(unique_devices) AS total_devices
      FROM V_HOURLY_FOOTFALL
      WHERE snapshot_date = CURRENT_DATE() - 1
      GROUP BY 1, 2 ORDER BY 3 DESC LIMIT 10;
  - title: "Hourly traffic pattern - Jakarta"
    description: "See how foot traffic changes throughout the day"
    query: |
      SELECT hour_of_day, AVG(unique_devices) AS avg_devices,
             ROUND(AVG(avg_dwell_minutes), 1) AS avg_dwell
      FROM V_HOURLY_FOOTFALL
      WHERE city = 'Jakarta Selatan'
        AND snapshot_date >= CURRENT_DATE() - 7
      GROUP BY 1 ORDER BY 1;
$$
PUBLISH = TRUE
REVIEW = FALSE;

-- ============================================================
-- LISTING 2: FREE PUBLIC LISTING (Marketplace)
-- Needs Snowflake approval → create as DRAFT (PUBLISH=FALSE)
-- ============================================================
CREATE EXTERNAL LISTING NUSATEL_NETWORK_FREE_PUBLIC
SHARE NUSATEL_NETWORK_PRIVATE_SHARE AS
$$
title: "Indonesia 4G/5G Network Coverage Analytics"
subtitle: "Daily tower performance, signal quality, and coverage metrics"
description: |
  Free network coverage dataset from NusaTel providing daily
  aggregated performance metrics.

  ## Schema
  | Column | Description |
  |--------|-------------|
  | report_date | Daily snapshot date |
  | province / city | Location |
  | tower_id | Anonymized tower ID |
  | technology | 4G LTE / 5G NR / LTE-A |
  | avg_download_mbps | Average download speed |
  | avg_latency_ms | Average latency |
  | availability_pct | Tower uptime % |

listing_terms:
  type: "OFFLINE"
targets:
  regions: ["ALL"]
usage_examples:
  - title: "Average speed by technology"
    description: "Compare 4G vs 5G performance"
    query: |
      SELECT technology,
             ROUND(AVG(avg_download_mbps), 2) AS avg_download,
             ROUND(AVG(avg_latency_ms), 1) AS avg_latency
      FROM V_DAILY_COVERAGE
      WHERE report_date >= CURRENT_DATE() - 7
      GROUP BY 1 ORDER BY 2 DESC;
$$
PUBLISH = FALSE
REVIEW = FALSE;

-- ============================================================
-- MANAGEMENT COMMANDS (for demo)
-- ============================================================

-- Show all listings
SHOW LISTINGS LIKE 'NUSATEL%';

-- Describe a listing
DESC LISTING NUSATEL_MOBILITY_FREE_PRIVATE;

-- Alter (update manifest)
-- ALTER LISTING NUSATEL_MOBILITY_FREE_PRIVATE AS
-- $$
-- title: "Indonesia Mobility Footfall Insights v2"
-- ...
-- targets:
--   accounts: ["YOURORG.ACCOUNT1", "ANOTHERORG.ACCOUNT2"]
-- $$;

-- Publish a draft listing
-- ALTER LISTING NUSATEL_NETWORK_FREE_PUBLIC PUBLISH;

-- Unpublish (pause access)
-- ALTER LISTING NUSATEL_MOBILITY_FREE_PRIVATE UNPUBLISH;

-- Drop (must unpublish first)
-- ALTER LISTING NUSATEL_MOBILITY_FREE_PRIVATE UNPUBLISH;
-- DROP LISTING IF EXISTS NUSATEL_MOBILITY_FREE_PRIVATE;
