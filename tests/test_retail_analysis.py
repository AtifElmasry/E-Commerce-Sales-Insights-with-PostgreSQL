"""Tests for retail transaction cleaning and RFM segmentation."""

import pandas as pd
import pytest

from src.retail_analysis import build_rfm, calculate_kpis, clean_transactions


@pytest.fixture
def transactions():
    """Return purchases, a cancellation and an invalid free item."""
    return pd.DataFrame(
        {
            "InvoiceNo": ["100", "100", "101", "C102", "103"],
            "StockCode": ["A", "B", "A", "A", "C"],
            "Description": ["One", "Two", "One", "One", "Three"],
            "Quantity": [2, 1, 1, -1, 1],
            "InvoiceDate": [
                "2011-01-01",
                "2011-01-01",
                "2011-02-01",
                "2011-02-05",
                "2011-03-01",
            ],
            "UnitPrice": [10.0, 5.0, 10.0, 10.0, 0.0],
            "CustomerID": [1, 1, 2, 2, 3],
            "Country": ["UK"] * 5,
        }
    )


def test_cleaning_separates_valid_sales(transactions):
    """Cancelled and nonpositive-price rows should not enter net sales."""
    all_activity, valid_sales = clean_transactions(transactions)

    assert len(all_activity) == 5
    assert len(valid_sales) == 3
    assert valid_sales["line_revenue"].sum() == pytest.approx(35.0)


def test_kpis_use_invoice_level_order_value(transactions):
    """Average order value should use distinct invoices."""
    all_activity, valid_sales = clean_transactions(transactions)
    kpis = calculate_kpis(all_activity, valid_sales)

    assert kpis["orders"] == 2
    assert kpis["average_order_value"] == pytest.approx(17.5)


def test_rfm_creates_customer_segments():
    """RFM output should contain scores and a segment for every customer."""
    rows = []
    for customer in range(1, 11):
        rows.append(
            {
                "customer_id": customer,
                "invoice_no": str(customer),
                "invoice_date": pd.Timestamp("2011-01-01")
                + pd.Timedelta(days=customer),
                "line_revenue": float(customer * 10),
            }
        )
    rfm = build_rfm(pd.DataFrame(rows))

    assert len(rfm) == 10
    assert {"r_score", "f_score", "m_score", "segment"}.issubset(rfm.columns)
