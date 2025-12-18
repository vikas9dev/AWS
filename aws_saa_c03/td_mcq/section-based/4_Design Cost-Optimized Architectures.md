# Design Cost-Optimized Architectures

## Question 1

**A solutions architect is managing an application that runs on a Windows EC2 instance with an attached Amazon FSx for Windows File Server. To save cost, management has decided to stop the instance during off-hours and restart it only when needed. It has been observed that the application takes several minutes to become fully operational, which impacts productivity.**

**How can the solutions architect speed up the instance’s loading time without driving the cost up?**

- 🅐 Migrate the application to a Linux-based EC2 instance.
- 🅑 Migrate the application to an EC2 instance with hibernation enabled.
- 🅒 Disable the Instance Metadata Service to reduce the things that need to be loaded at startup.
- 🅓 Enable the hibernation mode on the EC2 instance.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅑

**Migrate the application to an EC2 instance with hibernation enabled.**

### Why 🅓 is incorrect (your point is correct)

- **EC2 hibernation must be enabled at instance launch time**
- You **cannot enable or disable hibernation on an already running instance**
- Therefore, option 🅓 is **technically invalid**

AWS explicitly requires:

- Hibernation enabled **during instance creation**
- Supported instance types and AMIs
- Encrypted root EBS volume

The option that says: Enable the hibernation mode on the EC2 instance is incorrect. It is **not possible to enable or disable hibernation for an instance after it has been launched**.

</details>

---

## Question 2

\*\*A company is building an internal application that allows users to upload images. Each upload request must be sent to Amazon Kinesis Data Streams for processing before the pictures are stored in an Amazon S3 bucket.

The application should immediately return a success message to the user after the upload, while the downstream processing is handled asynchronously. The processing typically takes about 5 minutes to complete.

Which solution will enable asynchronous processing from Kinesis to S3 in the most cost-effective way?\*\*

- 🅐 Send data from Kinesis Data Streams to Amazon Kinesis Data Firehose and configure it to deliver directly to S3.
- 🅑 Use Kinesis Data Streams with AWS Lambda consumers to asynchronously process records and write them to S3.
- 🅒 Use a combination of AWS Lambda and AWS Step Functions to orchestrate service components and asynchronously process the requests.
- 🅓 Use a combination of Amazon SQS to queue the requests and then asynchronously process them using On-Demand Amazon EC2 instances.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅑

**Use Kinesis Data Streams with AWS Lambda consumers to asynchronously process records and write them to S3.**

### Explanation

The key requirements are:

- **Immediate response** to the user after upload
- **Asynchronous processing** of data
- Processing time of **~5 minutes**
- **Cost-effective** solution

**Kinesis Data Streams + AWS Lambda consumers** is the best fit:

- Lambda can be configured as a **Kinesis consumer** to process records asynchronously.
- The user-facing application can return success **immediately after putting records into Kinesis**.
- Lambda is **serverless**, so there are no idle costs.
- Writing processed data to **Amazon S3** is straightforward and fully managed.
- This approach minimizes infrastructure and operational overhead.

### Why the other options are not the best choice

- ❌ **🅐 Kinesis Data Firehose to S3**
  Firehose is optimized for **near-real-time delivery**, buffering, and transformation—not for **custom processing that takes several minutes**.

- ❌ **🅒 Lambda + Step Functions**
  Adds orchestration complexity and additional cost without providing benefits over a simple Lambda consumer.

- ❌ **🅓 SQS + EC2**
  Requires managing EC2 instances and scaling, resulting in **higher operational and cost overhead**.

### Key takeaway 📌

When you need:

- Immediate acknowledgment to users
- Asynchronous stream processing
- Minimal cost and operations

👉 **Kinesis Data Streams with AWS Lambda consumers** is the most cost-effective and scalable solution.

</details>

---

## Question 3

**A company hosted a web application in an Auto Scaling group of EC2 instances. The IT manager is concerned about the over-provisioning of resources that can cause higher operating costs. A Solutions Architect has been instructed to create a cost-effective solution without affecting the performance of the application.**

**Which dynamic scaling policy should be used to satisfy this requirement?**

- 🅐 Use suspend and resume scaling.
- 🅑 Use target tracking scaling.
- 🅒 Use scheduled scaling.
- 🅓 Use simple scaling.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅑

**Use target tracking scaling.**

Note:- The option that says: Use simple scaling is incorrect because you need to wait for the cooldown period to complete before initiating additional scaling activities. Target tracking or step scaling policies can trigger a scaling activity immediately without waiting for the cooldown period to expire.

### Explanation

The requirement is to:

- Avoid **over-provisioning**
- Maintain **application performance**
- Use a **cost-effective**, automated approach

**Target tracking scaling** is designed specifically for this:

- Automatically adjusts the number of instances to keep a chosen metric (for example, **average CPU utilization** or **request count per target**) at a defined target value.
- Scales **out and in dynamically**, adding capacity only when needed and removing excess capacity when demand drops.
- Requires minimal configuration and continuously optimizes cost vs performance.

### Why the other options are not suitable

- ❌ **Suspend and resume scaling**
  Disables scaling actions and risks under- or over-provisioning.

- ❌ **Scheduled scaling**
  Works only for **predictable traffic patterns** and cannot react to real-time load changes.

- ❌ **Simple scaling**
  Uses fixed thresholds and cooldowns, which can lead to slower response and inefficient capacity usage.

### Key takeaway 📌

For applications with **variable or unpredictable traffic**, the most cost-effective and performance-safe scaling policy is:

👉 **Target tracking scaling**

</details>

---

## Question 4

\*\*A company is looking to store its confidential financial files in AWS, which are accessed every week. The Architect was instructed to set up the storage system, which uses envelope encryption and automates key rotation. It should also provide an audit trail that shows who used the encryption key and by whom for security purposes.

Which combination of actions should the Architect implement to satisfy the requirement in the most cost-effective way? (Select TWO.)\*\*

- 🅐 Configure Server-Side Encryption with Customer-Provided Keys (SSE-C).
- 🅑 Use Amazon S3 Glacier Deep Archive to store the data.
- 🅒 Use Amazon S3 to store the data.
- 🅓 Configure Server-Side Encryption with Amazon S3-Managed Keys (SSE-S3).
- 🅔 Configure Server-Side Encryption with AWS KMS Keys (SSE-KMS).

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answers: 🅒 and 🅔

**Use Amazon S3 to store the data** and **configure Server-Side Encryption with AWS KMS Keys (SSE-KMS).**

---

### Explanation

The requirements are:

- Store **confidential financial files**
- Files are **accessed weekly**
- Must use **envelope encryption**
- Must **automate key rotation**
- Must provide an **audit trail** showing **who used the encryption key and when**
- Be **cost-effective**

---

### 🔐 Understanding AWS KMS and Envelope Encryption

A **KMS key** is a logical representation of a cryptographic key. It includes:

- Metadata such as **key ID, creation date, description, and key state**
- The **key material** used to encrypt and decrypt data

You can use a KMS key to encrypt and decrypt up to **4 KB (4096 bytes)** of data.
In practice, KMS keys are used to **generate, encrypt, and decrypt data keys**, which are then used outside AWS KMS to encrypt the actual data.
This approach is called **envelope encryption**.

---

### 🔑 Server-Side Encryption Options in Amazon S3

You have **three mutually exclusive options** for managing encryption keys in S3:

#### 1️⃣ SSE-S3 (Amazon S3–Managed Keys)

- Each object is encrypted with a **unique key**
- The key itself is encrypted with a **master key that Amazon rotates regularly**
- Uses **AES-256**
- **No audit trail** of key usage
- **Lowest cost**, but limited security visibility

#### 2️⃣ SSE-KMS (AWS Key Management Service)

- Uses **AWS KMS keys** (AWS-managed or customer-managed)
- Implements **envelope encryption**
- Provides:

  - **Automatic key rotation**
  - **Fine-grained access control** via IAM
  - **Audit trail** showing **who used the KMS key and when** (via AWS CloudTrail)

- Slightly higher cost than SSE-S3, but required for compliance and auditing

#### 3️⃣ SSE-C (Customer-Provided Keys)

- You manage and supply the encryption keys
- Amazon S3 handles encryption/decryption
- **No key rotation automation**
- **No audit trail**
- Higher operational burden

---

### Why the correct answers fit best

- ✅ **Amazon S3 (🅒)**

  - Ideal for files accessed **weekly**
  - Cost-effective compared to archival tiers
  - Supports all server-side encryption options

- ✅ **SSE-KMS (🅔)**

  - Meets **envelope encryption** requirement
  - Provides **automatic key rotation**
  - Provides a **full audit trail** of key usage
  - Meets security and compliance needs for financial data

---

### ❌ Why the other options are incorrect

- ❌ **🅐 SSE-C**

  - No automated rotation
  - No audit trail
  - High key-management overhead

- ❌ **🅑 S3 Glacier Deep Archive**

  - Designed for **rarely accessed data**
  - Weekly access would cause **high retrieval latency and cost**

- ❌ **🅓 SSE-S3**

  - No visibility into **who used the encryption key**
  - Does not meet audit trail requirement

---

### Key takeaway 📌

For confidential financial data that requires:

- Envelope encryption
- Automated key rotation
- Auditing of key usage

👉 **Amazon S3 with SSE-KMS** is the most cost-effective and compliant solution.

</details>

---

## Question 5

**An organization is currently using a tape backup solution to store its application data on-premises. Plans are in place to use a cloud storage service to preserve the backup data for up to 10 years, which may be accessed about once or twice a year.**

**Which of the following is the most cost-effective option to implement this solution?**

- 🅐 Use AWS Storage Gateway to back up the data and transition it to Amazon S3 Glacier Deep Archive.
- 🅑 Use Amazon S3 to store the backup data and add a lifecycle rule to transition the current version to S3 Glacier Flexible Retrieval.
- 🅒 Use AWS Storage Gateway to back up the data directly to Amazon S3 Glacier Flexible Retrieval.
- 🅓 Order an AWS Snowball Edge appliance to import the backup directly to Amazon S3 Glacier Flexible Retrieval.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅐

**Use AWS Storage Gateway to back up the data and transition it to Amazon S3 Glacier Deep Archive.**

---

### Explanation

The key requirements are:

- Existing **tape-based backup solution**
- **Long-term retention (up to 10 years)**
- Data accessed **once or twice per year**
- **Most cost-effective** cloud solution

---

### Why AWS Storage Gateway (Tape Gateway) is required

**AWS Tape Gateway** enables you to:

- Replace **physical tapes on-premises** with **virtual tapes in AWS**
- Continue using **existing backup workflows and software**
- Cache data locally for **low-latency access**
- **Encrypt data in transit**
- Automatically **compress and transition** virtual tapes to lower-cost storage

Tape Gateway supports archiving virtual tapes to:

- **Amazon S3 Glacier Flexible Retrieval**
- **Amazon S3 Glacier Deep Archive**

This makes it the **natural and correct choice** when an organization already uses tape backups.

---

### Why Glacier Deep Archive is the most cost-effective

- **Amazon S3 Glacier Deep Archive** is designed for:

  - **Very long-term retention**
  - **Rare access (once or twice per year)**

- It offers the **lowest storage cost** of all AWS storage classes
- Ideal for **10-year retention requirements**

By transitioning archived virtual tapes to **Glacier Deep Archive**, organizations can reduce monthly storage costs by **up to 75%** compared to Glacier Flexible Retrieval.

---

### Why the other options are incorrect

- ❌ **🅒 Storage Gateway → Glacier Flexible Retrieval**
  While valid, **Glacier Flexible Retrieval is more expensive** than Glacier Deep Archive and is not optimal for data accessed only once or twice a year.

- ❌ **🅑 Amazon S3 + lifecycle to Glacier Flexible Retrieval**
  Does not leverage the **existing tape backup workflow**, increasing migration effort and operational complexity.

- ❌ **🅓 AWS Snowball Edge**
  Best suited for **one-time large data migrations**, not ongoing tape-based backups.

---

### Key takeaway 📌

When:

- You already use **tape backups**
- Data must be retained for **many years**
- Access is **very infrequent**
- Cost optimization is critical

👉 The most cost-effective solution is **AWS Tape Gateway with Amazon S3 Glacier Deep Archive**.

</details>

---

## Question 6

\*\*A multinational corporate and investment bank regularly processes steady workloads of accruals, loan interests, and other critical financial calculations every night from 10 PM to 3 AM on their on-premises data center for their corporate clients. Once the process is done, the results are uploaded to the Oracle General Ledger, which means that the processing should not be delayed or interrupted. The CTO has decided to move its IT infrastructure to AWS to save costs. The company needs to reserve compute capacity in a specific Availability Zone to properly run their workloads.

As the Senior Solutions Architect, how can you implement a cost-effective architecture in AWS for their financial system?\*\*

- 🅐 Use Dedicated Hosts, which provide a physical host that is fully dedicated to running your instances, and bring your existing per-socket, per-core, or per-VM software licenses to reduce costs.
- 🅑 Use **On-Demand Capacity Reservations**, which provide compute capacity that is always available in the specified Availability Zone.
- 🅒 Use Regional Reserved Instances to reserve capacity on a specific Availability Zone and lower the operating cost through its billing discounts.
- 🅓 Use On-Demand EC2 instances which allow you to pay for the instances that you launch and use by the second. Reserve compute capacity in a specific Availability Zone to avoid any interruption.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅑

**Use On-Demand Capacity Reservations**

### Explanation

The key requirements are:

- **Critical, non-interruptible nightly batch workloads**
- **Guaranteed capacity in a specific Availability Zone**
- **Predictable usage window (10 PM – 3 AM)**
- **Cost-effective solution**

**On-Demand Capacity Reservations** are the best fit because they:

- Guarantee **EC2 capacity availability in a specific Availability Zone**
- Ensure workloads are **not delayed or interrupted**
- Are billed at **On-Demand rates** only when instances are running
- Can be combined with **Savings Plans or Reserved Instances** for cost optimization

This directly satisfies the requirement for **capacity assurance without overpaying for unused resources**.

---

### Why On-Demand Capacity Reservations are the most cost-effective

On-Demand Capacity Reservations enable you to reserve compute capacity for your Amazon EC2 instances in a specific Availability Zone for any duration. This gives you the ability to create and manage Capacity Reservations independently from the billing discounts offered by Savings Plans or Regional Reserved Instances.

By creating Capacity Reservations, you ensure that you always have access to EC2 capacity when you need it, for as long as you need it. You can create Capacity Reservations at any time, without entering into a one-year or three-year term commitment, and the capacity is available immediately. Billing starts as soon as the capacity is provisioned and the Capacity Reservation enters the active state. When you no longer need it, cancel the Capacity Reservation to stop incurring charges.

![capacity-reservations](https://media.tutorialsdojo.com/SAA-C03%20-%20Capacity%20Reservation%20Comparison.png)

When you create a Capacity Reservation, you specify:

– The Availability Zone in which to reserve the capacity
– The number of instances for which to reserve capacity
– The instance attributes, including the instance type, tenancy, and platform/OS

Capacity Reservations can only be used by instances that match their attributes. By default, they are automatically used by running instances that match the attributes. If you don’t have any running instances that match the attributes of the Capacity Reservation, it remains unused until you launch an instance with matching attributes.

In addition, you can use Savings Plans and Regional Reserved Instances with your Capacity Reservations to benefit from billing discounts. AWS automatically applies your discount when the attributes of a Capacity Reservation match the attributes of a Savings Plan or Regional Reserved Instance.

In this scenario, the company only runs the process for 5 hours (from 10 PM to 3 AM) every night. By usinng Capacity Reservations, they not only ensure availability but can also implement automation to procure and cancel capacity, as well as terminate instances once they are no longer needed. This approach prevents them from incurring unnecessary charges, ensuring they are billed only for the resources they actually use.

---

### Why the other options are incorrect

- ❌ **Dedicated Hosts**
  Designed mainly for **licensing and compliance** needs. They are significantly more expensive and unnecessary if license portability is not the primary concern.

- ❌ **Regional Reserved Instances**
  Provide **billing discounts**, not **capacity guarantees in a specific Availability Zone**.

- ❌ **Plain On-Demand instances**
  Do **not guarantee capacity** in a specific Availability Zone during peak demand.

---

### Key takeaway 📌

When workloads:

- Are **mission-critical**
- Must **run at specific times**
- Require **guaranteed capacity in a specific AZ**
- Must remain **cost-efficient**

👉 **On-Demand Capacity Reservations** are the correct and recommended AWS solution.

</details>

---

## Question 7

\*\*A company plans to use a cloud storage service to temporarily store its log files. The number of files to be stored is still unknown, but it only needs to be kept for 12 hours.

Which of the following is the most cost-effective storage class to use in this scenario?\*\*

- 🅐 Amazon S3 Standard
- 🅑 Amazon S3 Glacier Deep Archive
- 🅒 Amazon S3 One Zone-IA
- 🅓 Amazon S3 Standard-IA

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅐

**Amazon S3 Standard**

### Explanation

Key requirements:

- **Very short retention period (12 hours)**
- **Unknown number of objects**
- **Low cost with no long-term commitment**

**Amazon S3 Standard** is the most cost-effective choice for this scenario because:

- There is **no minimum storage duration** requirement.
- You pay **only for what you store and for how long you store it**.
- It is ideal for **temporary, short-lived data** such as logs.
- Supports immediate access without retrieval fees or delays.

![S3 Minimum Duration](https://media.tutorialsdojo.com/amazon-s3-minimum-duration-charge-chart.JPG)

### Why the other options are incorrect

- ❌ **Amazon S3 Standard-IA**

  - Has a **minimum storage duration of 30 days**.
  - You would still be charged for 30 days even if the objects are deleted after 12 hours.
  - Includes **retrieval charges**, making it more expensive for short-lived data.

- ❌ **Amazon S3 One Zone-IA**

  - Also has a **30-day minimum storage duration**.
  - Designed for infrequently accessed data stored longer term.

- ❌ **Amazon S3 Glacier Deep Archive**

  - Has a **minimum storage duration of 180 days**.
  - Retrieval takes **hours**, not suitable for log files.
  - Extremely inefficient and expensive for temporary storage.

---

### Key takeaway 📌

For **temporary data stored for only a few hours**, the most cost-effective and correct option is:

👉 **Amazon S3 Standard**

Using IA or Glacier classes for short-lived data often **costs more**, not less, due to minimum storage duration charges.

</details>

---

## Question 8

\*\*A company has stored 200 TB of backup files in Amazon S3. The files are in a vendor-proprietary format. The Solutions Architect needs to use the vendor’s proprietary file conversion software to retrieve the files from their Amazon S3 bucket, transform the files into an industry-standard format, and re-upload the files back to Amazon S3. The solution must minimize the data transfer costs.

Which of the following options can satisfy the given requirement?\*\*

- 🅐 Install the file conversion software in Amazon S3. Use S3 Batch Operations to perform data transformation.
- 🅑 Deploy an EC2 instance in the same Region as Amazon S3. Install the file conversion software on the instance. Perform data transformation and re-upload it to Amazon S3.
- 🅒 Export the data using an AWS Snowball Edge device. Install the file conversion software on the device. Transform the data and re-upload it to Amazon S3.
- 🅓 Deploy the EC2 instance in a different Region. Install the conversion software on the instance. Perform data transformation and re-upload it to Amazon S3.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅑

**Deploy an EC2 instance in the same Region as Amazon S3 and perform the transformation there.**

### Explanation

The key requirements are:

- Data already **resides in Amazon S3**
- A **vendor-proprietary conversion tool** must be used
- **200 TB** of data (very large volume)
- **Minimize data transfer costs**

The most cost-effective approach is to **process the data as close to Amazon S3 as possible**.

By deploying an **EC2 instance in the same AWS Region as the S3 bucket**:

- Data transfer between **S3 and EC2 in the same Region is free**
- No internet egress or inter-Region transfer costs are incurred
- The vendor’s software can run without modification
- Transformed files can be uploaded back to S3 efficiently

---

### Why the other options are incorrect

- ❌ **🅐 Install software in Amazon S3**
  Amazon S3 is an object storage service and **cannot run software**. S3 Batch Operations can invoke Lambda, but **Lambda is not suitable** for proprietary, long-running, or heavy conversion workloads.

- ❌ **🅒 AWS Snowball Edge**
  Snowball is intended for **on-premises ↔ AWS data transfer**.
  The scenario does **not mention any on-premises data center**, and the data is already in S3. Using Snowball would add unnecessary cost and complexity.

- ❌ **🅓 EC2 in a different Region**
  This would incur **inter-Region data transfer charges**, which is expensive for 200 TB of data.

---

### Key takeaway 📌

When:

- Data is already in Amazon S3
- Large-scale processing is required
- Data transfer costs must be minimized

👉 **Run the processing on EC2 in the same Region as the S3 bucket**.

</details>

---

## Question 9

\*\*An e-commerce company plans to optimize its disaster recovery configuration using AWS Cloud to minimize operational disruptions during outages or major system maintenance for its on-premises Microsoft SQL Server–based application. The objective is to achieve a recovery point objective (RPO) of 60 seconds or less and a recovery time objective (RTO) of 1 hour.

Which of the following is the MOST cost-effective solution for this scenario?\*\*

- 🅐 On AWS, implement a warm standby using Amazon RDS for SQL Server database and configure AWS Database Migration Service (AWS DMS) with change data capture (CDC) to sync the data from the on-premises application.
- 🅑 Back up SQL Server to AWS Storage Gateway for hybrid storage and fast disaster recovery. Enable fast snapshot restore in Amazon Elastic Block Store (Amazon EBS).
- 🅒 Set up a pilot light strategy using AWS Elastic Disaster Recovery (AWS DRS) to replicate the changes of the on-premises application to AWS.
- 🅓 Use Microsoft SQL Server Enterprise with Always On availability groups and set up a multi-site active/active setup between the corporate on-premises application and AWS.

<details>
<summary>Answer & Explanation</summary>

### ✅ Correct Answer: 🅒

**Set up a pilot light strategy using AWS Elastic Disaster Recovery (AWS DRS).**

Note:- The option that says: On AWS, implement a warm standby using Amazon RDS for SQL Server database and configure AWS Database Migration Service (AWS DMS) with change data capture (CDC) to sync the data from the on-premises application is incorrect. Using the warm standby strategy actually meets the required RTO and RPO of the application; however, this is accompanied by a high cost since you have to maintain a running Amazon RDS for SQL database. A more cost-effective solution would be to use the AWS Elastic Disaster Recovery (AWS DRS) service which also offers excellent RTO and RPO.

### Explanation

The requirements are:

- **RPO ≤ 60 seconds**
- **RTO ≤ 1 hour**
- **Cost-effective disaster recovery**
- On-premises **SQL Server–based application**

**AWS Elastic Disaster Recovery (AWS DRS)** is specifically designed for this use case:

- Continuously replicates block-level changes from on-premises servers to AWS with **near-real-time replication**, easily meeting an **RPO of seconds**.
- Uses a **pilot light strategy**, where only minimal resources are running in AWS until a failover is needed, keeping costs low.
- During a disaster, AWS can quickly launch recovery instances, meeting the **1-hour RTO** requirement.
- Supports Windows workloads, including SQL Server, without requiring application changes.

---

### AWS DRS

AWS Elastic Disaster Recovery (AWS DRS) provides continuous block-level replication, recovery orchestration, and automated server conversion capabilities. These allow customers to achieve a crash-consistent recovery point objective (RPO) of seconds, and a recovery time objective (RTO) typically ranging between 5–20 minutes.

![AWS DRS](https://media.tutorialsdojo.com/aws-elastic-disaster-recovery_17jul2023.png)

In the event of a disaster, AWS Elastic Disaster Recovery (AWS DRS) assists in performing a failover to AWS for immediate recovery. After mitigating the disaster, a failback to the original source infrastructure is necessary. AWS DRS facilitates preparedness through easy drill launches and frequent testing of instances. During a failover, recovery instances are launched in AWS based on a selected snapshot. To complete the failback, the AWS Elastic Disaster Recovery Failback Client is installed on the target server, and specific credentials are generated. Cross-Region or cross-AZ failover and failback can be executed directly from the AWS DRS Console. For vCenter, AWS DRS offers scalable failback with the DRS Mass Failback Automation client (DRSFA client). Once the failback is finished, the recovery instance can be terminated, deleted, or disconnected.

To establish a secure data replication process, configure AWS Elastic Disaster Recovery on your source servers. This setup involves replicating your data to a dedicated subnet within your AWS account located in the AWS Region of your choice. By utilizing a staging area design, this approach optimizes cost-efficiency by leveraging cost-effective storage and minimal compute resources for continuous replication maintenance.

---

### Why the other options are less cost-effective

- ❌ **🅐 Warm standby with RDS + DMS**
  Requires always-on database resources in AWS, increasing cost. More complex and unnecessary for DR-only use cases.

- ❌ **🅑 Storage Gateway + EBS snapshots**
  Backup-based recovery typically cannot meet an **RPO of 60 seconds** and is not designed for near-real-time replication.

- ❌ **🅓 SQL Server Always On (active/active)**
  Provides very low RPO/RTO but is **the most expensive option**, requiring SQL Server Enterprise licenses and continuously running infrastructure.

---

### Key takeaway 📌

When you need:

- **Near-zero data loss**
- **Fast recovery**
- **Lowest possible DR cost**

👉 **AWS Elastic Disaster Recovery (AWS DRS) with a pilot light strategy** is the most cost-effective and purpose-built solution.

</details>

---
