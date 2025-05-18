# DataAnalytics-Assessment

This repository contains solutions to a SQL-based Data Analyst Assessment, using MySQL to extract business insights from a customer financial services database.

## 📋 Database Overview

Tables used:
- `users_customuser`: Customer information (ID, name, created_on)
- `savings_savingsaccount`: Transaction records for savings
- `plans_plan`: Account details including plan type (savings or investment)
- `withdrawals_withdrawal`: Withdrawal transaction records

---

## ✅ Solutions

### Q1. High-Value Customers with Multiple Products

**Goal:** Find customers with at least one savings plan and one investment plan, both funded.  

**Approach:**
- Identify customers with `plan_type_id = 1` (savings) and `plan_type_id = 2` (investment).
- Use the `confirmed_amount` field to determine deposits.
- Return counts and sum of deposits per customer.

---

### Q2. Transaction Frequency Analysis

**Goal:** Categorize customers by average number of monthly transactions:
- High: ≥10/month
- Medium: 3–9/month
- Low: ≤2/month
  
**Approach:**
- Calculate number of months between first and last transaction per user.
- Divide transaction count by month span.
- Use `CASE` to label frequency categories and count customers per group.

---

### Q3. Account Inactivity Alert

**Goal:** Find accounts (savings or investments) with no inflow in the last 365 days.

**Approach:**
- For `savings_savingsaccount`, use `transaction_date`.
- For `plans_plan`, use `last_charge_date`.
- Identify last activity and compute days since.
- Flag accounts inactive for more than 365 days.

---

### Q4. Customer Lifetime Value (CLV)

**Goal:** Estimate CLV with this simplified formula:

**Approach:**
- Tenure is calculated using `created_on` from `users_customuser`.
- Profit is 0.1% of each transaction (`confirmed_amount`).
- Join tenure and transaction data, apply formula, and order by CLV.

---

