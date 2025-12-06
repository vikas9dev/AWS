# Deep Dive on the Reliability Pillar

## 1.1–1.2 Welcome & Learning Objectives

* Module focus: **Reliability Pillar** of AWS Well-Architected Framework.
* Learn **design principles** and **best practices** to build reliable workloads.

---

## 1.3–1.5 Reliability Pillar Overview

* **Reliability:** Ability of a workload to perform its function correctly and consistently over time.
* Includes **operating, testing, and recovering** workloads throughout their lifecycle.
* Goal: Ensure workloads continue to function under expected and unexpected conditions.

---

## 1.6–1.7 Reliability Design Principles

1. **Automatically recover from failure**

   * Monitor **business KPIs** rather than just technical metrics.
   * Automate notifications, tracking, and remediation.

2. **Test recovery procedures**

   * Simulate failures and validate recovery before real incidents occur.

3. **Scale horizontally**

   * Use multiple small resources instead of one large resource to reduce single points of failure.

4. **Stop guessing capacity**

   * Monitor demand, automate resource scaling to meet demand without over-/under-provisioning.

5. **Manage change through automation**

   * Use automation for all infrastructure changes and track/review updates.

---

## 1.8–1.9 Reliability Best Practices Areas

Reliability best practices are organized into **four key areas**:

1. **Foundations** – Set up infrastructure requirements (e.g., bandwidth, quotas) before workloads.
2. **Workload Architecture** – Design software and infrastructure for reliability.
3. **Change Management** – Plan for internal changes and demand spikes.
4. **Failure Management** – Prepare for potential failures, even with cloud-level resilience (e.g., **EBS replication, S3 eleven-nines durability**).

> **Prerequisite:** Ensure teams are trained on business objectives and reliability goals.

---

## 1.10 Foundations

### Manage Service Quotas and Constraints

* **Service quotas** (limits) exist to prevent accidental over-provisioning and protect services.
* **Action items:**

  * Know default quotas and request increases as needed.
  * Manage quotas across accounts, Regions, and nonproduction environments.
  * Automate quota alerts and increases using APIs.
  * Maintain sufficient gaps to handle failover and overlapping resources.

### Plan Network Topology

* Consider **multi-environment workloads**: cloud + on-premises.
* Use **highly available public endpoints** via DNS, CDNs, API Gateway, load balancers.
* Ensure **redundant connectivity** for private networks (Direct Connect, VPN, multiple Regions).
* IP address planning:

  * Ensure VPC/subnet size accommodates growth.
  * Prefer **hub-and-spoke** over mesh for multiple network address spaces (e.g., Transit Gateway).
  * Avoid overlapping private IP ranges between VPCs, on-premises, or other clouds.

---

## 1.13–1.14 Workload Architecture

### Design Workload Service Architecture

* Use **service-oriented architecture (SOA)** or **microservices**:

  * Break down workloads into smaller, reusable components.
  * Favor **statelessness** for microservices deployment.
* **Domain-focused services:**

  * Each service performs a single business function.
  * Enables precise reliability requirements and small, focused teams.
* **Service contracts per API:**

  * Define API agreements, rate limits, performance expectations.
  * Use **versioning** to avoid breaking changes.
  * Teams can choose technology stacks independently, as long as contracts are honored.

---

## 1.15 Design Interactions in a Distributed System to Prevent Failures

* **Distributed systems** rely on networks; design to withstand **latency and data loss**.
* Best practices to prevent failures (increase **MTBF**):

  1. **Identify system type:**

     * **Hard real-time:** synchronous, rapid responses.
     * **Soft real-time:** response within minutes.
     * **Offline:** batch or asynchronous processing.
  2. **Loosely coupled dependencies:** Use queues, streaming, workflows, load balancers to isolate components.
  3. **Do constant work:** Avoid large, rapid changes in processing to maintain stability.
  4. **Idempotent responses:** Each request produces the same effect regardless of retries.

     * Use **idempotency tokens** to safely repeat requests.

---

## 1.16 Design Interactions to Mitigate or Withstand Failures

* Focus on **MTTR** (mean time to recovery) and stress/failure mitigation:

  1. **Graceful degradation:** Convert hard dependencies to soft; respond with static data if dependency fails.
  2. **Throttling requests:** Limit client requests during demand spikes.
  3. **Controlled retries:** Use **exponential backoff** with jitter; limit retries.
  4. **Fail fast & limit queues:** Release resources immediately if workload can’t handle requests; avoid stale queues.
  5. **Client timeouts:** Set appropriate timeouts, do not rely on defaults.
  6. **Stateless services:** Avoid local state; store externally if needed.
  7. **Emergency levers:** Rapid processes to mitigate availability impact.

---

## 1.17 Change Management

* Changes can be **internal** (patches, features) or **external** (demand spikes).
* Reliable workloads require anticipation and accommodation of these changes.

---

## 1.18 Monitor Workload Resources

* **Logs and metrics:** Track health and performance; detect threshold breaches.
* **Automation:** Replace failed components automatically; notify teams.
* **Analytics:** Collect and analyze historical metrics for trends.
* **End-to-end tracing:** Use **AWS X-Ray** or third-party tools to debug distributed systems.

---

## 1.19 Design a Workload to Adapt to Demand

* **Scalable workloads** automatically add/remove resources to match demand.
* **Automation:** Use **AWS Auto Scaling**, **S3**, SDKs, or third-party tools.
* **Reactive scaling:** Triggered by impaired resources; requires health checks.
* **Proactive scaling:** Anticipates demand spikes; use load testing to validate capacity.

---

## 1.20 Implement Change

* Controlled change ensures predictable operation and software patching:

  1. **Runbooks:** Predefined procedures for deployments, patches, DNS changes.
  2. **Functional testing:** Automated tests in pre-production pipelines; halt/rollback if failure occurs.
  3. **Resiliency testing:** Chaos engineering in pre-production; also run during game days.
  4. **Immutable infrastructure:** Deploy new instances for changes; no in-place updates; automates patching safely.

---

## 1.21 Failure Management

* **Cloud provides resilience**, but failures can still occur.
* **Prerequisites:** Designers and operators must understand **business objectives and reliability goals**.
* Best practices focus on implementing **resiliency mechanisms** to minimize workload impact.

---

## 1.22 Back Up Data

* **Back up all critical data, applications, and configurations** to meet **RTO** (Recovery Time Objective) and **RPO** (Recovery Point Objective).
* **Select backup strategy** based on recovery time and complexity.
* **Secure backups:**

  * Encrypt backups.
  * Control and monitor access using **IAM**.
  * Detect data integrity issues.
* **Automate backups:** Schedule based on RPO or dataset changes.
* **Verify backup integrity:** Perform periodic recovery tests to ensure RTO and RPO compliance.

---

## 1.23 Use Fault Isolation to Protect Workloads

* **Limit failure impact:** Isolate boundaries so failures affect only a subset of components.
* **Multi-location deployment:**

  * Spread workloads across multiple **Availability Zones (AZs)** or **Regions**.
  * Automate recovery for single-location constrained components.
* **Bulkhead architectures:**

  * Contain failures to partitions (data) or cells (services), limiting impact to a small subset of requests.

---

## 1.24 Design Workloads to Withstand Component Failures

* **Monitor all components:** Track KPIs based on business value.
* **Failover to healthy resources:** Ensure continuity in case of component, AZ, or Region failure.
* **Automate healing:** Restart or remediate failed components automatically; keep services **stateless** where possible.
* **Use data plane for recovery:** Avoid control plane reliance for critical recovery steps.
* **Static stability:** Avoid bimodal behavior; provision enough instances to handle loads even if a zone fails.
* **Notify on significant events** and design workloads to meet **availability targets/SLAs**.

---

## 1.25 Test Reliability

* **Validate resilience:** Test workloads against production stresses and nonfunctional requirements.
* **Use playbooks:** Standardized investigation steps for failures.
* **Post-incident analysis:** Identify causes, mitigation actions, and preventive measures.
* **Testing methods:**

  * Functional tests (unit & integration).
  * Scaling & performance tests (load testing).
  * Resiliency tests (chaos engineering).
* **Conduct game days:** Simulate failure scenarios in production or near-production environments with all relevant teams.

---

## 1.26 Plan for Disaster Recovery (DR)

* **Disaster recovery = backups + redundant components** to meet RTO/RPO.
* **Consider business value:** Factor in disruption probability and recovery cost.
* **DR vs Availability:**

  * **Availability:** Component-level uptime and failover.
  * **Disaster Recovery:** Full workload recovery after catastrophic events.
* **Set recovery objectives:**

  * **RTO:** Maximum downtime allowed.
  * **RPO:** Maximum acceptable data loss.
* **Recovery strategies:** Backup & restore, active-passive, active-active.
* **Test failover:** Ensure RTO/RPO are met.
* **Manage configuration drift:** Keep DR site infrastructure, data, and configurations up to date.
* **Automate recovery:** Use AWS or third-party tools to restore services and route traffic to DR sites.

---

## 1.30 Summary

* Reliability pillar ensures workloads perform consistently and correctly over time.
* Key practices include:

  * Designing **resilient, distributed workloads**.
  * Implementing **fault isolation, automated healing, and failover mechanisms**.
  * **Monitoring, testing, and practicing DR**.
  * Aligning workloads to meet **business objectives, RTO, RPO, and SLAs**.

---
