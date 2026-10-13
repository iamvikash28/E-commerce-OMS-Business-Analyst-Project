-- E-commerce OMS Project | Schema 
CREATE TABLE customers (customer_id INTEGER PRIMARY KEY, customer_name TEXT, city TEXT, segment TEXT, signup_date DATE);
CREATE TABLE products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, unit_price INTEGER, stock_qty INTEGER);
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER REFERENCES customers(customer_id), order_date DATE,
  order_amount INTEGER, payment_method TEXT, order_status TEXT, cancel_reason TEXT);
CREATE TABLE order_items (item_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id),
  product_id INTEGER REFERENCES products(product_id), quantity INTEGER, unit_price INTEGER);
CREATE TABLE payments (payment_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id), payment_method TEXT,
  attempt_no INTEGER, payment_status TEXT, failure_reason TEXT, amount INTEGER, payment_date DATE);
CREATE TABLE shipments (shipment_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id), warehouse TEXT, carrier TEXT,
  ship_date DATE, promised_date DATE, delivered_date DATE, shipment_status TEXT);
CREATE TABLE returns (return_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id),
  product_id INTEGER REFERENCES products(product_id), return_reason TEXT, return_date DATE, refund_status TEXT, refund_amount INTEGER);
CREATE TABLE support_tickets (ticket_id INTEGER PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id),
  customer_id INTEGER REFERENCES customers(customer_id), issue_category TEXT, created_date DATE, resolved_date DATE, ticket_status TEXT);
CREATE TABLE inventory_audits (audit_id INTEGER PRIMARY KEY, product_id INTEGER REFERENCES products(product_id),
  audit_date DATE, system_qty INTEGER, physical_qty INTEGER);
CREATE TABLE funnel_events (event_id INTEGER PRIMARY KEY, session_id INTEGER, stage TEXT, stage_order INTEGER);
