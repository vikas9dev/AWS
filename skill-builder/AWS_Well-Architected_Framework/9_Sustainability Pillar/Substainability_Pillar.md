# Sustainability

## 1.1 AWS Well-Architected

Welcome to **Module Nine of AWS Well-Architected**: Deep Dive on the Sustainability Pillar.

---

## 1.2 Learning Objectives

In this module, you will:

* Learn about the **Sustainability Pillar** of the AWS Well-Architected Framework.
* Understand the **design principles** and **best practices** of sustainability in the cloud.

---

## 1.3 Sustainability Pillar Overview

The **sustainability pillar** focuses on helping architects design workloads that reduce **energy consumption** and **environmental impact**.

* Provides practical examples using **AWS architectural elements**.
* Helps organizations **measure, track, and improve** sustainability outcomes for their workloads.

---

## 1.4 Pillars of AWS Well-Architected

The AWS Well-Architected Framework has **six pillars**:

1. Operational excellence
2. Security
3. Reliability
4. Performance efficiency
5. Cost optimization
6. Sustainability

Sustainability is the **most recent pillar**, introduced in 2021 to help organizations make informed decisions about **energy efficiency** and environmental impact in the cloud.

---

## 1.5 What is the Sustainability Pillar?

The **sustainability pillar**:

* Provides a structured way to **measure architectures** against sustainability best practices.
* Focuses on **reducing energy consumption** and improving workload efficiency.
* Helps identify areas for improvement across workload design, architecture, and implementation.

Key aspects include:

* **Understand:** Know the environmental impact of your workloads.
* **Quantify:** Measure impact across the workload lifecycle.
* **Apply:** Implement design principles and best practices to reduce impact.

> Sustainability is a **trade-off**, similar to other Well-Architected pillars.
> AWS provides a **sustainable infrastructure**, while customers are responsible for **architectural sustainability practices** in their workloads.

### Importance of Sustainability

Sustainability improves architectures due to:

* Customer demand
* Government regulations
* Employee expectations
* Impact investing
* Competitive differentiation

---

## 1.6 Sustainability Design Principles

There are **six design principles** for sustainability in the cloud.

---

### 1.6.1 Understand Your Impact

* **Measure your workload impact** and model future impact.
* Include **all sources of impact**, including customer use and eventual decommissioning.
* Compare **productive output** with **total resource and emission usage**.
* Use metrics to establish KPIs, evaluate productivity improvements, and estimate impacts of changes over time.

**Example actions:**

* Establish **long-term sustainability goals**, such as reducing compute or storage per transaction.
* Model **ROI of sustainability improvements** for existing workloads.
* Plan for **growth**, ensuring reduced impact intensity per user or transaction.

---

### 1.6.2 Maximize Utilization

* **Rightsize workloads** and implement efficient designs to maximize hardware energy efficiency.
* Avoid running multiple underutilized hosts; e.g., **two hosts at 30% utilization** are less efficient than **one host at 60%**.
* Minimize **idle resources**, processing, and storage to reduce total energy consumption.

---

### 1.6.3 Adopt New, Efficient Hardware and Software

* Stay updated with **upstream improvements** by partners and suppliers.
* Monitor and evaluate software offerings continuously.
* Design workloads for **flexibility** to adopt new, efficient technologies quickly.

---

### 1.6.4 Use Managed Services

* Managed services **share resources across customers**, maximizing utilization and reducing infrastructure needs.
* Example: **AWS Fargate** for serverless containers.
* Use services that **automate efficiency**, such as:

  * **Amazon S3 Lifecycle** for moving infrequently accessed data to cold storage
  * **Amazon EC2 Auto Scaling** to adjust capacity based on demand

---

### 1.6.5 Reduce Downstream Impact

* Decrease the **energy and resource demand** required for customers to use your services.
* Minimize the need for customers to **upgrade devices** to use your services.
* **Test for impact:**

  * Use **device farms** to estimate expected energy impact.
  * Test with customers to evaluate real-world usage impact.

---

## 1.8 Sustainability

Now that you understand the **sustainability design principles**, this section dives deeper into **sustainability best practices**.

---

## 1.9 Sustainability Best Practice Areas

The **six best practice areas** for sustainability in the cloud are:

1. **Region Selection**
2. **Alignment to Demand**
3. **Software and Architecture Patterns**
4. **Data Patterns**
5. **Hardware and Services**
6. **Process and Culture**

The following sections explore each area in detail.

---

## 1.10 Region Selection

**Region selection** significantly affects workload KPIs, including **performance, cost, and carbon footprint**.

* Choose Regions based on **business requirements** and **sustainability goals**.
* Selecting the right Region can optimize energy efficiency and reduce environmental impact.

---

## 1.12 Alignment to Demand

**Aligning workloads to demand** ensures resources are provisioned efficiently and sustainably.

Best practices include:

* **Dynamic Scaling:** Match infrastructure to user load to avoid overprovisioning.
* **SLA Alignment:** Review and optimize SLAs to balance sustainability and business needs.
* **Decommission Unused Assets:** Stop maintaining unnecessary resources to reduce waste.
* **Geographic Optimization:** Reduce network distances to minimize required resources.
* **Resource Optimization:** Implement buffering or throttling to flatten demand curves and reduce over-provisioned capacity.

---

## 1.14 Software and Architecture Patterns

Optimizing **software and architecture** is critical to sustainability.

Best practices include:

* **Optimize Jobs:** Use asynchronous or scheduled jobs and queue-driven architectures to maintain high resource utilization.
* **Remove or Refactor Low-Use Components:** Minimize waste by removing unused components or refactoring low-utilization ones.
* **Optimize Resource-Intensive Code:** Focus on code that consumes the most time or resources.
* **Minimize Impact on Customer Devices:** Reduce the environmental impact by understanding device usage and optimizing accordingly.
* **Support Efficient Data Access & Storage:** Design architectures that reduce compute, networking, and storage needs.

---

## 1.16 Data Patterns

Efficient **data management** reduces resource usage and energy consumption.

Best practices include:

* **Data Classification:** Classify data to determine criticality and choose the most energy-efficient storage.
* **Lifecycle Management:** Enforce deletion timelines and use elasticity/automation to optimize storage.
* **Remove Redundant Data:** Avoid unnecessary duplication and use shared storage.
* **Minimize Data Movement:** Use shared file systems or object storage to reduce network resource usage.
* **Backup Only Valuable Data:** Limit backups to data needed for business value or compliance.

---

## 1.18 Hardware and Services

Optimize **hardware and services** to reduce sustainability impacts.

Best practices include:

* **Use Minimal Hardware:** Only provision what is necessary for efficiency.
* **Leverage Efficient Instance Types:** Monitor new instance types for energy efficiency improvements.
* **Use Managed Services:** Managed services operate more efficiently and reduce infrastructure needs.
* **Optimize Compute Accelerators:** Reduce physical infrastructure demands by using hardware accelerators efficiently.

---

## 1.20 Process and Culture

Sustainability also involves **organizational practices and culture**.

Best practices include:

* **Validate Improvements:** Use processes that minimize testing costs while validating potential sustainability improvements.
* **Keep Workloads Updated:** Adopt efficient features, fix issues, and improve efficiency.
* **Increase Resource Utilization:** Ensure development, testing, and build resources are used efficiently.
* **Use Managed Device Farms:** Test new features on representative hardware to reduce resource consumption.

---
