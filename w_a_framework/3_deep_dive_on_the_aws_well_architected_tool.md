# Module 3: AWS Well-Architected Tool Deep Dive

## 1.1 Welcome

Welcome to **Module Three of AWS Well-Architected: Deep Dive on the AWS Well-Architected Tool**.

---

## 1.2 Learning Objectives

In this module, you will learn:

* The **components and features** of the AWS Well-Architected Tool.
* How to **use the tool** to conduct a Well-Architected Framework Review.
* Where to **learn more** about the tool and its capabilities.

---

## 1.3 A Mechanism for Continuous Improvement

To achieve the desired outcomes from a framework review, consider it part of a **continuous improvement plan** integrated with your workload lifecycle.

The mechanism includes three steps:

1. **Learn strategies and best practices** for architecting in the cloud.
2. **Measure your architecture** using the framework, AWS Well-Architected lenses, and **custom lenses** within the AWS Well-Architected Tool.
3. **Improve your cloud architecture** by addressing high-risk issues identified through:

   * Improvement plans
   * Well-Architected Labs
   * AWS Partner Network
   * AWS solutions architecture teams

> ⚠️ This three-step mechanism should be applied **consistently** to every workload in your organization.
> A workload represents a set of components that together deliver **business value**. More details on workloads are covered in a later module.

---

## 1.4 Components of the Well-Architected Framework

The framework includes:

* **Content** to help learn AWS best practices.
* **A tool** to measure workloads and teams against best practices.
* **Data** acquired during workload reviews, which can be used to continuously improve workloads and operations.

In this module, you will dive deeper into **how the AWS Well-Architected Tool can help customers measure and improve workloads over time**.

---

## 1.5 AWS Well-Architected Tool

The **AWS Well-Architected Tool** is designed to:

* Review the **state of your applications and workloads**.
* Provide a **central place for architectural best practices and guidance**.
* Support **custom lenses** for adding your own best practice guidance.

**Getting started:**

* Complete a **Well-Architected Framework Review** via the console or APIs.
* Create the **workload in your AWS account** to store data securely with **least-privilege access**.
* Share workloads and custom lenses with **solutions architects** or **partner resources** for collaboration.

---

## 1.6 AWS Well-Architected Tool Overview

* The **dashboard** shows resources for the selected Region.
* Updates to the **framework and tool** are based on customer feedback.
* Workloads can be upgraded using **View available upgrades**.
* The **Workloads list** shows:

  * Name
  * Owner
  * Number of questions answered
  * Number of risks identified
* You can also **define a new workload** from this console.

---

## 1.7 AWS Well-Architected Tool: Creating a New Workload

When creating a workload, you need:

* **Unique, descriptive name** to identify it.
* **Description** documenting its scope and purpose.
* **Review owner** (mandatory since 2020) responsible for:

  * Completing the review
  * Reporting risk status
  * Tracking improvements over time
* **Environment**: Production or Pre-production

---

## 1.8 AWS Well-Architected Tool: New Workload (Continued)

Additional fields:

* **Regions** where the workload runs (for search, sort, filter purposes).
* **Account ID(s)** if workload spans multiple accounts. No IAM permissions are required by default. Programmatic access may need permission changes.
* **Optional architectural design URL** for reference during the review.
* **Industry type and category** for better sorting, filtering, and searching across workloads.

> 💡 Tip: Workloads can include resources outside AWS, such as **on-premises or other cloud environments**.

---

## 1.9 AWS Well-Architected Tool: Workload Details

After creating or selecting a workload, you can:

* Edit or delete the workload.
* View:

  * Number of questions answered
  * Risks identified
* **Save milestones** to track progress during framework reviews.

---

## 1.10 Workload Details (Continued)

* **Notes section**: Track progress, changes, or upcoming launch info.
* **Applied lenses**: Default and custom lenses (covered in another session).
* **Pillar priority**: Default order reflects common customer approach. Can be edited to reorder questions and recommendations based on your priorities.

---

## 1.11 AWS Well-Architected Tool: Milestones

Milestones track workload changes over time:

* Typically created after the **initial review**.
* Update answers, notes, and best practices to reflect improvements.
* Generate reports based on saved milestones.
* View all milestones using **View milestones**.

---

## 1.12 AWS Well-Architected Tool: Sharing

* Share workloads with other **users, accounts, or AWS organizations**.
* Search or filter to find current workload shares.
* View **principal type** (IAM user, AWS account, or AWS organization).
* Review **share status** (pending or accepted) and permissions granted.

---

## 1.13 AWS Well-Architected Tool: Content

Each question in the tool includes:

* **Pillar and question number**
* **Key concept** (e.g., Cost 6 question focuses on **rightsizing**)
* **Check boxes** representing best practices
* **Detail bar**: Additional explanations and resources for implementing best practices

> 💡 Tip: Concepts help implement the **design principles** for each pillar.

---

## 1.14 AWS Well-Architected Tool: Custom Lenses

* Custom lenses can include:

  * Pillars, questions, answer choices
  * Helpful resources, improvement plans
  * Risk rules (high/medium) and guidance
* Custom lenses can be shared across accounts, with solutions architects, or partners.
* Steps: Download JSON template → Upload lens → Apply to workload review

---

## 1.15 What's New with AWS Well-Architected?

**Recent updates include:**

* **Sustainability pillar** (introduced re:Invent 2021, available March 2022)

  * Helps reduce environmental impact of cloud workloads
* **AWS re:Post integration**

  * Community-driven Q&A for removing technical roadblocks and enhancing operations
* **AWS Organizations integration** (June 2022)

  * Share workloads and lenses across multiple accounts efficiently
* **AWS GovCloud (US) availability** (August 2022)

  * Supports regulated workloads in public and commercial sectors
* **AWS Trusted Advisor integration**

  * Provides findings from automated resource checks for better review accuracy
* **AWS Service Catalog AppRegistry integration**

  * Tracks workloads’ associated applications and resources, saving time

---

## 1.20 Summary

In this module, you learned:

* **Components and features** of the AWS Well-Architected Tool
* **How to conduct a Well-Architected Framework Review**
* **Where to learn more** about the tool and its updates

---

