# Snowflake Marketplace Workshop

Hands-on workshop for publishing data products on **Snowflake Marketplace** — covering **free / paid** listings on **public / private** marketplaces, using a fictional telco company **NusaTel** as the demo data provider.

## What You'll Learn

- Prepare data products with Secure Views and Secure Shares
- Create a Provider Profile
- Publish a **FREE Public** listing on Snowflake Marketplace
- Publish a **PAID Public** listing with pricing plan + offer (monetization)
- Publish a **FREE Private** listing to a specific consumer account
- Publish a **PAID Private** listing
- Manage listings programmatically via SQL
- Understand the consumer experience (Get / Subscribe)

## Repository Structure

```
.
├── README.md                            ← you are here
├── tutorial.md                          ← step-by-step UI walkthrough (no SQL required)
└── sql/
    ├── 01_setup_dummy_data.sql          ← create NusaTel database + 3 datasets (~23K rows)
    ├── 02_create_shares.sql             ← 3 secure shares (free/paid/private scenarios)
    ├── 03_create_listings_sql.sql       ← programmatic listing creation
    └── 04_consumer_side_demo.sql        ← what the consumer queries after Get/Subscribe
```

## Demo Datasets (NusaTel)

| Dataset | Schema | Rows | Description |
|---|---|---|---|
| Mobility Footfall | `MOBILITY.V_HOURLY_FOOTFALL` | 10,000 | Hourly anonymized foot traffic by city/district |
| Audience Segments | `AUDIENCE.V_WEEKLY_SEGMENTS` | 5,000 | Weekly demographics, ARPU, device, segment |
| Network Coverage | `NETWORK.V_DAILY_COVERAGE` | 8,000 | Daily 4G/5G tower performance & signal metrics |

## Quick Start

### 1. Setup data (admin, ~30 seconds)

```sql
-- Run as ACCOUNTADMIN in a Snowflake worksheet
-- Path: sql/01_setup_dummy_data.sql
```

### 2. Create shares (admin)

```sql
-- Path: sql/02_create_shares.sql
```

### 3. Follow the workshop

Open `tutorial.md` and follow the **Snowsight UI** walkthrough — no SQL required for the listing creation steps.

## Workshop Flow

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Setup Data  │ -> │ Create Share │ -> │Create Listing│ -> │   Publish    │
│   (SQL)      │    │  (SQL or UI) │    │   (UI)       │    │   (UI)       │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
                                              │
                              ┌───────────────┼───────────────┐
                              v               v               v
                          Free Public    Paid Public    Private (Free/Paid)
```

## Listing Types Covered

| Type | Visibility | Payment | Use Case |
|---|---|---|---|
| Free Public | Everyone on Marketplace | No | Ecosystem engagement, lead-gen |
| Paid Public | Everyone on Marketplace | Subscribe + pay | Direct monetization |
| Free Private | Specified accounts only | No | Subsidiary / partner sharing |
| Paid Private | Specified accounts only | Subscribe + pay | Enterprise B2B contracts |

## Prerequisites

- Snowflake account (Enterprise edition or higher recommended)
- `ACCOUNTADMIN` role
- Accepted Snowflake Provider & Consumer Terms (Snowsight → Admin → Terms & Billing)
- For paid listings: contact your Snowflake AE for monetization onboarding

## References

- [Snowflake Marketplace docs](https://docs.snowflake.com/en/collaboration/collaboration-marketplace-about)
- [Create and publish a listing](https://docs.snowflake.com/en/collaboration/provider-listings-creating-publishing)
- [Manage listings using SQL](https://docs.snowflake.com/en/progaccess/listing-progaccess-about)
- [Pricing plans and offers](https://docs.snowflake.com/en/user-guide/collaboration/listings/pricing-plans-offers/pricing-plans-and-offers)

## License

MIT — feel free to adapt for your own workshops.

---

*Built for Snowflake customer workshops — May 2026.*
