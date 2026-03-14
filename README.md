# Product Analytics — dbt Project

A dbt data engineering project for product analytics, built on DuckDB.

## Architecture

```
seeds (raw CSVs) → staging (cleaned views) → marts (business-ready tables)
```

### Seeds
| File | Description |
|------|-------------|
| `raw_events.csv` | Clickstream events (page views, signups, button clicks) |
| `raw_users.csv` | User profiles with plan type |
| `raw_orders.csv` | Order transactions |

### Staging Models
| Model | Description |
|-------|-------------|
| `stg_events` | Cleaned events with surrogate key and typed timestamps |
| `stg_users` | Normalized user profiles |
| `stg_orders` | Standardized order data |

### Mart Models
| Model | Description |
|-------|-------------|
| `dim_users` | User dimension with activity summary and lifetime value |
| `fct_user_activity` | Daily user activity (events, sessions, page views, clicks) |
| `fct_orders` | Orders enriched with user data |

## Setup

```bash
pip install dbt-core dbt-duckdb
```

## Usage

```bash
dbt deps          # install packages
dbt seed          # load sample data
dbt run           # build models
dbt test          # run data quality tests (22 tests)
```

Or run the full pipeline:

```bash
dbt seed && dbt run && dbt test
```

## Tech Stack
- **dbt** — data transformation framework
- **DuckDB** — local analytical database
- **dbt_utils** — surrogate key generation
