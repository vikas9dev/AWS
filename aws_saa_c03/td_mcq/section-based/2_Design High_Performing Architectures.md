# Design High-Performing Architectures

## Question 1

**A company has hundreds of VPCs with multiple VPN connections to their data centers spanning 5 AWS Regions. As the number of its workloads grows, the company must be able to scale its networks across multiple accounts and VPCs to keep up. A Solutions Architect is tasked to interconnect all of the company’s on-premises networks, VPNs, and VPCs into a single gateway, which includes support for inter-region peering across multiple AWS regions.
Which of the following is the BEST solution that the architect should set up to support the required interconnectivity?**

* Set up an AWS Transit Gateway in each region to interconnect all networks within it. Then, route traffic between the transit gateways through a peering connection.
* Set up an AWS Direct Connect Gateway to achieve inter-region VPC access to all of the AWS resources and on-premises data centers. Set up a link aggregation group (LAG) to aggregate multiple connections at a single AWS Direct Connect endpoint in order to treat them as a single, managed connection. Launch a virtual private gateway in each VPC and then create a public virtual interface for each AWS Direct Connect connection to the Direct Connect Gateway.
* Set up an AWS VPN CloudHub for inter-region VPC access and a Direct Connect gateway for the VPN connections to the on-premises data centers. Create a virtual private gateway in each VPC, then create a private virtual interface for each AWS Direct Connect connection to the Direct Connect gateway.
* Enable inter-region VPC peering that allows peering relationships to be established between multiple VPCs across different AWS regions. Set up a networking configuration that ensures that the traffic will always stay on the global AWS backbone and never traverse the public Internet.

<details> 
<summary>Explanation</summary>

AWS Transit Gateway is a service that enables customers to connect their Amazon Virtual Private Clouds (VPCs) and their on-premises networks to a single gateway. As you grow the number of workloads running on AWS, you need to be able to scale your networks across multiple accounts and Amazon VPCs to keep up with the growth.

Today, you can connect pairs of Amazon VPCs using peering. However, managing point-to-point connectivity across many Amazon VPCs without the ability to centrally manage the connectivity policies can be operationally costly and cumbersome. For on-premises connectivity, you need to attach your AWS VPN to each individual Amazon VPC. This solution can be time-consuming to build and hard to manage when the number of VPCs grows into the hundreds.

With AWS Transit Gateway, you only have to create and manage a single connection from the central gateway to each Amazon VPC, on-premises data center, or remote office across your network. Transit Gateway acts as a hub that controls how traffic is routed among all the connected networks which act like spokes. This hub and spoke model significantly simplifies management and reduces operational costs because each network only has to connect to the Transit Gateway and not to every other network. Any new VPC is simply connected to the Transit Gateway and is then automatically available to every other network that is connected to the Transit Gateway. This ease of connectivity makes it easy to scale your network as you grow.

It acts as a Regional virtual router for traffic flowing between your virtual private clouds (VPC) and VPN connections. A transit gateway scales elastically based on the volume of network traffic. Routing through a transit gateway operates at layer 3, where the packets are sent to a specific next-hop attachment, based on their destination IP addresses.

A transit gateway attachment is both a source and a destination of packets. You can attach the following resources to your transit gateway:

- One or more VPCs
- One or more VPN connections
- One or more AWS Direct Connect gateways
- One or more transit gateway peering connections

If you attach a transit gateway peering connection, the transit gateway must be in a different Region.

![https://media.tutorialsdojo.com/transit-gateway-Inter-Region-Peering.jpg](https://media.tutorialsdojo.com/transit-gateway-Inter-Region-Peering.jpg)

### ✅ **Correct Answer**

Set up an **AWS Transit Gateway in each region** to interconnect all networks within it. Then, **route traffic between Transit Gateways using a TGW peering connection**.
This meets the requirement of connecting **hundreds of VPCs**, **multiple regions**, and **on-premises networks**, all through a **single, scalable, highly available architecture**. 🟢

### ❌ **Why the Other Options Are Wrong**

#### 🔴 **Incorrect Option:**

“Set up an AWS Direct Connect Gateway with public VIFs and use LAG…”

* ❌ **Direct Connect Gateway only supports Private VIF**, not public VIF.
* ❌ **LAG** (Link Aggregation Group) is irrelevant here — it only aggregates DX connections.
* ❌ Does **not** solve the requirement of inter-region VPC-to-VPC connectivity.

#### 🔴 **Incorrect Option:**

“Enable inter-region VPC peering for all VPCs…”

* ❌ Would require **very high operational overhead** (hundreds of peering links).
* ❌ Peering is **non-transitive**, making large-scale meshing complex.
* ❌ Does **not support on-premises networks** as required.
* ⚠️ While it uses the AWS backbone, it doesn't match the scale or simplicity of Transit Gateway.

#### 🔴 **Incorrect Option:**

“Set up AWS VPN CloudHub + Direct Connect Gateway…”

* ❌ **VPN CloudHub is only for VPN-to-VPN communication**, not for VPC-to-VPC.
* ❌ Cannot manage **hundreds of VPCs** spanning multiple regions.
* ❌ Does not meet the requirement of **a unified, scalable, multi-region gateway**.

### 🎯 **Final Summary**

🟢 **Transit Gateway + inter-region TGW peering** is the only option that:

* Scales to **hundreds of VPCs**
* Supports **multi-region** connectivity
* Integrates **on-premises + cloud networks**
* Provides **high availability + simplicity** ✔️

</details>

---

## Question 2

**A company requires corporate IT governance and cost oversight of all of its AWS resources across its divisions around the world. Their corporate divisions want to maintain administrative control of the discrete AWS resources they consume and ensure that those resources are separate from other divisions.**

**Which of the following options will support the autonomy of each corporate division while enabling the corporate IT to maintain governance and cost oversight? (Select TWO.)**

* Enable IAM cross-account access for all corporate IT administrators in each child account.
* Create separate Availability Zones for each division within the corporate IT AWS account. Improve communication between the two AZs using the AWS Global Accelerator.
* Use AWS Trusted Advisor and AWS Resource Groups Tag Editor
* Use AWS Consolidated Billing by creating AWS Organizations to link the divisions’ accounts to a parent corporate account.
* Create separate VPCs for each division within the corporate IT AWS account. Launch an AWS Transit Gateway with equal-cost multipath routing (ECMP) and VPN tunnels for intra-VPC communication.

<details> 
<summary>Explanation</summary>

### 🟢 **Correct Choices**

#### ✅ **Enable IAM cross-account access for all corporate IT administrators in each child account**

* This allows centralized governance while letting each division keep its own AWS account.
* No need to create separate IAM users in each account.
* Users don’t have to sign out or switch accounts — IAM roles handle cross-account access seamlessly.
* Supports autonomy **and** centralized control. 🟢

#### ✅ **Use AWS Consolidated Billing via AWS Organizations to link all division accounts to a parent account**

* Provides a unified billing view for cost oversight.
* Each division still maintains operational independence.
* No additional cost.
* AWS + AISPL accounts cannot be mixed. 🟢

Together, IAM + AWS Organizations provide **governance + cost visibility + autonomy**. 💯

### 🔴 **Why the Other Options Are Incorrect**

#### ❌ **Using AWS Trusted Advisor + AWS Resource Groups Tag Editor**

* Trusted Advisor: Only provides recommendations and alerts.

  * ❌ Does not enforce governance.
* Tag Editor: Helps manage tags only.

  * ❌ Cannot provide centralized control or autonomy structure.

#### ❌ **Creating separate VPCs in the same AWS account + using AWS Transit Gateway**

* All VPCs would remain under one account.

  * ❌ No account-level autonomy
  * ❌ No separate billing
* Transit Gateway is for **network connectivity**, not **account governance**.

---

#### ❌ **Creating separate Availability Zones for each division + AWS Global Accelerator**

* AZs are predefined by AWS — you cannot create them.
* AZs do not provide organizational separation.
* Global Accelerator improves external user routing, not inter-AZ or inter-division communication.

### 🎯 **Final Summary**

🟢 Use **IAM cross-account access** + **AWS Organizations with Consolidated Billing**
to achieve:

* Division autonomy
* Central governance
* Cost oversight
* Simplified access management

Everything else fails to meet governance or account separation requirements. ✔️

</details>

---

## Question 3

**An AI-powered Forex trading application consumes thousands of data sets to train its machine learning model. The application's workload requires a high-performance, parallel hot storage to process the training datasets concurrently. It also needs cost-effective cold storage to archive those datasets that yield low profit.**

**Which of the following Amazon storage services should the developer use?**

* Use Amazon FSx For Lustre and the Provisioned IOPS SSD (io1) volumes of Amazon EBS for hot and cold storage respectively.
* Use Amazon FSx For Windows File Server and Amazon S3 for hot and cold storage respectively.
* Use Amazon Elastic File System and Amazon S3 for hot and cold storage respectively.
* Use Amazon FSx For Lustre and Amazon S3 for hot and cold storage respectively.

<details>
<summary>Explanation</summary>

Hot storage refers to the storage that keeps frequently accessed data (hot data). Warm storage refers to the storage that keeps less frequently accessed data (warm data). Cold storage refers to the storage that keeps rarely accessed data (cold data). In terms of pricing, the colder the data, the cheaper it is to store, and the costlier it is to access when needed.

**Amazon FSx For Lustre** is a high-performance file system for fast processing of workloads. Lustre is a popular open-source parallel file system which stores data across multiple network file servers to maximize performance and reduce bottlenecks.

**Amazon FSx for Windows File Server** is a fully managed Microsoft Windows file system with full support for the SMB protocol, Windows NTFS, and Microsoft Active Directory (AD) Integration.

**Amazon Elastic File System** is a fully-managed file storage service that makes it easy to set up and scale file storage in the Amazon Cloud. 

**Amazon S3** is an object storage service that offers industry-leading scalability, data availability, security, and performance. S3 offers different storage tiers for different use cases (frequently accessed data, infrequently accessed data, and rarely accessed data).

 The question has two requirements:

High-performance, parallel hot storage to process the training datasets concurrently.
Cost-effective cold storage to keep the archived datasets that are accessed infrequently.

### 🟢 **Correct Answer**

Use **Amazon FSx for Lustre** for hot data and **Amazon S3** for cold data storage.

* **FSx for Lustre** ➝ High-performance, parallel file system ideal for ML/AI, HPC, and frequently accessed (hot) data.
* **Amazon S3 + Glacier/Deep Archive** ➝ Cost-effective cold storage for long-term retention.
  🟢 Best fit for both performance and cost.

### 🔴 **Incorrect Options Explained**

#### ❌ **FSx for Lustre + EBS io1 for cold storage**

* **EBS io1** is a high-performance SSD meant for **hot**, I/O-intensive workloads — not cold data.
* While EBS has **Cold HDD**, it is:

  * 🔴 More expensive than S3 Glacier
  * 🔴 Not intended for large-scale archival
* Fails the cost-optimization requirement.

#### ❌ **Amazon EFS + Amazon S3**

* **EFS** supports shared access but lacks:

  * 🔴 The high throughput
  * 🔴 The parallel performance
    required by ML/HPC workloads.
* Therefore, not suitable for hot data with heavy compute requirements.

#### ❌ **FSx for Windows File Server + S3**

* **FSx for Windows File Server** does not use a **parallel file system**.
* 🔴 Not optimized for large-scale ML, simulation, or high-performance computing workloads.

### 🎯 **Final Summary**

🟢 The combination of **FSx for Lustre (hot)** + **S3/Glacier (cold)** provides the ideal balance of:

* High throughput
* Parallel performance
* Low-cost storage
* Seamless integration with S3

Perfect for ML and big-data pipelines. ✔️

</details>

---

## Question 4

**A data analytics company is setting up an innovative checkout-free grocery store. The Solutions Architect developed a real-time monitoring application that uses smart sensors to collect the items that the customers are getting from the grocery’s refrigerators and shelves, then automatically deduct those items from customer accounts. The company wants to analyze the items that are frequently being bought and store the results in Amazon S3 for durable storage to determine the purchase behavior of its customers.
Which of the following must be used to easily capture, transform, and load streaming data into S3, Amazon OpenSearch Service, and Splunk?**

* Amazon Data Firehose
* Amazon Redshift
* Amazon SQS
* Amazon DynamoDB Streams

<details>
<summary>Explanation</summary>

Amazon Data Firehose is the easiest way to load streaming data into data stores and analytics tools. It can capture, transform, and load streaming data into Amazon S3, Amazon Redshift, Amazon OpenSearch Service, and Splunk, enabling near real-time analytics with existing business intelligence tools and dashboards you are already using today.

It is a fully managed service that automatically scales to match the throughput of your data and requires no ongoing administration. It can also batch, compress, and encrypt the data before loading it, minimizing the amount of storage used at the destination and increasing security.

In the diagram below, you gather the data from your smart refrigerators and use Data Firehouse to prepare and load the data. S3 will be used as a method of durably storing the data for analytics and the eventual ingestion of data for output using analytical tools.

You can use Amazon Data Firehose in conjunction with Amazon Kinesis Data Streams if you need to implement real-time processing of streaming big data. Kinesis Data Streams provides an ordering of records, as well as the ability to read and/or replay records in the same order to multiple Amazon Kinesis Applications. The Amazon Kinesis Client Library (KCL) delivers all records for a given partition key to the same record processor, making it easier to build multiple applications reading from the same Amazon Kinesis data stream (for example, to perform counting, aggregation, and filtering).

Amazon Simple Queue Service (Amazon SQS) is different from Amazon Data Firehose. SQS offers a reliable, highly scalable hosted queue for storing messages as they travel between computers. Amazon SQS lets you easily move data between distributed application components and helps you build applications in which messages are processed independently (with message-level ack/fail semantics), such as automated workflows. Amazon Data Firehose is primarily used to load streaming data into data stores and analytics tools.

### 🟢 **Correct Answer: Amazon Data Firehose**

Amazon **Data Firehose** is the correct service because it can:

* Capture streaming data
* Transform it (via Lambda)
* Load it directly into **S3**, **Amazon OpenSearch Service**, **Splunk**, and other analytics destinations
  Perfect for real-time analytics pipelines. 🟢

### 🔴 **Why the Other Options Are Incorrect**

#### ❌ **Amazon DynamoDB Streams**

* Only captures change logs from DynamoDB tables.
* 🔴 Cannot directly transform and load data into S3 or OpenSearch.
* Useful for triggers—not for full streaming ETL pipelines.

#### ❌ **Amazon Redshift**

* A **data warehouse**, not a streaming ingestion service.
* 🔴 Cannot ingest and deliver real-time streaming data to analytics stores.
* Needs Data Firehose or other ingestion tools to get data into it.

#### ❌ **Amazon SQS**

* A **message queuing service** designed for decoupling applications.
* 🔴 Does not transform, batch, or load streaming data into S3/OpenSearch/Splunk.
* Not suitable for analytics ingestion workflows.

### 🎯 **Final Summary**

🟢 **Amazon Data Firehose** is the only option that fully supports:

* Streaming ingestion
* Transformation
* Delivery to analytics services

Making it the correct answer. ✔️

</details>

---

## Question 5

**A company plans to launch an Amazon EC2 instance in a private subnet for its internal corporate web portal. For security purposes, the EC2 instance must send data to Amazon DynamoDB and Amazon S3 via private endpoints that don’t pass through the public Internet.**

**Which of the following can meet the above requirements?**

* Use a DynamoDB VPC endpoint and an S3 VPC endpoint to route all access to these services via private endpoints.
* Enable DynamoDB Encryption at Rest with the default AWS-managed key and S3 Server-Side Encryption with the default AWS KMS key to route all traffic to DynamoDB and S3 via private endpoints.
* Use AWS Direct Connect to route all access to S3 and DynamoDB via private endpoints.
* Use AWS VPN CloudHub to route all access to S3 and DynamoDB via private endpoints.

<details>
<summary>Explanation</summary>

A VPC endpoint allows you to privately connect your VPC to supported AWS and VPC endpoint services powered by AWS PrivateLink without needing an Internet gateway, NAT computer, VPN connection, or AWS Direct Connect connection. Instances in your VPC do not require public IP addresses to communicate with resources in the service. Traffic between your VPC and the other service does not leave the Amazon network.

In the scenario, you are asked to configure private endpoints to send data to Amazon DynamoDB and Amazon S3 without accessing the public Internet. Among the options given, VPC endpoint is the most suitable service that will allow you to use private IP addresses to access both DynamoDB and S3 without any exposure to the public internet.

### 🟢 **Correct Answer**

Use a **DynamoDB VPC endpoint** and an **S3 VPC endpoint** to ensure that all access to Amazon DynamoDB and Amazon S3 happens **privately within the AWS network**—without traversing the public Internet.
This fulfills the requirement of routing all traffic through **private endpoints**. 🟢

### 🔴 **Incorrect Options Explained**

#### ❌ **Enable DynamoDB Encryption at Rest + S3 SSE**

* Encryption at rest protects stored data.
* 🔴 It does **not** control or influence how network traffic is routed.
* Traffic can still flow over public endpoints even if data is encrypted.

#### ❌ **Use AWS Direct Connect**

* Direct Connect provides a **dedicated connection from on-premises to AWS**.
* The scenario does **not** mention on-premises or hybrid architecture.
* 🔴 Not required for private service-to-service access **inside** AWS.

#### ❌ **Use AWS VPN CloudHub**

* CloudHub is used to connect **multiple remote sites together** using VPNs.
* 🔴 Not used for creating private access paths to S3 or DynamoDB.
* 🔴 Does not create VPC endpoints.

### 🎯 **Final Summary**

🟢 Using **VPC Endpoints (Gateway endpoints)** for **S3** and **DynamoDB** is the correct and intended way to:

* Keep traffic private
* Avoid public Internet paths
* Strongly secure communication between VPC resources and AWS services

✔️ Best solution for secure, private connectivity.

</details>

---

## Question 6

**A financial services company plans to migrate its trading application from on-premises Microsoft Windows Server to Amazon Web Services (AWS). The solution must ensure high availability across multiple Availability Zones and offer low-latency access to block storage.**

**Which of the following solutions will fulfill these requirements?**

* Configure the trading application on Amazon EC2 Windows Server instances across two Availability Zones. Use Amazon FSx for NetApp ONTAP to create a Multi-AZ file system and access the data via iSCSI protocol.
* Deploy the trading application on Amazon EC2 Windows Server instances across two Availability Zones. Use Amazon FSx for Windows File Server for shared storage.
* Deploy the trading application on Amazon EC2 Windows Server instances across two Availability Zones. Use Amazon Elastic File System (Amazon EFS) to provide shared storage between the instances. Configure Amazon EFS with cross-region replication to sync data across Availability Zones.
* Configure the trading application on Amazon EC2 Windows instances across two Availability Zones. Use Amazon Simple Storage Service (Amazon S3) for storage and configure cross-region replication to sync data between S3 buckets in each Availability Zone.

<details>
<summary>Explanation</summary>

**Option 1 vs Option 2**

**Short answer — choose Option 1 (FSx for NetApp ONTAP + iSCSI).**

**Why:** the requirement is *high availability across AZs* **and** *low-latency block storage*.

* **FSx for NetApp ONTAP** can present **iSCSI LUNs (block devices)** to EC2 instances and you can design the file system in a Multi-AZ configuration for HA — that gives you true block-level access (low latency, suitable for applications that expect block devices). ([AWS Documentation][1])
* **FSx for Windows File Server** is a highly available **SMB (file-level)** service and supports Multi-AZ deployments, but it does **not** provide iSCSI (block) volumes. SMB is excellent for Windows file-share use cases, user profiles, and many apps, but it’s not the same as exposing block storage via iSCSI when your app requires block semantics and the lowest possible latency. ([AWS Documentation][2])

**Practical notes / caveats**

* If the trading app explicitly requires Windows SMB file shares (and is designed to use SMB with clustering/features Windows supports), FSx for Windows File Server could be acceptable — but for *low-latency block storage* (databases, low-latency trading engines, or apps that need raw disks / cluster disks), FSx ONTAP + iSCSI is the correct fit. ([AWS Documentation][3])
* Test the exact latency/IOPS profile in a pilot and validate your Windows clustering or application lock semantics over iSCSI before production cutover.

**Amazon FSx for NetApp ONTAP**

Amazon FSx for NetApp ONTAP is a fully managed AWS service that provides high-performance, scalable file storage based on NetApp’s ONTAP file system. It offers versatile storage options, supporting both file (NFS, SMB) and block (iSCSI) protocols, making it compatible with Windows, Linux, and macOS environments.

The Amazon FSx for NetApp ONTAP features Multi-AZ file systems designed to ensure continuous availability across AWS Availability Zones, providing high availability for your Windows Server workloads. It offers consistent sub-millisecond file operation latencies with SSD storage, essential for block storage workloads in Windows environments. FSx for NetApp ONTAP fully supports block storage protocols like iSCSI, commonly used in Windows Server settings, and it works seamlessly with the SMB protocol, ensuring compatibility with Windows Server and related applications.

Moreover, FSx for NetApp ONTAP simplifies migrating from on-premises NetApp systems to AWS for users currently utilizing NetApp storage. It can scale to accommodate petabyte-scale datasets, making it suitable for large Windows Server environments.

### 🟢 **Correct Answer**

Configure the trading application on **Amazon EC2 Windows Server instances** across **two Availability Zones**, and use **Amazon FSx for NetApp ONTAP** with a **Multi-AZ deployment**.
Access the storage using the **iSCSI protocol**, which provides the **shared block storage** and **low latency** required for a trading workload. 🟢

### 🔴 **Incorrect Options Explained**

#### ❌ **FSx for Windows File Server**

* Provides **shared file storage**, not shared block storage.
* Does **not** support low-latency iSCSI block access needed for high-performance trading apps.

#### ❌ **Amazon EFS with cross-region replication**

* EFS is NFS-based and best suited for **Linux workloads**.
* Not optimized for Windows.
* Does **not** provide block-level access.
* Cross-region replication does not help with **AZ-level block storage performance**.

#### ❌ **Amazon S3 with cross-region replication**

* S3 is **object storage**, not block storage.
* Cannot provide the low-latency, high-throughput transactional performance required.
* Not suitable for Windows-based trading application storage.

### 🎯 **Final Summary**

🟢 **FSx for NetApp ONTAP (Multi-AZ)** + **iSCSI** is the only option that:

* Provides **shared block storage**
* Supports **Windows workloads**
* Offers **low latency** for trading systems
* Ensures **high availability across AZs**

✔️ The ideal fit for this scenario.

</details>

---

## Question 7

**A leading e-commerce company is in need of a storage solution that can be simultaneously accessed by 1000 Linux servers in multiple availability zones. The servers are hosted in EC2 instances that use a hierarchical directory structure via the NFSv4 protocol. The service should be able to handle the rapidly changing data at scale while still maintaining high performance. It should also be highly durable and highly available whenever the servers will pull data from it, with little need for management.
As the Solutions Architect, which of the following services is the most cost-effective choice that you should use to meet the above requirement?**

* Amazon EFS
* Amazon S3
* Amazon FSx for Windows File Server
* Amazon EBS

<details>
<summary>Explanation</summary>

**Note: NFSv4 is primarily a Linux/Unix protocol, not Windows.**

Amazon Web Services (AWS) offers cloud storage services to support a wide range of storage workloads such as EFS, S3, and EBS. You have to understand when you should use Amazon EFS, Amazon S3, and Amazon Elastic Block Store (EBS) based on the specific workloads. In this scenario, the keywords are rapidly changing data and 1000 Linux servers.

Amazon EFS is a file storage service for use with Amazon EC2. Amazon EFS provides a file system interface, file system access semantics (such as strong consistency and file locking), and concurrently-accessible storage for up to thousands of Amazon EC2 instances. EFS provides the same level of high availability and high scalability like S3 however, this service is more suitable for scenarios where it is required to have a POSIX-compatible file system or if you are storing rapidly changing data.

Data that must be updated very frequently might be better served by storage solutions that take into account read and write latencies, such as Amazon EBS volumes, Amazon RDS, Amazon DynamoDB, Amazon EFS, or relational databases running on Amazon EC2.

Amazon EBS is a block-level storage service for use with Amazon EC2. Amazon EBS can deliver performance for workloads that require the lowest-latency access to data from a single EC2 instance.

Amazon S3 is an object storage service. Amazon S3 makes data available through an Internet API that can be accessed anywhere.

### 🟢 **Correct Answer: Amazon EFS**

Amazon **Elastic File System (EFS)** is the correct choice because it offers:

* **Concurrent access** for thousands of Linux EC2 instances
* **Strong consistency**
* **File locking**
* **High availability and durability**
* **Elastic capacity** for rapidly changing data

Perfect match for **1000 Linux servers** requiring shared, scalable storage. 🟢

### 🔴 **Why the Other Options Are Incorrect**

#### ❌ **Amazon S3**

* Although highly durable and scalable, it is **object storage**, not a file system.
* 🔴 Does **not** support file locking or POSIX semantics.
* 🔴 Not suitable for rapidly changing, shared datasets.

#### ❌ **Amazon EBS**

* EBS volumes can only attach to **one EC2 instance at a time** (except Multi-Attach, limited to specific use cases).
* 🔴 Cannot be shared across 1000 EC2 instances.
* Not a distributed file system.

#### ❌ **Amazon FSx for Windows File Server**

* Supports shared file storage but only for **Windows workloads**.
* 🔴 The scenario specifically uses **Linux** EC2 instances.
* Not compatible.

### 🎯 **Final Summary**

🟢 **Amazon EFS** is the only solution that supports:

* Thousands of Linux servers
* Shared, concurrently-accessible file storage
* Strong consistency + file locking
* Automatic scaling + high availability

✔️ The best and only valid fit for this scenario.

</details>

---

## Question 8

**A Solutions Architect is migrating several Windows-based applications to AWS that require a scalable file system storage for high-performance computing (HPC). The storage service must have full support for the SMB protocol and Windows NTFS, Active Directory (AD) integration, and Distributed File System (DFS).**

**Which of the following is the MOST suitable storage service that the Architect should use to fulfill this scenario?**

* Amazon FSx for Windows File Server
* Amazon S3 Glacier Deep Archive
* Amazon FSx for Lustre
* AWS DataSync

<details>
<summary>Explanation</summary>

Amazon FSx provides fully managed third-party file systems. Amazon FSx provides you with the native compatibility of third-party file systems with feature sets for workloads such as Windows-based storage, high-performance computing (HPC), machine learning, and electronic design automation (EDA). You don’t have to worry about managing file servers and storage, as Amazon FSx automates time-consuming administration tasks such as hardware provisioning, software configuration, patching, and backups. Amazon FSx integrates the file systems with cloud-native AWS services, making them even more useful for a broader set of workloads.

Amazon FSx provides you with two file systems to choose from: Amazon FSx for Windows File Server for Windows-based applications and Amazon FSx for Lustre for compute-intensive workloads.

For Windows-based applications, Amazon FSx provides fully managed Windows file servers with features and performance optimized for “lift-and-shift” business-critical application workloads including home directories (user shares), media workflows, and ERP applications. It is accessible from Windows and Linux instances via the SMB protocol. If you have Linux-based applications, Amazon EFS is a cloud-native fully managed file system that provides simple, scalable, elastic file storage accessible from Linux instances via the NFS protocol.

For compute-intensive and fast processing workloads, like high-performance computing (HPC), machine learning, EDA, and media processing, Amazon FSx for Lustre, provides a file system that’s optimized for performance, with input and output stored on Amazon S3.

### 🟢 **Correct Answer: Amazon FSx for Windows File Server**

Amazon **FSx for Windows File Server** is the correct choice because it:

* Provides fully managed, highly available **Windows-native file storage**
* Supports **SMB protocol**, Windows ACLs, and Active Directory integration
* Is optimized for **Windows-based applications** and workloads
  Perfect for environments that require Windows file system features. 🟢

### 🔴 **Why the Other Options Are Incorrect**

#### ❌ **Amazon S3 Glacier Deep Archive**

* Designed for **long-term archival** and infrequently accessed data
* 🔴 Not suitable for active file shares or Windows applications
* Retrieval times are slow (hours)

#### ❌ **AWS DataSync**

* Simply a **data transfer** service
* 🔴 Does not provide storage
* Used for moving data into services like S3 or EFS—not for hosting Windows file shares

#### ❌ **Amazon FSx for Lustre**

* High-performance file system for **Linux-based HPC and ML workloads**
* 🔴 Not compatible with Windows file system requirements
* Lacks Windows-native SMB and AD integration

### 🎯 **Final Summary**

🟢 **Amazon FSx for Windows File Server** is the only storage service tailored specifically for:

* Windows workloads
* SMB file sharing
* Windows permissions + Active Directory

✔️ The correct and most suitable answer.

</details>

---

## Question 9

**A company has developed public APIs hosted in Amazon EC2 instances behind an Elastic Load Balancer. The APIs will be used by various clients from their respective on-premises data centers. A Solutions Architect received a report that the web service clients can only access trusted IP addresses whitelisted on their firewalls.**

**What should you do to accomplish the above requirement?**

* Create a CloudFront distribution whose origin points to the private IP addresses of your web servers.
* Associate an Elastic IP address to a Network Load Balancer.
* Associate an Elastic IP address to an Application Load Balancer.
* Create an Alias Record in Route 53 which maps to the DNS name of the load balancer.

<details>
<summary>Explanation</summary>

A Network Load Balancer functions at the fourth layer of the Open Systems Interconnection (OSI) model. It can handle millions of requests per second. After the load balancer receives a connection request, it selects a target from the default rule’s target group. It attempts to open a TCP connection to the selected target on the port specified in the listener configuration.

Based on the given scenario, web service clients can only access trusted IP addresses. To resolve this requirement, you can use the Bring Your Own IP (BYOIP) feature to use the trusted IPs as Elastic IP addresses (EIP) to a Network Load Balancer (NLB). This way, there’s no need to re-establish the whitelists with new IP addresses.

### 🟢 **Correct Answer: Associate an Elastic IP address to a Network Load Balancer**

A **Network Load Balancer (NLB)** can have **Elastic IP addresses** assigned, allowing clients to whitelist the fixed IPs on their firewalls.
This fully meets the requirement of providing **static, trusted IP addresses** for inbound access. 🟢

### 🔴 **Incorrect Options Explained**

#### ❌ **Associate an Elastic IP to an Application Load Balancer**

* ALBs **do not support** Elastic IP assignment.
* To expose static IPs, you must place an **NLB in front of the ALB** if needed.

#### ❌ **Create a CloudFront distribution pointing to private IPs**

* CloudFront distributions use **dynamic IP ranges**, not fixed ones.
* 🔴 Cannot guarantee a trusted, firewall-whitelisted IP.
* Not suitable when clients require **specific IPs only**.

#### ❌ **Create a Route 53 Alias to the load balancer**

* This only provides a DNS name, not a fixed IP.
* 🔴 Clients still cannot whitelist the load balancer’s dynamic IPs.
* Does not solve the firewall trust requirement.

### 🎯 **Final Summary**

🟢 Assigning an **Elastic IP address to a Network Load Balancer** is the fastest and only reliable way to provide **static, trusted IP addresses** for client firewalls.

✔️ This is the correct solution.

</details>

---

## Question 10

**A solutions architect is designing an infrastructure for a serverless application. The application is packaged as a Docker image stored in Amazon Elastic Container Registry (Amazon ECR) and must be deployed on a fully managed serverless compute service. Additionally, the application requires 5 GB of ephemeral storage for temporary data processing.**

**Which deployment option meets these requirements?**

* Deploy the application to an Amazon ECS cluster that uses AWS Fargate tasks.
* Deploy the application Amazon ECS cluster with Amazon EC2 worker nodes and attach a 5 GB Amazon EBS volume.
* Deploy the application in an AWS Lambda function with Container image support. Set the function's storage to 5 GB.
* Deploy the application in an AWS Lambda function with Container image support. Attach an Amazon Elastic File System (Amazon EFS) volume to the function.

<details>
<summary>Explanation</summary>

AWS Lambda with Container Image Support is a fully managed, serverless compute service that allows you to run your applications without provisioning or managing servers. Traditionally, AWS Lambda functions were deployed using code written in supported programming languages, but with container image support, you can now package and deploy your application as a Docker container. This provides more flexibility, as it allows you to use custom runtimes or include dependencies that are difficult to manage in a traditional Lambda function deployment. Lambda functions with container images can be up to 10 GB in size, enabling you to deploy large, complex applications with ease.

One of the key features of AWS Lambda is the ability to allocate ephemeral storage for each function instance. By default, Lambda functions come with 512 MB of temporary storage, but you can configure up to 10 GB of storage. This ephemeral storage is used for temporary data processing and is wiped clean after the execution of the function. This makes it a great choice for applications that need to perform tasks like data processing, file manipulation, or caching during their execution, without needing persistent storage.

Lambda with container image support provides a fully managed environment that automatically scales based on the workload. You are only billed for the compute time your code actually uses, and there are no charges for idle time, making it a cost-effective solution for many workloads. It abstracts away infrastructure management, ensuring that developers can focus on building applications without worrying about scaling, patching, or maintaining servers.

### 🟢 **Correct Answer: Deploy the application in an AWS Lambda function with Container Image support and set the function’s storage to 5 GB**

AWS Lambda now supports **up to 10 GB of ephemeral storage**, which is ideal when an application requires temporary, non-persistent working space during execution.
Since the requirement is fully **serverless** and needs **only ephemeral storage**, Lambda with **container image support** is the perfect fit. 🟢

### 🔴 **Incorrect Options Explained**

#### ❌ **ECS on Fargate**

* Fargate is serverless for compute, but:

  * You must still manage **ECS services, task definitions, and cluster-level configuration**.
* More suited to long-running containerized workloads needing custom networking or scheduling.
* 🔴 Not the simplest or most appropriate solution for a Lambda-friendly workload.

#### ❌ **Lambda with EFS attached**

* EFS = **persistent storage**, suitable for shared data across invocations.
* The requirement specifies **ephemeral storage only**.
* 🔴 Attaching EFS adds unnecessary complexity and cost.
* Lambda's built-in ephemeral storage is simpler and a better match.

#### ❌ **ECS with EC2 worker nodes + EBS**

* Requires provisioning and managing **EC2 instances**, violating the serverless requirement.
* Scaling, patching, and capacity planning would burden operations.
* 🔴 Not compliant with the architectural constraints.

### 🎯 **Final Summary**

🟢 **AWS Lambda with container image support + 5 GB ephemeral storage**
is the only option that fully satisfies:

* Serverless architecture
* Containerized application requirements
* Temporary (not persistent) storage needs
* Minimal operational overhead

✔️ Best and correct answer.

</details>
