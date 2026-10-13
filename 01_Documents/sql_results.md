# SQL Results (actual output from running 02_analysis_queries.sql on the data/ CSVs)

### Q1 Delayed order %

|   delivered_orders |   delayed_orders |   delayed_pct |
|-------------------:|-----------------:|--------------:|
|               5296 |             1315 |          24.8 |

### Q1b Delay % by warehouse and carrier (where is the bottleneck?)

| warehouse        | carrier     |   shipments |   delayed_pct |   avg_dispatch_days |
|:-----------------|:------------|------------:|--------------:|--------------------:|
| WH-North (Delhi) | XpressBees  |         433 |          30.3 |                2.29 |
| WH-West (Mumbai) | XpressBees  |         351 |          30.2 |                2.46 |
| WH-West (Mumbai) | BlueDart    |         370 |          28.1 |                2.58 |
| WH-West (Mumbai) | EcomExpress |         435 |          28   |                2.51 |
| WH-West (Mumbai) | Delhivery   |         641 |          27.5 |                2.49 |
| WH-North (Delhi) | BlueDart    |         441 |          26.5 |                2.32 |

### Q2 Payment failure rate by method (attempt-level)

| payment_method   |   attempts |   failed |   failure_pct |
|:-----------------|-----------:|---------:|--------------:|
| Net Banking      |        638 |       72 |         11.29 |
| Debit Card       |        855 |       63 |          7.37 |
| Credit Card      |       1242 |       69 |          5.56 |
| UPI              |       2078 |       97 |          4.67 |
| Wallet           |        389 |        7 |          1.8  |
| COD              |        926 |        0 |          0    |

### Q2b Failure reasons

| failure_reason     |   cnt |
|:-------------------|------:|
| Bank timeout       |   120 |
| OTP failure        |    86 |
| Insufficient funds |    63 |
| Gateway error      |    39 |

### Q3 Return rate by product category (returned line items / delivered line items)

| category       |   delivered_items |   returned_items |   return_rate_pct |
|:---------------|------------------:|-----------------:|------------------:|
| Fashion        |              1481 |              247 |              16.7 |
| Electronics    |              1495 |              133 |               8.9 |
| Home & Kitchen |              1436 |              109 |               7.6 |
| Beauty         |              1487 |               97 |               6.5 |
| Sports         |              1503 |               93 |               6.2 |
| Books          |              1448 |               27 |               1.9 |

### Q4 Checkout funnel - where do customers drop out?

| stage             |   sessions |   pct_of_previous_stage |   pct_of_all_sessions |
|:------------------|-----------:|------------------------:|----------------------:|
| Product View      |      24000 |                   nan   |                 100   |
| Add to Cart       |      10089 |                    42   |                  42   |
| Checkout Started  |       6266 |                    62.1 |                  26.1 |
| Payment Attempted |       4909 |                    78.3 |                  20.5 |
| Order Placed      |       4421 |                    90.1 |                  18.4 |

### Q5 Average delivery time (order date -> delivered date) and dispatch time

|   avg_order_to_delivery_days |   avg_order_to_dispatch_days |   avg_transit_days |
|-----------------------------:|-----------------------------:|-------------------:|
|                         6.21 |                         2.33 |               3.88 |

### Q6 Cancellation rate and reasons

| cancel_reason            |   cancelled |   pct_of_all_orders |
|:-------------------------|------------:|--------------------:|
| Delay in dispatch        |         109 |                1.82 |
| Found cheaper            |          82 |                1.37 |
| Ordered by mistake       |          71 |                1.18 |
| Out of stock after order |          60 |                1    |

### Q7 Inventory mismatch (system vs physical) by category, latest audit

| category       |   audited_skus |   mismatched_skus |   mismatch_pct |
|:---------------|---------------:|------------------:|---------------:|
| Beauty         |             20 |                 7 |             35 |
| Fashion        |             20 |                 6 |             30 |
| Electronics    |             20 |                 6 |             30 |
| Sports         |             20 |                 4 |             20 |
| Home & Kitchen |             20 |                 4 |             20 |
| Books          |             20 |                 4 |             20 |

### Q8 Support tickets by issue category (what drives contact volume?)

| issue_category        |   tickets |   pct_of_tickets |   avg_resolution_days |
|:----------------------|----------:|-----------------:|----------------------:|
| Delayed order         |       597 |             55.2 |                   2.5 |
| Order status inquiry  |       229 |             21.2 |                   1   |
| Cancellation / refund |       138 |             12.8 |                   3.2 |
| Payment issue         |        61 |              5.6 |                   2   |
| Refund delay          |        56 |              5.2 |                   4.7 |

### Q9 Monthly KPI summary (feeds the Power BI dashboard)

| month   |   orders |   cancel_pct |   payment_failed_pct |   net_revenue |
|:--------|---------:|-------------:|---------------------:|--------------:|
| 2026-01 |      632 |          5.5 |                  3.6 |       7167120 |
| 2026-02 |      867 |          5.1 |                  2.5 |       9071200 |
| 2026-03 |     1165 |          5.2 |                  3.2 |      12352610 |
| 2026-04 |     1202 |          5.6 |                  3.1 |      12869380 |
| 2026-05 |     1187 |          4.6 |                  3.4 |      13146140 |
| 2026-06 |      947 |          6.3 |                  2.2 |       9915370 |

### Q10 Pending refunds - finance exposure

|   pending_refunds |   amount_at_risk |
|------------------:|-----------------:|
|               137 |           950250 |

