# Snowflake Marketplace Workshop — Step-by-Step Tutorial (UI Only)

> **Company:** NusaTel (fictional telco)  
> **Audience:** Non-technical / business users who prefer Snowsight UI  
> **Goal:** Learn to publish data products on Snowflake Marketplace (free + paid, public + private)

---

## Table of Contents

1. [Overview — What We Will Build](#1-overview)
2. [Prerequisites](#2-prerequisites)
3. [Part A — Prepare the Data Product](#3-part-a--prepare-the-data-product)
4. [Part B — Create a Provider Profile](#4-part-b--create-a-provider-profile)
5. [Part C — Publish a FREE Public Listing](#5-part-c--publish-a-free-public-listing)
6. [Part D — Publish a PAID Public Listing](#6-part-d--publish-a-paid-public-listing)
7. [Part E — Publish a FREE Private Listing](#7-part-e--publish-a-free-private-listing)
8. [Part F — Publish a PAID Private Listing](#8-part-f--publish-a-paid-private-listing)
9. [Part G — Consumer Experience (How Buyers Access Data)](#9-part-g--consumer-experience)
10. [Part H — Monitor Usage & Revenue](#10-part-h--monitor-usage--revenue)
11. [Cleanup](#11-cleanup)
12. [FAQ](#12-faq)

---

## 1. Overview

In this workshop you will publish **4 types of listings** using ONLY the Snowsight web UI:

| # | Listing Type | Visibility | Payment |
|---|---|---|---|
| 1 | Free Public | Everyone on Snowflake Marketplace | No charge |
| 2 | Paid Public | Everyone on Snowflake Marketplace | Must subscribe & pay |
| 3 | Free Private | Only specified consumer accounts | No charge |
| 4 | Paid Private | Only specified consumer accounts | Must subscribe & pay |

**Data products** (already loaded by your admin via SQL script `01_setup_dummy_data.sql`):

| Dataset | Schema | Description |
|---|---|---|
| Mobility Footfall | `NUSATEL_DATA_PRODUCTS.MOBILITY` | Hourly anonymized foot traffic by city |
| Audience Segments | `NUSATEL_DATA_PRODUCTS.AUDIENCE` | Weekly demographics & subscriber segments |
| Network Coverage | `NUSATEL_DATA_PRODUCTS.NETWORK` | Daily tower performance & signal metrics |

---

## 2. Prerequisites

Before you begin, make sure:

### Basic Prerequisites (for FREE listings)

- [ ] You are signed in to **Snowsight** (app.snowflake.com)
- [ ] You are using the **ACCOUNTADMIN** role (top-left role selector)
- [ ] The database `NUSATEL_DATA_PRODUCTS` exists with data (admin runs the setup SQL)
- [ ] You have accepted the **Snowflake Provider & Consumer Terms**:
  - Snowsight → **Admin** → **Billing & Terms** → accept the Provider terms
  - Or via avatar (top-right) → **My Profile** → **Snowflake Provider Terms**

### Additional Prerequisites for PAID Listings

> ⚠️ **Important:** The "Paid" option in Access Type **will not appear** in your dropdown until ALL of these are completed. If you only see "Free" and "Trial" options, it means one of these is missing.

| # | Prerequisite | Where to verify |
|---|---|---|
| 1 | **Accept Provider Terms (Monetization version)** | Snowsight → Admin → Billing & Terms → accept the latest Marketplace Provider Terms |
| 2 | **Provider Profile approved** by Snowflake (not Draft) | Provider Studio → Profiles → status column shows "Approved" |
| 3 | **Monetization Onboarding case** completed with Snowflake Marketplace Operations | Submit a case at https://snowforce.my.site.com/s/provider-onboarding-case |
| 4 | **Tax & banking information** submitted (W-9 / W-8BEN, payout account) | Configured by Snowflake during onboarding |
| 5 | **Account is a paying customer** (not a free Snowflake trial account) | Admin → Billing → check edition |

### Region Considerations

| Region | Paid Listings Supported? |
|---|---|
| AWS standard regions (US, EU, AP, **Jakarta AP_SOUTHEAST_3**) | ✅ Yes (after onboarding) |
| Azure standard regions | ✅ Yes |
| GCP standard regions | ✅ Yes |
| VPS (Virtual Private Snowflake) | ❌ Cannot create paid listings |
| US Government regions | ⚠️ Restricted |

> Region by itself is NOT a blocker for Jakarta AWS — but onboarding still required.

### Onboarding Timeline (for Paid)

```
1. Contact your Snowflake AE / Business Development partner
   ↓
2. Submit Marketplace Operations case
   ↓
3. Sign monetization addendum (legal agreement)
   ↓
4. Provide tax forms + banking details
   ↓
5. Snowflake enables paid listings (~1-2 weeks)
   ↓
6. "Paid" option appears in Access Type dropdown
```

### What If Paid Is Not Available Yet?

For workshops or demos before paid is enabled, use these alternatives:

| Goal | Workaround |
|---|---|
| Show paid-like consumer flow | Use **Trial** access type (Limited Trial / Limited Usage Trial) — UI flow is similar |
| Demonstrate pricing concept | Show pricing plan UI screenshots from Snowflake docs |
| Real revenue generation | Must complete onboarding first |

---

## 3. Part A — Prepare the Data Product

The data is already loaded. We now need to create a **Secure Share** — the container that packages objects for sharing.

### Step A1: Open Provider Studio

1. In the left navigation menu, click **Marketplace**
2. Click **Provider Studio** (at the top)

### Step A2: Understand Shares

A "Secure Share" is created automatically when you create a listing and select database objects. You do NOT need to create shares manually via SQL — Provider Studio does it for you.

> **Key point:** When you create a listing and click "+ Select" to pick objects, Snowflake auto-creates a share behind the scenes.

---

## 4. Part B — Create a Provider Profile

A Provider Profile is your **brand identity** visible to consumers. Required for all Marketplace and paid listings.

### Steps:

1. In **Provider Studio**, click the **Profiles** tab (top navigation)
2. Click **+ Create Profile**
3. The **Create Profile** dialog opens. Fill in each field as explained below.

### Field-by-Field Guide

#### 1. Company Icon *(optional but highly recommended)*
The logo displayed next to your listings on Marketplace.
- **Format:** square PNG (1:1 ratio), recommended 256×256 px or larger
- **Background:** transparent or solid (avoid small text)
- If skipped, a gray placeholder is shown — looks unprofessional

#### 2. Company Name *(required)*
The brand name consumers see on Marketplace.
- Max ~50 characters
- Use your business brand name, NOT your Snowflake account name
- **Example:** `NusaTel Data`

#### 3. Company Description *(required)*
2-3 sentences describing your company and what data you offer.
- Must be at least 2-3 sentences
- Explain what your organization does + what you intend to offer on Marketplace
- ⚠️ Must NOT direct consumers off-platform (no "visit our website to buy")
- **Example:** `Indonesia's innovative telco — mobility, audience, and network insights from 80M+ subscribers.`

#### 4. Consumer Contact Email *(required)*
The email consumers see when they have questions about your data.
- **Best practice:** use a **group email alias** with your business domain
  - Good: `data-partnerships@nusatel.co.id`, `marketplace@nusatel.co.id`
  - OK for demo: your personal email
- Don't use a personal email in production — depends on one person being available

#### 5. Support Link or Email *(optional but recommended)*
Link to a dedicated support page or support group email.
- Can be a URL: `https://nusatel.co.id/data-support`
- Or an email: `data-support@nusatel.co.id`
- **Difference from Consumer Contact:**
  - Consumer Contact = pre-sales / general inquiries
  - Support = post-sales / technical issues

#### 6. Privacy Link *(optional)*
Link to your company's privacy policy / terms of use page.
- **Example:** `https://nusatel.co.id/privacy`
- Important if your data involves any PII or consumer behavioral data
- For demo, you may use a placeholder: `https://www.snowflake.com/privacy-policy/`

#### 7. Business Contact Email *(required for paid listings)*
Email of your business / commercial team. Snowflake sends notifications about:
- Listing approval / denial
- Consumer subscriptions to paid listings
- Revenue and payout updates
- **Example:** `business@nusatel.co.id`

#### 8. Technical Contact Email *(required)*
Email of your technical / data engineering team. Snowflake sends notifications about:
- Share or replication issues
- Auto-fulfillment failures
- Data quality alerts
- **Example:** `data-engineering@nusatel.co.id`
- It's OK for Business Contact and Technical Contact to be the same email for small teams

### Demo Copy-Paste Values (for NusaTel workshop)

| Field | Value |
|---|---|
| Company Icon | Upload any square PNG logo |
| Company Name | `NusaTel Data` |
| Company Description | `Indonesia's innovative telco — mobility, audience, and network insights from 80M+ subscribers.` |
| Consumer Contact Email | `your.email@domain.com` |
| Support Link or Email | `support@nusatel.co.id` |
| Privacy Link | `https://www.snowflake.com/privacy-policy/` |
| Business Contact Email | `your.email@domain.com` |
| Technical Contact Email | `your.email@domain.com` |

4. Click **Next** to continue, then confirm and **Save** the profile.

> You only need ONE profile. It can be reused across many listings.

---

## 5. Part C — Publish a FREE Public Listing

**Scenario:** NusaTel publishes network coverage data for free — for ecosystem engagement and lead generation.

> **New UI:** The current Provider Studio shows a **Publishing Checklist** sidebar on the right. Each item turns green ✓ as you complete it. The **Submit for approval** button activates only when all required items are green.

### Step C1: Start Creating the Listing

1. Go to **Provider Studio** → **Listings** tab
2. Click **+ Create Listing**
3. Select **Snowflake Marketplace** (this makes it public)

### Step C2: Listing Title

- Enter title at the top: `Indonesia 4G/5G Network Coverage Analytics - DEMO`
- ✓ This auto-marks **"Add listing name"** in the checklist

### Step C3: Add Subtitle

- Click **"Add subtitle"** below the title
- Example: `Daily 4G/5G tower performance and signal quality metrics across Indonesia`
- ✓ Auto-marks **"Add subtitle"**

### Step C4: Select Publishing Profile

- In the profile selector below the title, choose **NusaTel Data**
- ✓ Auto-marks **"Select publishing profile"**

### Step C5: Add Data Product (top-right blue card)

1. Click the blue **Add data product** button
2. Click **+ Select**
3. Navigate: `NUSATEL_DATA_PRODUCTS` → `NETWORK` → check `V_DAILY_COVERAGE`
4. Click **Done**
- ✓ Auto-marks **"Select product type"**

### Step C6: Select Access Type

- The **Access type** dropdown (under data product) becomes active
- Select **Free**
- ✓ Auto-marks **"Select access type"**

### Step C7: Description Tile

- Click the **Description** tile in the canvas
- Paste:
```
Free network coverage dataset from NusaTel providing daily aggregated
tower performance metrics across Indonesia.

## What's Included
- Daily tower performance (signal, throughput, latency)
- Technology breakdown (4G LTE, 5G NR, LTE-A)
- Coverage availability percentage
- Geospatial coordinates per tower
- 30 days rolling history, refreshed daily

## Use Cases
- Network benchmarking
- Coverage gap analysis
- Infrastructure planning
- Competitive research
```
- Click **Save**
- ✓ Auto-marks **"Add description"**

### Step C8: Categories Tile

- Click **Add category**
- Select up to 3 categories, e.g.: **Telecom**, **Geospatial**, **Marketing**
- Click **Save**
- ✓ Auto-marks **"Select up to 3 categories"**

### Step C9: Business Needs Tile

- Click **Add up to 6 business needs**
- Select predefined tags from the list, e.g.:
  - Audience Targeting
  - Geographic Analysis
  - Network Performance
  - Risk Management
- Click **Save**
- ✓ Auto-marks **"Add business needs"**

### Step C10: Quick Start Examples Tile

- Click **Add quick start examples**
- Click **+ SQL Example**
- Add Example 1:
  - **Title:** `Average download speed by technology`
  - **Query:**
    ```sql
    SELECT technology,
           ROUND(AVG(avg_download_mbps), 2) AS avg_download_mbps,
           ROUND(AVG(avg_latency_ms), 1) AS avg_latency_ms
    FROM V_DAILY_COVERAGE
    WHERE report_date >= CURRENT_DATE() - 7
    GROUP BY 1 ORDER BY 2 DESC;
    ```
- Add Example 2:
  - **Title:** `City coverage ranking`
  - **Query:**
    ```sql
    SELECT city, province,
           COUNT(DISTINCT tower_id) AS tower_count,
           ROUND(AVG(availability_pct), 2) AS avg_availability
    FROM V_DAILY_COVERAGE
    GROUP BY 1, 2
    ORDER BY 4 DESC;
    ```
- Click **Save**
- ✓ Auto-marks **"Fill in Quick Start examples"**

### Step C11: Documentation Tile

- Click **Add documentation**
- Add a link entry:
  - **Type:** Documentation
  - **URL:** `https://nusatel.co.id/data-docs` (placeholder OK for demo)
- Click **Save**
- ✓ Auto-marks **"Add links to Documentation"**

### Step C12: Legal Terms Tile

- Click **Add legal terms**
- Choose one:
  - **Snowflake Standard Terms** (recommended for public listings)
  - **Custom Terms** (upload your own MSA / data licensing PDF)
  - **Offline** (handled outside Snowflake)
- Click **Save**
- ✓ Auto-marks **"Add legal terms"**

### Step C13: Attributes Tile

- Click **Add attributes**
- Fill in metadata fields, example:
  - **Refresh frequency:** Daily
  - **Time period:** Last 30 days
  - **Data source:** First-party (NusaTel)
  - **Geographic coverage:** Indonesia
  - **Number of records:** ~8,000 daily snapshots
- Click **Save**
- ✓ Auto-marks **"Fill in the Attributes section"**

### Step C14: Data Dictionary Tile *(optional but recommended)*

- Click **Add featured objects from the data dictionary**
- Select the view `V_DAILY_COVERAGE`
- Check important columns: `technology`, `avg_download_mbps`, `avg_latency_ms`, `availability_pct`
- Add a description for each column
- Click **Save**

### Step C15: Region Availability Tile

- Click **Set region availability**
- Choose **All Regions** for global reach
  - Or select **Custom regions** → tick AP Southeast (Singapore, Jakarta) only
- Click **Save**
- ✓ Auto-marks **"Specify regional availability"**

### Step C16: Video Tile *(optional, skip if none)*

- Click **Add video** if you have a YouTube/Vimeo demo URL
- Otherwise skip — this is optional

### Step C17: Preview Your Listing

- Click **Preview** at the top-right to see how consumers will see the listing
- Verify title, subtitle, description, sample queries, etc.

### Step C18: Submit for Approval

- Once **all checklist items are green** ✓, the **Submit for approval** button (top-right) becomes active (bright blue)
- Click **Submit for approval**
- Snowflake Marketplace team reviews your listing (typically 1-3 business days)

### Step C19: Publish (After Approval)

- You'll receive an email when approved
- Go back to **Provider Studio** → **Listings** → click your listing
- The button now reads **Publish** — click it
- Your listing is now LIVE on Snowflake Marketplace! 🎉

> **Note for workshop:** For demo purposes you can stop at Step C18 (Submit for approval). Real approval takes 1-3 days. Or use a **Private Listing** (Part E) which publishes instantly without approval.

---

## 6. Part D — Publish a PAID Public Listing

**Scenario:** NusaTel monetizes Audience Segments — consumers must subscribe and pay before querying.

### Step D1: Start Creating the Listing

1. **Provider Studio** → **+ Create Listing** → **Snowflake Marketplace**

### Step D2: Basic Information

| Field | Value |
|---|---|
| Title | `Indonesia Audience Segments & Demographics` |
| Subtitle | `Weekly subscriber segments with ARPU, device, age, income insights` |
| Profile | `NusaTel Data` |

### Step D3: Attach Data Product

1. Click **Add data product** → **+ Select**
2. Navigate to `NUSATEL_DATA_PRODUCTS` → `AUDIENCE` → select `V_WEEKLY_SEGMENTS`
3. Click **Done**

### Step D4: Set Access Type

- Select **Paid**

> ⚠️ Once you select "Paid", you cannot change it back to "Free" without deleting the draft.

### Step D5: Add Description, Dictionary, Examples

Same process as Part C — add a rich description, data dictionary entries, and sample queries.

### Step D6: Configure Pricing Plan

1. Scroll down to the **Pricing** section
2. Click **Create pricing plan**
3. **Settings dialog:**
   - Display name: `NusaTel Audience - Standard Plan`
   - Click **Next**
4. **Pricing details dialog — choose one:**

**Option A: Usage-based pricing**

| Field | Example |
|---|---|
| Pricing model | Usage-based |
| Monthly access fee | `USD 5,000` |
| Cost per query | `USD 0.50` |
| Included queries | `5,000` (per month) |
| Max monthly charge | `USD 25,000` (optional cap) |

**Option B: Flat fee pricing**

| Field | Example |
|---|---|
| Pricing model | Flat fee |
| Flat fee amount | `USD 60,000` |
| Billing frequency | `Annual` |

5. Click **Next** → review **Summary** → click **Done**

### Step D7: Create an Offer

1. Click the **Offers** tab
2. Click **+ Create offer**
3. **Offer details:**

| Field | Value |
|---|---|
| Offer type | Standard offer |
| Purchase type | **Self-serve** (consumer sees price, clicks Subscribe) |
| | or **Sales-led** (consumer must request, you negotiate) |
| Offer name | `Standard Annual Access` |

4. Click **Next**

5. **Billing and payments:**

| Field | Value |
|---|---|
| Pricing plan | Select `NusaTel Audience - Standard Plan` |
| Contract type | **Recurring (Subscription)** or **Limited-time** |
| Contract duration | `12 months` |
| Payment options | Charge per pricing plan (or accept installments) |
| First invoice | On acceptance |

6. Click **Next**

7. **Description (consumer-facing):**

| Field | Value |
|---|---|
| Offer display name | `Annual Subscription — Audience Insights` |
| Display price | `Starting at USD 5,000/month` |
| Tagline | `Unlock Indonesia's richest audience intelligence` |
| Button text | `Subscribe Now` |
| Value propositions | - 80M+ subscriber insights |
| | - Weekly refresh |
| | - 6 audience segments |
| | - Demographics + device + ARPU |

8. Click **Next** → **Done**

### Step D8: (Optional) Add a Trial

1. Back on listing page, scroll to **Trial (optional)**
2. Select trial type:
   - **Limited usage** — e.g., 50 free queries
   - **Limited time** — e.g., 14-day trial
   - **Limited functionality** — expose only 1 column subset
3. Click **Save**

### Step D9: Submit & Publish

1. Click **Submit for Approval**
2. Wait for Snowflake review (1-3 days)
3. After approval → **Publish**

> Consumers will now see pricing and must click "Subscribe" → accept → pay → then data unlocks.

---

## 7. Part E — Publish a FREE Private Listing

**Scenario:** NusaTel shares mobility data with a specific partner (e.g., a bank or agency) for free.

### Step E1: Start Creating

1. **Provider Studio** → **+ Create Listing** → **Specified Consumers**

### Step E2: Basic Information

| Field | Value |
|---|---|
| Title | `NusaTel Mobility Insights — Partner Access` |

### Step E3: Attach Data Product

1. Click **Add data product** → **+ Select**
2. Select `NUSATEL_DATA_PRODUCTS` → `MOBILITY` → `V_HOURLY_FOOTFALL`
3. Click **Done**

### Step E4: Access Type

- Select **Free**

### Step E5: Add Consumer Accounts

1. In the **Who can access** section
2. Enter the consumer's **Organization name** and **Account name**
   - Format: `ORGNAME.ACCOUNTNAME`
   - Example: `MANDIRI_ORG.ANALYTICS_PROD`
3. You can add multiple consumer accounts

> **How to find a consumer's Org.Account:**  
> Ask the consumer to run in their Snowflake:  
> `SELECT CURRENT_ORGANIZATION_NAME() || '.' || CURRENT_ACCOUNT_NAME();`

### Step E6: Cross-Region (if applicable)

If the consumer is in a different Snowflake region:
1. Snowflake shows an **Auto-fulfillment** section
2. Set refresh interval (e.g., `24 hours`)
3. Select a warehouse for replication

### Step E7: Add Description

Write a description explaining what data is shared and the refresh schedule.

### Step E8: Legal Terms

Select terms or mark as "Offline" (handled outside Snowflake).

### Step E9: Publish

1. Click **Publish**
2. The listing is **immediately** delivered to the specified consumer accounts
3. Consumer sees it under their **Marketplace → Private Sharing** tab

> No Snowflake approval needed for private listings — publishes instantly!

---

## 8. Part F — Publish a PAID Private Listing

**Scenario:** NusaTel sells audience data privately to a specific bank partner.

### Step F1: Start Creating

1. **Provider Studio** → **+ Create Listing** → **Specified Consumers**

### Step F2: Basic Information

| Field | Value |
|---|---|
| Title | `NusaTel Audience Intelligence — Bank Partner` |

### Step F3: Attach Data Product

1. Select `NUSATEL_DATA_PRODUCTS` → `AUDIENCE` → `V_WEEKLY_SEGMENTS`

### Step F4: Access Type

- Select **Paid**

### Step F5: Add Consumer Accounts

- Enter the consumer's Org.Account identifier

### Step F6: Configure Pricing

Same process as Part D (Steps D6 + D7):
1. Create a **Pricing Plan** (usage-based or flat fee)
2. Create an **Offer** (self-serve or sales-led, contract duration, payment terms)

### Step F7: Add Description & Terms

Fill in description, legal terms.

### Step F8: Publish

1. Click **Publish**
2. Consumer receives notification and can see the listing under **Private Sharing**
3. Consumer must accept the offer and pay before accessing the data

---

## 9. Part G — Consumer Experience

### How a consumer accesses a FREE listing:

1. Consumer logs in to Snowsight
2. Goes to **Marketplace** (left nav)
3. For public: searches "NusaTel" → finds the listing
4. For private: goes to **Marketplace → Private Sharing** tab → sees the listing
5. Clicks **Get**
6. Chooses a **database name** (e.g., `NUSATEL_MOBILITY`) and **roles** that can access it
7. Clicks **Get** to confirm
8. A read-only database appears instantly in their account
9. Consumer can now run: `SELECT * FROM NUSATEL_MOBILITY.MOBILITY.V_HOURLY_FOOTFALL LIMIT 10;`

### How a consumer accesses a PAID listing:

1. Same discovery steps as above
2. Consumer sees the **price** on the listing page
3. Clicks **Subscribe** (self-serve) or **Request** (sales-led)
4. For self-serve:
   - Reviews offer terms (price, duration, payment schedule)
   - Clicks **Accept & Subscribe**
   - Provides billing info (Snowflake adds the charge to their bill)
5. For sales-led:
   - Consumer clicks **Request**
   - Provider receives the request in Provider Studio
   - Provider and consumer negotiate offline
   - Provider approves the request
6. After payment is confirmed → data unlocks
7. A read-only database appears in the consumer's account
8. Consumer can now query

### Important notes for consumers:

- Data is **read-only** — no INSERT, UPDATE, DELETE
- Consumer pays their **own warehouse compute** to run queries
- For paid listings, the subscription fee appears on their **Snowflake invoice**
- Data refreshes are controlled by the provider
- To stop access: consumer can drop the imported database

---

## 10. Part H — Monitor Usage & Revenue

### In Provider Studio:

1. Go to **Provider Studio** → **Listings** tab
2. Click on any published listing
3. Click the **Analytics** tab

You can see:
- Number of consumers who installed the listing
- Query volume per consumer
- Most queried objects and columns
- Revenue earned (for paid listings)
- Geographic distribution of consumers

### Email Notifications:

Snowflake sends emails to the contacts in your Provider Profile when:
- A consumer gets your free listing
- A consumer subscribes to your paid listing
- A listing is approved/denied
- A consumer requests access (sales-led)

---

## 11. Cleanup

To remove listings after the workshop:

1. Go to **Provider Studio** → **Listings**
2. Click on the listing
3. If published: click **Unpublish** first
4. Then click **Delete** (trash icon)

To remove the demo data:
- Ask your admin to run:
```sql
DROP DATABASE IF EXISTS NUSATEL_DATA_PRODUCTS;
DROP SHARE IF EXISTS NUSATEL_MOBILITY_FREE_SHARE;
DROP SHARE IF EXISTS NUSATEL_AUDIENCE_PAID_SHARE;
DROP SHARE IF EXISTS NUSATEL_NETWORK_PRIVATE_SHARE;
```

---

## 12. FAQ

**Q: Do I need to know SQL to publish on Marketplace?**  
A: No! The entire process can be done through the Snowsight UI. Your data team handles the initial data setup, then business users can manage listings via Provider Studio.

**Q: How long does Marketplace approval take?**  
A: Typically 1-3 business days for public Marketplace listings. Private listings publish instantly.

**Q: Can I change a Free listing to Paid?**  
A: No. You must create a new listing. Plan your pricing model before creating.

**Q: Who pays for cross-region replication (auto-fulfillment)?**  
A: The provider (you) pays for auto-fulfillment costs.

**Q: Can consumers modify or copy my data?**  
A: No. Shared data is read-only. They cannot copy, export, or modify it. They can only SELECT from it.

**Q: How does Snowflake handle payment for paid listings?**  
A: Snowflake collects payment from the consumer (added to their Snowflake bill), takes a platform fee, and pays the provider monthly via wire transfer.

**Q: Can I offer a trial?**  
A: Yes! You can offer limited-usage trials (N free queries), limited-time trials, or limited-functionality trials.

**Q: What if my consumer is in a different cloud/region?**  
A: Snowflake auto-fulfillment handles cross-region and cross-cloud delivery automatically. You just set the refresh interval.

**Q: Can I see who queried my data?**  
A: Yes. Provider Studio → Analytics shows per-consumer query volume, frequency, and which objects they query most.

**Q: What objects can I share?**  
A: Tables, views (including secure views), UDFs, stored procedures, and even Snowflake Native Apps.

---

## Quick Reference Card

| Action | Where in Snowsight |
|---|---|
| Create Provider Profile | Marketplace → Provider Studio → Profiles → + Create |
| Create Public Listing | Provider Studio → + Create Listing → Snowflake Marketplace |
| Create Private Listing | Provider Studio → + Create Listing → Specified Consumers |
| Set Free access | Access type dropdown → Free |
| Set Paid access | Access type dropdown → Paid |
| Add pricing plan | Listing → Pricing section → Create pricing plan |
| Create offer | Listing → Offers tab → + Create offer |
| Submit for approval | Listing page → Submit for Approval (public only) |
| Publish | Listing page → Publish |
| View analytics | Provider Studio → Listings → [listing] → Analytics |
| Consumer: get free data | Marketplace → search → Get |
| Consumer: subscribe paid | Marketplace → search → Subscribe → Accept |

---

*Workshop prepared for NusaTel Data Marketplace Demo — May 2026*
