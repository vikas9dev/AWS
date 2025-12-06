# SQS

## Question 1

**A software company has resources hosted in AWS and on-premises servers. You have been requested to create a decoupled architecture for applications which make use of both resources.
Which of the following options are valid? (Select TWO.)**

* Use VPC peering to connect both on-premises servers and EC2 instances for your decoupled application
* Use DynamoDB to utilize both on-premises servers and EC2 instances for your decoupled application
* Use SWF to utilize both on-premises servers and EC2 instances for your decoupled application
* Use SQS to utilize both on-premises servers and EC2 instances for your decoupled application
* Use RDS to utilize both on-premises servers and EC2 instances for your decoupled application

<details>
  <summary>Explanation</summary>

### 🟢 **Correct Services for a Decoupled Architecture**

In AWS, the primary services used to build a **decoupled architecture**—where system components operate independently but still communicate—are:

1. **Amazon SQS (Simple Queue Service)**

   * Provides **highly scalable, reliable message queues**.
   * Allows asynchronous communication between distributed components.
   * Ideal for buffering, load leveling, and decoupling microservices.

2. **Amazon SWF (Simple Workflow Service)**

   * Coordinates **workflows** across distributed systems.
   * Ensures tasks are assigned, tracked, and executed reliably.
   * Suitable for applications with complex state tracking or long-running workflows.

Both services help ensure components can work independently without waiting on each other, which is the foundation of decoupled design.

---

### 🔴 **Incorrect Options**

#### ❌ **Using Amazon RDS**

* RDS is a **database service**, not a messaging or workflow coordination tool.
* It cannot be used to create a decoupled, event-driven architecture between on-prem and AWS.

#### ❌ **Using Amazon DynamoDB**

* DynamoDB is a **NoSQL database service**.
* It is not meant for message buffering or asynchronous task orchestration.

#### ❌ **Using VPC Peering for On-Premises Connectivity**

* **VPC Peering** only works between **AWS VPCs**.
* You cannot peer a VPC directly with an **on-premises network**.
* For hybrid connectivity, AWS requires **Direct Connect** or **Site-to-Site VPN**, but these still do not provide decoupled messaging.

---

### 🧠 **Summary**

To achieve true decoupling between your on-premises servers and EC2 instances, only **Amazon SQS** and **Amazon SWF** are valid choices. They allow independent components to communicate reliably and handle distributed workloads without tight coupling.

</details>

---

## Question 2

**A company launched a website that accepts high-quality photos and turns the photos into a downloadable video montage. The website offers both a free and a premium account, with the premium account guaranteeing faster processing. All requests by both free and premium members go through a single Amazon SQS queue and are then processed by a group of Amazon EC2 instances that generate the videos. The company needs to ensure that premium users, who paid for the service, have higher priority than free members.
How should the company re-design its architecture to address this requirement?**

* Create an SQS queue for free members and another one for premium members. Configure your EC2 instances to consume messages from the premium queue first and if it is empty, poll from the free members' SQS queue.
* Use Amazon S3 to store and process the photos and then generate the video montage afterward.
* For the requests made by premium members, set a higher priority in the SQS queue so it will be processed first compared to the requests made by free members.
* Use Amazon Kinesis to process the photos and generate the video montage in real-time.

<details>
  <summary>Explanation</summary>

### 🟢 **Why Amazon SQS Is the Right Service**

Amazon **SQS** is a fully managed, highly scalable message queuing service designed to **decouple distributed systems** and ensure **reliable communication** between components.
It guarantees message durability, supports massive throughput, and allows workers (e.g., EC2 instances) to process messages **asynchronously** and **independently**.

In this scenario, the system must prioritize **premium members** before **free members**. SQS itself **does not support per-message priority**, so the solution must be implemented through **queue design**, not message attributes.

### 🟢 **Correct Solution**

**Create two separate SQS queues:**

* One queue for **premium members**
* One queue for **free members**

Then configure EC2 instances to:

1. **Always poll the premium queue first**.
2. Only if the premium queue is empty, **poll the free members’ queue**.

This ensures the required **priority-based message processing** without losing messages or overcomplicating the workflow.

**Hence, the correct answer is:**
**Create an SQS queue for free members and another for premium members. Configure the EC2 instances to consume messages from the premium queue first and when it is empty, process messages from the free members’ queue.**

![https://media.tutorialsdojo.com/OrderDispatcher-1024x534.png](https://media.tutorialsdojo.com/OrderDispatcher-1024x534.png)

### 🔴 **Incorrect Options**

#### ❌ **“Set a higher priority in the SQS queue for premium members”**

* SQS **does not support message priority** within a single queue.
* Priority must be handled by **separate queues** or application logic.

#### ❌ **“Use Amazon Kinesis to process the photos and generate the video montage in real time”**

* Kinesis is for **real-time streaming data** (logs, telemetry, clickstreams).
* Not applicable to this batch-style photo/video processing scenario.

#### ❌ **“Use Amazon S3 to store and process the photos and then generate the montage”**

* Amazon S3 is **storage only**—it does not process data.
* It cannot replace a queuing and processing workflow.

### 🧠 **Summary**

Using two separate SQS queues provides a clean, scalable way to enforce **processing priority**, ensuring premium users’ requests are always handled before free members—while keeping the architecture simple and reliable.

</details>

---

