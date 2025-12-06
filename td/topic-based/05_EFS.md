# EFS

## Question 1

**A leading e-commerce company is in need of a storage solution that can be simultaneously accessed by 1000 Linux servers in multiple availability zones. The servers are hosted in EC2 instances that use a hierarchical directory structure via the NFSv4 protocol. The service should be able to handle rapidly changing data at scale while maintaining high performance. It should also be highly durable and highly available whenever the servers pull data from it, with little need for management.**

As the Solutions Architect, which of the following services is the most cost-effective choice that you should use to meet the above requirement?

**Options:**

* Amazon EBS
* Amazon S3
* Amazon FSx for Windows File Server
* Amazon EFS

<details>

<summary>Explanation</summary>

🟢 **Amazon Web Services (AWS)** offers multiple **cloud storage services** to support a wide range of storage workloads such as **Amazon EFS**, **Amazon S3**, and **Amazon EBS**.
To choose the right one, you need to understand which service fits your **specific workload**.
In this scenario, the keywords are 👉 **rapidly changing data** and **1000 Linux servers.**

#### 🟢 **Amazon EFS (Elastic File System)**

**Amazon EFS** is a **file storage service** for use with **Amazon EC2**.
It provides:

* A **file system interface** and **POSIX-compatible access semantics** (e.g., **strong consistency** and **file locking**)
* **Concurrent access** for **thousands of EC2 instances**
* **Automatic scaling** and **high availability** across multiple AZs

📌 **Best for:** Rapidly changing data, shared file systems, and workloads requiring multiple EC2 instances (like 1000 Linux servers).

💡 **Amazon EFS** is the **most suitable choice** when you need:

* A **shared file system** between instances
* **High performance** and **concurrent access**
* **Strong consistency** with **low-latency file access**

#### 🟢 **Amazon EBS (Elastic Block Store)**

**Amazon EBS** is a **block-level storage service** for use with **Amazon EC2**.
It provides **low-latency access** to data from a **single EC2 instance**.

📌 **Best for:** Workloads that require **dedicated storage performance**, such as databases or applications needing **fast local disk I/O**.

⚠️ **Limitation:** An **EBS volume cannot be shared** across multiple EC2 instances simultaneously (except io1/io2 Multi-Attach volumes, and only within one AZ).

#### 🟢 **Amazon S3 (Simple Storage Service)**

**Amazon S3** is an **object storage service** that makes data accessible **via an Internet API** from **anywhere**.
It's designed for **high durability**, **availability**, and **virtually unlimited scalability**.

📌 **Best for:** Backup, archival, media storage, static assets, and big data workloads — **not** rapidly changing or frequently updated data.

⚠️ **Limitation:**

* **Not suitable** for rapidly changing data
* Lacks **file locking** and **strong consistency semantics** for frequent updates

#### 🟢 **In this scenario → Correct Answer: Amazon EFS**

✅ **Amazon EFS** is the best choice because:

* It supports **rapidly changing data**
* It allows **simultaneous access** by up to **thousands of EC2 instances**
* It provides **file-level access**, **strong consistency**, and **file locking**
* It offers **high performance**, **durability**, and **scalability** for **Linux servers**

#### 🔴 **Incorrect Options**

🚫 **Amazon S3:** 
Although it provides **high scalability and availability**, it is **not designed** for **rapidly changing data**.
It lacks **strong consistency and file locking**, which makes it **less suitable** for concurrent write-heavy workloads.

🚫 **Amazon EBS:**
Provides **low-latency block storage** for a **single instance only**.
Cannot be shared across multiple EC2 instances, hence **not suitable** for a **1000-server** setup.

🚫 **Amazon FSx for Windows File Server:**
Supports **multiple EC2 connections**, but it's **Windows-only**.
The scenario specifies **Linux servers**, so this option is **not applicable.**

✅ **Final Answer:**
🟢 **Use Amazon EFS** — it provides the required **performance**, **scalability**, **durability**, and **concurrent file access** for **1000 Linux servers** handling **rapidly changing data.**

</details>

---