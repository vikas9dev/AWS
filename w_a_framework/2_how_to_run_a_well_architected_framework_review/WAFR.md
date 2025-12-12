## 1.1 AWS Well-Architected

Welcome to **Module Two** of *AWS Well-Architected: How to Run a Well-Architected Framework Review.*
In this module, you’ll explore how to conduct a **Well-Architected Framework Review (WAFR)** and use it as a tool for **continuous improvement** across your AWS workloads.

---

## 1.2 Learning Objectives

By the end of this module, you will be able to:

* ✅ **Complete a Well-Architected Framework Review** effectively.
* 💡 **Understand the impact of design decisions** on your architecture’s performance, security, and reliability.
* ⚙️ **Evaluate architectural risks** and learn how to **mitigate** or **eliminate** them through AWS best practices.

---

## 1.3 What Is the Well-Architected Framework Review?

The **AWS Well-Architected Framework Review (WAFR)** is a **continuous improvement mechanism** that helps you:

* **Evaluate your workloads** against **AWS best practices**.
* **Identify high-risk and medium-risk issues (HRIs/MRIs)** that could affect your workloads.
* **Implement recommended remediations** to strengthen your cloud architecture.

The **goal** of a review is to uncover:

* **Critical issues** that require immediate attention.
* **Opportunities for improvement** that enhance efficiency, performance, and resilience.

The **outcome** of a review is a clear, actionable **improvement plan** based on the **six pillars** of the AWS Well-Architected Framework:
**Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization,** and **Sustainability.**

---

## 1.4 A Mechanism for Continuous Improvement

The **Well-Architected Framework Review** is not a one-time activity—it’s part of a **continuous improvement cycle** that aligns with your workload’s lifecycle.

This mechanism follows **three key steps:**

### 1️⃣ Learn

* Understand **strategies, principles, and best practices** for architecting in the cloud.
* Build foundational knowledge using the **AWS Well-Architected Framework**, **lenses**, and **labs**.

### 2️⃣ Measure

* Assess your workload’s current state using:

  * The **AWS Well-Architected Framework**
  * Relevant **lenses** (e.g., Data Analytics, Machine Learning, Serverless)
  * **Custom lenses** aligned to your organization’s internal best practices
* Use the **AWS Well-Architected Tool (WA Tool)** to document findings and insights.

### 3️⃣ Improve

* Use your review results to **address high-risk issues** and **implement improvements**.
* Apply learnings through:

  * **Improvement plans** and **Well-Architected Labs**
  * Guidance from **AWS Partner Network (APN)** members
  * Support from **AWS Solutions Architecture** teams

This **Learn → Measure → Improve** process should be applied to **every workload** across your organization.

📝 **Note:**
A **workload** represents a collection of components that work together to **deliver business value** — such as an application, platform, or service. You’ll explore workload structures in more detail in a later module.

✅ **In summary**, the Well-Architected Framework Review helps organizations establish a **repeatable, measurable, and scalable process** for maintaining high standards of architecture quality and operational excellence across all workloads.

---
 ## 1.5 Intent of a Review

The **purpose** of a Well-Architected Framework Review is to **identify critical issues** in your architecture that need attention and to **highlight areas for improvement**.

The **outcome** of a review is a **set of actionable steps** designed to **enhance the workload’s performance, reliability, and overall user experience**.

💡 **Key Principles of a Review:**

* It should be **consistent** and **blame-free**, encouraging honest discussions and deep exploration.
* It must be a **lightweight process**, taking **hours, not days**.
* It is a **conversation**, **not an audit** — focused on learning, not fault-finding.
* Reviews should be **continuous**, not limited to formal sessions. As architectures evolve, **update answers regularly** to keep your workload aligned with best practices.

A **continuous review mindset** ensures that improvement happens naturally as features are developed and deployed.

---

## 1.6 Learnings

From conducting thousands of reviews, AWS has identified several key lessons:

* **Review early in the lifecycle.** Addressing issues in the design phase is faster, cheaper, and more effective.
* **Neglect is a common risk.** Most problems arise not from poor decisions, but from **decisions that were never discussed** — such as forgetting to plan data backups.
* **High-risk issues exist in most workloads.** Finding them is **a success, not a failure** — because identifying them allows you to **fix and strengthen your architecture**.

✅ Each resolved risk means **one less obstacle** that could harm or slow your business.

---

## 1.7 Use Cases

The **AWS Well-Architected Framework Review (WAFR)** is valuable in several common scenarios:

### 1️⃣ Learning AWS Best Practices

* Ideal for teams who want to **learn how to architect for the cloud**.
* Helps identify **risks** and **opportunities for improvement**.

### 2️⃣ Technology Governance

* Ensures workloads are **ready for production** and **meet organizational standards**.
* Promotes **consistency across multiple teams** and workloads.
* Enables prioritization of problems over time based on **business impact**.

### 3️⃣ Portfolio Management

* Many organizations lack a **central registry** of their workloads or their associated risks.
* The **AWS Well-Architected Tool (WA Tool)** creates a **portfolio view**, helping teams:

  * Record **metadata** (e.g., workload name, account, Region).
  * Track **architectural decisions** across all **six pillars**.
  * Identify **risk trends** and **training needs** through aggregated insights.

📊 **Benefit for Leadership:**
Senior management can **analyze trends**, identify **recurrent weaknesses**, and **plan targeted improvements** organization-wide.

---

## 1.8 Three Review Phases

A Well-Architected Framework Review consists of **three key phases**:

### 1️⃣ Prepare

* Define the **workload** to review.
* Identify **core participants** who understand each pillar.
* Assign a **sponsor** to own the improvement plan and implementation.

### 2️⃣ Review

* Conduct the actual review using the **AWS Well-Architected Tool (WA Tool)**.
* Document findings, **notes**, and **recommended actions**.
* Identify **high-risk** and **medium-risk** issues for remediation.

### 3️⃣ Improve

* **Prioritize and address risks** found during the review.
* Develop an **improvement plan** and **execute changes**.

Each phase contributes to building **resilient, secure, and efficient architectures** that evolve continuously.

---

## 1.9 Prepare

The **prepare phase** lays the foundation for a successful review. It involves defining the **scope**, selecting the **right team**, and gathering the **necessary context** for the workload.

---

## 1.10 Best Practices for Preparing Reviews

To prepare effectively:

1. **Define the workload.**

   * A workload represents the components that together **deliver business value** — such as a website that processes customer orders.

2. **Identify the core review team.**

   * Include **subject matter experts (SMEs)** for each pillar.
   * These team members should be able to **answer pillar-specific questions** and **own future improvement plans**.

3. **Conduct a scoping session.**

   * Align on the **purpose, scope, and expectations** of the review.
   * Ensure all team members understand **what will be reviewed** and **how success is defined**.

---

## 1.11 Best Practices for Preparing Reviews (Continued)

Additional preparation steps include:

* **Decide on the review format.**

  * Choose between a **single-day session** (covering all pillars) or **multiple shorter sessions** (focusing on individual pillars).
* **Gather necessary data.**

  * Prepare existing documentation, diagrams, and metrics — no need to build new data.
* **Schedule the review.**

  * Ensure all participants are available and understand their roles.

---

## 1.12 Review Preparation Steps

Here’s a sample **timeline** for preparing a Well-Architected Framework Review:

| Time Before Review  | Key Activities                                                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **3 Weeks Before**  | Select the workload and **form the core review team**. Schedule a **scoping meeting**.                                                                       |
| **~16 Days Before** | Conduct the **scoping session**. Confirm workload details and select **relevant lenses** in the WA Tool. Identify **SMEs** and define the **review format**. |
| **5 Days Before**   | Confirm the **scope and readiness** with all participants. Send reminders to bring existing documentation and supporting data.                               |

💡 **Tip:** Keep preparation simple — focus on collecting information that already exists rather than generating new materials.

---

## 1.13 Review

The **review phase** is where the actual **Well-Architected Framework Review** is conducted. You’ll evaluate your workload against AWS best practices using the **AWS WA Tool** and document findings.

---

## 1.14 Best Practices for Running Reviews

To ensure an effective review session:

* 🧭 **Moderator role:** The moderator keeps discussions focused and ensures alignment with the defined scope.
* 📝 **Note taker:** Assign one person to take notes and enter them into the tool (avoid having the moderator do this). Rotate this role for fairness.
* ⚙️ **One editor at a time:** Only one person should update the WA Tool to prevent data overwrites.
* 🧩 **Centralize assets:** Store relevant documents, analyses, and diagrams in an **Amazon S3 bucket** using a clear naming convention (e.g., `account-name/workload-name`).
* 📊 **Track results:** Use the WA Tool to record findings, notes, and risk levels for each pillar.

These practices ensure that the review is **organized, efficient, and collaborative**.

---

## 1.15 Improve

The **improve phase** focuses on using review outcomes to **build and execute an improvement plan** that mitigates identified risks.

---

## 1.16 Risk Prioritization Methodology and Considerations

Before improving, you must **prioritize risks** based on their **likelihood** and **impact** on the business.

💡 **Definition:**
**Risk prioritization** is the process of identifying which risks are most critical and addressing them first.

📌 **Considerations when prioritizing risks:**

* **Impact categories:** Lost sales, regulatory fines, brand damage, loss of market share, longer time to market, or legal exposure.
* **Risk alignment:** Risks should be prioritized based on **business goals** such as security, performance, cost, or reliability.

In the **Well-Architected Framework**, risks are categorized as:

* **High-Risk Issues (HRIs):** Could cause significant negative business impact.
* **Medium-Risk Issues (MRIs):** May cause moderate or limited impact.

The goal is to **address HRIs first** to protect the organization’s critical operations.

---

## 1.17 Well-Architected Improvement Workflow

The **improvement workflow** helps you systematically identify, prioritize, and address risks.

### Step 1: Identify Risks and Opportunities

* Conduct a **Well-Architected Framework Review** to assess the workload.
* Capture **data and insights** to reveal weaknesses and potential improvements.

### Step 2: Develop Prescriptive Solutions

* For each identified risk, create a **solution plan** based on impact and implementation effort.
* Focus on **high-impact, low-effort** actions that yield quick wins.

### Step 3: Prioritize Solutions

* Rank improvement tasks based on **business value** and **strategic importance**.

### Step 4: Implement and Track Progress

* Begin executing the **improvement plan** in order of priority.
* **Monitor and measure** outcomes to ensure the desired benefits are realized.

📘 **Note:**
Implementing missing best practices often requires collaboration between your **AWS account team**, **solution architects**, and **internal teams** to integrate improvements across **people, processes, and technology**.

---

## 1.22 Summary

In this module, you learned how to:

* ✅ Conduct a **Well-Architected Framework Review (WAFR)**.
* 💡 Understand how **design decisions** impact your architecture’s quality.
* ⚙️ **Identify and evaluate risks** within your workloads.
* 🛠️ **Prioritize and mitigate** risks using structured improvement workflows.

By consistently applying the **Learn → Measure → Improve** process, your organization can achieve **continuous architectural excellence** and ensure your workloads remain **secure, resilient, efficient, cost-effective, and sustainable** in the AWS Cloud.

---