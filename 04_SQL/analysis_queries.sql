-- E=commerce OMS Project | Analysis queries

-- Q1. % of delivered orders that were delayed (delivered after promised date)
-- MySQL: use DATEDIFF(delivered_date, promised_date) > 0 ; same logic otherwise

--@Q1 Delayed order %
SELECT COUNT(*) AS delivered_orders,
       SUM(CASE WHEN delivered_date > promised_date THEN 1 ELSE 0 END) AS delayed_orders,
       ROUND(100.0*SUM(CASE WHEN delivered_date > promised_date THEN 1 ELSE 0 END)/COUNT(*),1) AS delayed_pct
FROM shipments WHERE shipment_status='Delivered';

--@Q1b Delay % by warehouse and carrier (where is the bottleneck?)
SELECT warehouse, carrier, COUNT(*) AS shipments,
       ROUND(100.0*SUM(delivered_date > promised_date)/COUNT(*),1) AS delayed_pct,
       ROUND(AVG(julianday(ship_date)-julianday(o.order_date)),2) AS avg_dispatch_days
FROM shipments s JOIN orders o USING(order_id)
WHERE shipment_status='Delivered'
GROUP BY warehouse, carrier ORDER BY delayed_pct DESC LIMIT 6;

--@Q2 Payment failure rate by method (attempt-level)
SELECT payment_method, COUNT(*) AS attempts,
       SUM(CASE WHEN payment_status='Failed' THEN 1 ELSE 0 END) AS failed,
       ROUND(100.0*SUM(CASE WHEN payment_status='Failed' THEN 1 ELSE 0 END)/COUNT(*),2) AS failure_pct
FROM payments GROUP BY payment_method ORDER BY failure_pct DESC;

--@Q2b Failure reasons
SELECT failure_reason, COUNT(*) AS cnt FROM payments WHERE payment_status='Failed' GROUP BY failure_reason ORDER BY cnt DESC;

--@Q3 Return rate by product category (returned line items / delivered line items)
SELECT p.category,
       COUNT(DISTINCT oi.item_id) AS delivered_items,
       COUNT(DISTINCT r.return_id) AS returned_items,
       ROUND(100.0*COUNT(DISTINCT r.return_id)/COUNT(DISTINCT oi.item_id),1) AS return_rate_pct
FROM order_items oi
JOIN orders o ON o.order_id=oi.order_id AND o.order_status='Delivered'
JOIN products p ON p.product_id=oi.product_id
LEFT JOIN returns r ON r.order_id=oi.order_id AND r.product_id=oi.product_id
GROUP BY p.category ORDER BY return_rate_pct DESC;

--@Q4 Checkout funnel - where do customers drop out?
WITH s AS (SELECT stage, stage_order, COUNT(DISTINCT session_id) AS sessions FROM funnel_events GROUP BY stage, stage_order)
SELECT stage, sessions,
       ROUND(100.0*sessions/LAG(sessions) OVER (ORDER BY stage_order),1) AS pct_of_previous_stage,
       ROUND(100.0*sessions/FIRST_VALUE(sessions) OVER (ORDER BY stage_order),1) AS pct_of_all_sessions
FROM s ORDER BY stage_order;

--@Q5 Average delivery time (order date -> delivered date) and dispatch time
SELECT ROUND(AVG(julianday(s.delivered_date)-julianday(o.order_date)),2) AS avg_order_to_delivery_days,
       ROUND(AVG(julianday(s.ship_date)-julianday(o.order_date)),2) AS avg_order_to_dispatch_days,
       ROUND(AVG(julianday(s.delivered_date)-julianday(s.ship_date)),2) AS avg_transit_days
FROM shipments s JOIN orders o USING(order_id) WHERE s.shipment_status='Delivered';

--@Q6 Cancellation rate and reasons
SELECT cancel_reason, COUNT(*) AS cancelled,
       ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM orders),2) AS pct_of_all_orders
FROM orders WHERE order_status='Cancelled' GROUP BY cancel_reason ORDER BY cancelled DESC;

--@Q7 Inventory mismatch (system vs physical) by category, latest audit
SELECT p.category, COUNT(*) AS audited_skus,
       SUM(CASE WHEN a.system_qty<>a.physical_qty THEN 1 ELSE 0 END) AS mismatched_skus,
       ROUND(100.0*SUM(CASE WHEN a.system_qty<>a.physical_qty THEN 1 ELSE 0 END)/COUNT(*),1) AS mismatch_pct
FROM inventory_audits a JOIN products p USING(product_id)
WHERE a.audit_date='2026-06-30' GROUP BY p.category ORDER BY mismatch_pct DESC;

--@Q8 Support tickets by issue category (what drives contact volume?)
SELECT issue_category, COUNT(*) AS tickets,
       ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM support_tickets),1) AS pct_of_tickets,
       ROUND(AVG(julianday(resolved_date)-julianday(created_date)),1) AS avg_resolution_days
FROM support_tickets GROUP BY issue_category ORDER BY tickets DESC;

--@Q9 Monthly KPI summary (feeds the Power BI dashboard)
SELECT substr(order_date,1,7) AS month, COUNT(*) AS orders,
       ROUND(100.0*SUM(order_status='Cancelled')/COUNT(*),1) AS cancel_pct,
       ROUND(100.0*SUM(order_status='Payment Failed')/COUNT(*),1) AS payment_failed_pct,
       SUM(CASE WHEN order_status IN ('Delivered','Shipped') THEN order_amount ELSE 0 END) AS net_revenue
FROM orders GROUP BY month ORDER BY month;

--@Q10 Pending refunds - finance exposure
SELECT COUNT(*) AS pending_refunds, SUM(refund_amount) AS amount_at_risk
FROM returns WHERE refund_status='Refund Pending';
