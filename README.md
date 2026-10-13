# E-commerce Order Management System (OMS) — Business Analyst Project

> End-to-end Business Analyst case study: from a messy as-is order process to a fully specified, tested, and measured OMS — requirements, process design, Agile backlog, SQL analysis, Power BI dashboard, UAT, and traceability.

![Executive Dashboard](05_PowerBI/Ecommerce_OMS_Project.pdf)


## Table of contents
- [Project overview](#project-overview)
- [Business problem](#business-problem)
- [Key findings](#key-findings)
- [Deliverables](#deliverables)
- [Dashboard](#dashboard)
- [Repository structure](#repository-structure)
- [Data](#data)
- [How to reproduce](#how-to-reproduce)
- [Tools and skills](#tools-and-skills)
- [Disclaimer](#disclaimer)
- [Author](#author)

## Project overview
This project simulates the work of a Business Analyst at a hypothetical e-commerce company that is replacing its order handling with a new **Order Management System (OMS)**. I did not build the application; I produced the analysis and documentation that a development team needs to build it, and the metrics a business needs to judge whether it worked.

## Business problem
The company is receiving complaints about:
- delayed orders
- order cancellations
- failed payments
- inventory mismatches
- excessive customer-support tickets
- poor visibility into order status

## Key findings
Findings come from SQL run on a synthetic dataset of 6,000 orders (Jan–Jun 2026).

| Area | Finding |
|---|---|
| Delivery | **24.8%** of delivered orders arrived after the promised date; average order-to-delivery is 6.2 days (2.3 days is dispatch) |
| Carriers/warehouses | XpressBees (28.4% late) and the Mumbai warehouse are the weakest |
| Payments | **3.0%** of orders are lost to payment failure; Net Banking fails **11.3%** of attempts vs 4.7% for UPI |
| Cancellations | 5.4% of orders cancelled; "delay in dispatch" is the top reason |
| Returns | Fashion return rate is **16.7%**, about double the next category; "Changed mind" is the top reason (35%) |
| Refunds | 137 refunds worth INR 9.5 lakh are still pending |
| Support | 1,081 tickets (18 per 100 orders); **76%** are about delays or order status |
| Funnel | Only **18.4%** of sessions end in an order; the biggest drop is product view to add-to-cart |
| Inventory | 26% of SKUs differ between system and physical stock at the June audit |

## Deliverables

| # | Deliverable | Location |
|---|---|---|
| 1 | Stakeholder analysis (9 stakeholders, influence/interest, engagement) | BRD §4, `02_Tracker` > Stakeholders |
| 2 | As-Is process with bottlenecks | BRD §5, `06_Diagrams/01_AsIs_Process.png` |
| 3 | To-Be process | BRD §6, `06_Diagrams/02_ToBe_Process.png` |
| 4 | Business Requirements Document (objective, problem, scope, 17 functional and 10 non-functional requirements, assumptions, constraints, risks, KPIs) | `01_Documents/01_BRD_OMS.docx` |
| 5 | 17 user stories with acceptance criteria | `02_Tracker` > User Stories |
| 6 | Jira-style backlog: 6 epics, 17 stories, 8 tasks, 5 bugs, priorities, 4 sprints | `02_Tracker` > Jira Backlog, Sprint Plan |
| 7 | SQL schema and 10 analysis queries with results | `04_SQL/`, `01_Documents/sql_results.md` |
| 8 | Power BI model, DAX measures and 4-page dashboard | `05_PowerBI/` |
| 9 | UAT: 25 test cases (21 pass, 4 fail with defects logged) | `02_Tracker` > UAT |
| 10 | Requirements Traceability Matrix (business requirement → functional requirement → user story → test case → result) | `02_Tracker` > RTM |

Interview preparation notes are in `01_Documents/Interview_Talking_Points.md`.

## Dashboard
Four pages, each tied to a business requirement.

| Page | Business requirement | Preview |
|---|---|---|
| 1. Executive Overview | All | `05_PowerBI/02_Page1_Executive_Overview.png` |
| 2. Fulfilment & Delivery SLA | BR-01: reduce late deliveries | `05_PowerBI/03_Page2_Fulfilment_SLA.png` |
| 3. Checkout, Payments & Cancellations | BR-02, BR-03: payment recovery, stock accuracy | `05_PowerBI/04_Page3_Checkout_Payments.png` |
| 4. Returns, Refunds & Support | BR-05, BR-06: fewer tickets, fast refunds | `05_PowerBI/05_Page4_Returns_Refunds_Support.png` |

![Page 2](05_PowerBI/03_Page2_Fulfilment_SLA.png)
![Page 3](05_PowerBI/04_Page3_Checkout_Payments.png)
![Page 4](05_PowerBI/05_Page4_Returns_Refunds_Support.png)

The model, relationships, DAX measures, and visual specifications are in `05_PowerBI/01_Model_and_Dashboard_Spec.md`.

## Repository structure
```
Ecommerce_OMS_BA_Project/
├── 01_Documents/      BRD (docx), SQL results, interview notes
├── 02_Tracker/        Excel workbook: stakeholders, requirements, user stories,
│                      Jira backlog, sprint plan, UAT, RTM
├── 03_Data/           10 CSV tables + synthetic data generator
├── 04_SQL/            schema, analysis queries, runner script
├── 05_PowerBI/        dashboard images, model and DAX spec, theme
└── 06_Diagrams/       As-Is and To-Be process diagrams
```

## Data
All data is **synthetic**, generated with a fixed random seed (42) to mimic realistic e-commerce behaviour. Tables: `customers`, `products`, `orders`, `order_items`, `payments`, `shipments`, `returns`, `support_tickets`, `inventory_audits`, `funnel_events`.

## How to reproduce
Requires Python 3 with `pandas`, `numpy` and `tabulate`.

```bash
# from the project root
python 03_Data/generate_synthetic_data.py    # writes the CSV files
python 04_SQL/run_sql.py                      # loads them into SQLite and prints every query result
```

The SQL is written for SQLite. For MySQL, replace `julianday(a) - julianday(b)` with `DATEDIFF(a, b)`.

To rebuild the dashboard, load the CSVs into Power BI Desktop and follow `05_PowerBI/01_Model_and_Dashboard_Spec.md`.

## Tools and skills
**Tools:** SQL (SQLite), Power BI (DAX, Power Query), Excel, Python (pandas), Graphviz, Word, Jira-style backlog

**BA skills shown:** stakeholder analysis, process mapping (As-Is / To-Be), requirements elicitation and documentation (BRD), user stories and acceptance criteria, backlog prioritisation and sprint planning, UAT design, requirements traceability, data analysis and KPI definition.

## Disclaimer
This is a portfolio project. The company, data, and UAT results are fictional; UAT outcomes are illustrative and show how defects and traceability are documented. No production system was built.

## Author
**Vikash Verma** — aspiring Data / Business Analyst
- GitHub: [github.com/iamvikash28](https://github.com/iamvikash28)
- LinkedIn: [linkedin.com/in/iamvikash28](https://linkedin.com/in/iamvikash28)
- Email: vikashverma566@gmail.com
