# Online Retail Analytics with PostgreSQL and Python

An end-to-end customer and revenue analytics project using **541,909 real transaction lines** from a UK-based online retailer.

The project replaces a small mock database with a reproducible pipeline for transaction cleaning, KPI calculation, customer segmentation and PostgreSQL analysis.

## Business questions

- How much net revenue is generated, and how does it change over time?
- Which products and countries contribute the most revenue?
- What is the cancellation and returns burden?
- Which customers are recent, frequent and high-value?
- Which customer segments should receive retention, reactivation or loyalty campaigns?

## Dataset

- **Source:** [UCI Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)
- **DOI:** [10.24432/C5BW33](https://doi.org/10.24432/C5BW33)
- **License:** CC BY 4.0
- **Period:** 1 December 2010 to 9 December 2011
- **Scale:** 541,909 line items
- **Business:** UK-based non-store retailer selling giftware
- **Fields:** invoice, product, description, quantity, timestamp, unit price, customer and country

Raw data is retrieved from UCI and is not duplicated in this repository.

## Analytical workflow

1. Standardize column names and data types.
2. Identify cancellations from invoice numbers beginning with `C`.
3. Separate gross activity from valid positive-quantity sales.
4. Calculate line revenue and invoice-level order value.
5. Build monthly, country and product performance views.
6. Create customer-level RFM features:
   - **Recency:** days since the last purchase
   - **Frequency:** number of distinct invoices
   - **Monetary:** total net sales value
7. Assign actionable customer segments.
8. Export clean tables for PostgreSQL.

## Customer segments

| Segment | Typical action |
|---|---|
| Champions | Loyalty benefits, early access and referrals |
| Loyal customers | Cross-sell and replenishment campaigns |
| Potential loyalists | Onboarding and second-purchase incentives |
| At risk | Targeted win-back based on prior value |
| Hibernating | Low-cost reactivation or suppression |
| Other | Further behavioral investigation |

Segment rules are transparent heuristics, not universal truths. They should be validated against campaign outcomes.

## Repository structure

```text
src/retail_analysis.py       Data retrieval, cleaning, KPIs and RFM
database_schema.sql          PostgreSQL schema for clean transactions and RFM
analysis_queries.sql         Revenue, retention and customer-value queries
tests/                       Unit tests with local fixtures
data/README.md               Source and licensing notes
requirements.txt
.github/workflows/python.yml
```

## Run the project

```bash
git clone https://github.com/AtifElmasry/E-Commerce-Sales-Insights-with-PostgreSQL.git
cd E-Commerce-Sales-Insights-with-PostgreSQL
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python src/retail_analysis.py
```

The script writes:

- `data/processed/transactions.csv`
- `data/processed/customer_rfm.csv`

Load these files into the PostgreSQL tables defined in `database_schema.sql`, then run `analysis_queries.sql`.

## Data-quality decisions

- Cancelled invoices remain measurable but are excluded from net-sales analysis.
- Negative quantities and nonpositive prices are excluded from valid sales.
- Missing customer IDs are retained for transaction-level diagnostics but excluded from RFM.
- Revenue is calculated as quantity × unit price and should not be interpreted as profit.
- The retailer is anonymized and historical, limiting external generalization.

## Skills demonstrated

Large transaction data, cleaning rules, KPI design, SQL, RFM segmentation, customer analytics, reproducible pipelines, testing and business recommendations.

## Author

[Atif Elmasry](https://github.com/AtifElmasry) · [LinkedIn](https://www.linkedin.com/in/tioatifelmasry/)
