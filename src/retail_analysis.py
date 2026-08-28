"""Prepare UCI Online Retail transactions and customer RFM segments."""

from pathlib import Path
import re

import pandas as pd
from ucimlrepo import fetch_ucirepo

PROJECT_ROOT = Path(__file__).resolve().parents[1]
PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"


def to_snake_case(value):
    """Convert a column label to lowercase snake case."""
    value = re.sub(r"[^a-zA-Z0-9]+", "_", str(value))
    return value.strip("_").lower()


def load_uci_data():
    """Retrieve the UCI Online Retail dataset."""
    dataset = fetch_ucirepo(id=352)
    if dataset.data.original is not None:
        data = dataset.data.original.copy()
    else:
        data = dataset.data.features.copy()
    data.columns = [to_snake_case(column) for column in data.columns]
    return data


def clean_transactions(data):
    """Standardize fields and return all activity plus valid sales."""
    transactions = data.copy()
    transactions.columns = [to_snake_case(column) for column in transactions.columns]

    aliases = {
        "invoiceno": "invoice_no",
        "stockcode": "stock_code",
        "invoicedate": "invoice_date",
        "unitprice": "unit_price",
        "customerid": "customer_id",
    }
    transactions = transactions.rename(columns=aliases)
    required = {
        "invoice_no",
        "stock_code",
        "quantity",
        "invoice_date",
        "unit_price",
        "customer_id",
        "country",
    }
    missing = required.difference(transactions.columns)
    if missing:
        raise ValueError(f"Missing required columns: {sorted(missing)}")

    transactions["invoice_no"] = transactions["invoice_no"].astype(str)
    transactions["invoice_date"] = pd.to_datetime(
        transactions["invoice_date"],
        errors="coerce",
    )
    transactions["quantity"] = pd.to_numeric(
        transactions["quantity"],
        errors="coerce",
    )
    transactions["unit_price"] = pd.to_numeric(
        transactions["unit_price"],
        errors="coerce",
    )
    transactions["is_cancelled"] = transactions["invoice_no"].str.startswith("C")
    transactions["line_revenue"] = (
        transactions["quantity"] * transactions["unit_price"]
    )

    valid_sales = transactions[
        (~transactions["is_cancelled"])
        & transactions["invoice_date"].notna()
        & (transactions["quantity"] > 0)
        & (transactions["unit_price"] > 0)
    ].copy()
    return transactions, valid_sales


def calculate_kpis(all_activity, valid_sales):
    """Calculate a compact set of executive retail KPIs."""
    invoice_revenue = valid_sales.groupby("invoice_no")["line_revenue"].sum()
    return {
        "net_revenue": valid_sales["line_revenue"].sum(),
        "orders": valid_sales["invoice_no"].nunique(),
        "customers": valid_sales["customer_id"].nunique(),
        "average_order_value": invoice_revenue.mean(),
        "cancellation_rate": all_activity.groupby("invoice_no")[
            "is_cancelled"
        ].max().mean(),
    }


def build_rfm(valid_sales):
    """Create customer-level recency, frequency and monetary features."""
    identified = valid_sales.dropna(subset=["customer_id"]).copy()
    if identified.empty:
        raise ValueError("No transactions with customer IDs are available.")

    reference_date = identified["invoice_date"].max() + pd.Timedelta(days=1)
    rfm = identified.groupby("customer_id").agg(
        recency_days=("invoice_date", lambda values: (reference_date - values.max()).days),
        frequency=("invoice_no", "nunique"),
        monetary=("line_revenue", "sum"),
    )

    rfm["r_score"] = pd.qcut(
        rfm["recency_days"].rank(method="first"),
        5,
        labels=[5, 4, 3, 2, 1],
    ).astype(int)
    rfm["f_score"] = pd.qcut(
        rfm["frequency"].rank(method="first"),
        5,
        labels=[1, 2, 3, 4, 5],
    ).astype(int)
    rfm["m_score"] = pd.qcut(
        rfm["monetary"].rank(method="first"),
        5,
        labels=[1, 2, 3, 4, 5],
    ).astype(int)
    rfm["segment"] = rfm.apply(assign_segment, axis=1)
    return rfm.reset_index()


def assign_segment(customer):
    """Map transparent RFM rules to an actionable customer segment."""
    if customer["r_score"] >= 4 and customer["f_score"] >= 4:
        return "champions"
    if customer["f_score"] >= 4:
        return "loyal_customers"
    if customer["r_score"] >= 4 and customer["f_score"] >= 2:
        return "potential_loyalists"
    if customer["r_score"] <= 2 and customer["m_score"] >= 4:
        return "at_risk"
    if customer["r_score"] <= 2 and customer["f_score"] <= 2:
        return "hibernating"
    return "other"


def export_tables(valid_sales, rfm, output_dir=PROCESSED_DIR):
    """Write analysis-ready transaction and customer tables."""
    output_dir.mkdir(parents=True, exist_ok=True)
    valid_sales.to_csv(output_dir / "transactions.csv", index=False)
    rfm.to_csv(output_dir / "customer_rfm.csv", index=False)


def main():
    """Run the full retail preparation and customer analytics pipeline."""
    raw = load_uci_data()
    all_activity, valid_sales = clean_transactions(raw)
    kpis = calculate_kpis(all_activity, valid_sales)
    rfm = build_rfm(valid_sales)
    export_tables(valid_sales, rfm)

    print("Executive KPIs")
    for name, value in kpis.items():
        if name.endswith("rate"):
            print(f"{name}: {value:.1%}")
        else:
            print(f"{name}: {value:,.2f}")
    print("\nCustomer segments")
    print(rfm["segment"].value_counts().to_string())


if __name__ == "__main__":
    main()
