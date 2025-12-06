# Serverless Solution Architecture Discussions

Sections:-
- [1. Serverless Architectures: MyTodoList Mobile Application](#1-serverless-architectures-mytodolist-mobile-application)
- [2. MyBlog.com: A Serverless Hosted Website](#2-myblogcom-a-serverless-hosted-website)
- [3. Microservices Architecture](#3-microservices-architecture)
- [4. Software Updates Offloading](#4-software-updates-offloading)
- [5. Q & A](#5-q--a)

---

## 1. Serverless Architectures: MyTodoList Mobile Application

Let's explore serverless architectures by building a mobile application called MyTodoList.

Our goal is to meet the following requirements:

*   Expose a REST API with HTTPS endpoints.
*   Utilize a serverless architecture.
*   Allow users to interact directly with their own folder in S3 for data management.
*   Enable user authentication through a managed serverless service.
*   Support users reading and writing to-dos, with a focus on optimizing read performance.
*   Ensure the database layer scales and provides high read throughput.

Here's how we can achieve this:

![MyTodoList Architecture](/doc/img/MyTodoListArchitecture.png)

1.  **API Gateway:** 🚀 We'll start with mobile clients and the need for a REST HTTPS interface. Amazon API Gateway is an excellent choice for this.

2.  **Lambda:** ⚙️ In classic serverless API fashion, API Gateway will invoke an Amazon Lambda function, allowing us to scale and leverage serverless infrastructure.

3.  **DynamoDB:** 🗄️ Amazon Lambda needs a database to store and retrieve to-dos. DynamoDB is a serverless database that scales well, making it ideal for our backend.

4.  **Cognito:** 🔑 We need an authentication layer. Amazon Cognito provides a serverless solution. Mobile clients can connect and authenticate to Cognito, and API Gateway will verify authentication with Cognito.

This setup creates a classic serverless API.

### Accessing Amazon S3

![MyTodoList S3 Access](/doc/img/MyTodoListS3Access.png)

To grant users access to their own Amazon S3 bucket:

1.  Mobile clients authenticate with Amazon Cognito.
2.  Cognito generates temporary credentials.
3.  These credentials are returned to the mobile clients.
4.  Mobile clients use these credentials to store and retrieve files in their designated S3 space.

⚠️ **Warning:** Never store AWS user credentials directly on mobile clients. Always use Amazon Cognito to generate temporary credentials.

It is a **common question** asked when working with serverless architectures.

### Scaling and Optimizing Read Throughput

As our app scales and we observe high read throughput (many RCUs) with infrequent to-do edits, we can optimize the architecture:

1.  **DAX (DynamoDB Accelerator):** ⚡️ Introduce DAX as a caching layer in front of DynamoDB. This caches frequently read data.

    ```
    Mobile Client -> API Gateway -> Lambda -> DAX -> DynamoDB
    ```

    By caching reads in DAX, we reduce the read capacity units needed on DynamoDB, potentially improving performance and reducing costs.

2.  **API Gateway Caching:** 🌐 Consider caching responses at the Amazon API Gateway level. This is effective if the API responses are relatively static.

![MyTodoList Caching Architecture](/doc/img/MyTodoListCachingArchitecture.png)

### Key Takeaways

*   We've seen a classic serverless REST API architecture using HTTPS, API Gateway, Lambda, and DynamoDB.
*   Cognito can generate temporary credentials for secure access to S3 buckets with restricted policies. This pattern can be extended for accessing DynamoDB or Lambda directly.
*   Caching reads on DynamoDB with DAX is easy to enable and can improve performance and reduce costs.
*   Caching REST requests at the API Gateway level is suitable for static responses.
*   Security is managed through Cognito, which integrates directly with API Gateway.

💡 **Tip:** Serverless architectures allow you to pay per usage and avoid managing databases, as AWS handles these tasks.

📝 **Note:** This example provides a foundation for building serverless architectures and highlights the importance of caching for performance optimization.

---

## 2. MyBlog.com: A Serverless Hosted Website

Let's explore how to build a serverless hosted website, `MyBlog.com`, with global scalability. The key is to leverage serverless technologies to handle varying workloads efficiently.

### Requirements

*   🌐 Scale globally.
*   ✍️ Infrequent blog posts (read-heavy).
*   📁 Primarily static files with a small dynamic REST API component.
*   💰 Cost and latency optimization through caching.
*   📧 Warm welcome email for new subscribers.
*   🖼️ Serverless thumbnail generation for uploaded photos.

### Architecture

![MyBlog Architecture - User Welcome Email Flow](/doc/img/MyBlogArchitecture-UserWelcomeEmailFlow.png)

Here's a breakdown of the architecture to meet these requirements:

#### 1. Serving Static Content Globally

*   Store static content in **Amazon S3**.
*   Use **Amazon CloudFront** as a global CDN to cache and distribute content from S3 to clients worldwide.

    💡 **Tip:** CloudFront caches data at edge locations, reducing latency and improving user experience.

#### 2. Securing the S3 Bucket

*   Implement **Origin Access Control (OAC)** on CloudFront.
*   Configure a bucket policy on the S3 bucket to only allow access from the CloudFront distribution.

    This prevents direct access to the S3 bucket, enhancing security.

#### 3. Public Serverless REST API

*   Use **Amazon API Gateway** to create a REST HTTPS endpoint.
*   API Gateway invokes an **AWS Lambda** function.
*   Lambda function interacts with **Amazon DynamoDB** for data storage.
*   Consider **DAX (DynamoDB Accelerator)** as a caching layer for read-heavy workloads.
*   For global reach, leverage **DynamoDB Global Tables** to reduce latency in different regions.

#### 4. User Welcome Email Flow

*   Enable **DynamoDB Streams** on the user table.
*   A DynamoDB stream triggers an **AWS Lambda** function when a new user subscribes.
*   The Lambda function uses an **IAM role** with permissions to access **Amazon SES (Simple Email Service)**.
*   Lambda uses the AWS SDK to send a welcome email via SES.

    📝 **Note:** Amazon SES is a cost-effective email sending service.

![MyBlog Architecture - Thumbnail Generation](/doc/img/MyBlogArchitecture-ThumbnailGeneration.png)

#### 5. Thumbnail Generation

*   Clients upload images to an **S3 bucket**, either directly or via **CloudFront with S3 Transfer Acceleration**.
*   Adding a file to S3 triggers an **AWS Lambda** function.
*   The Lambda function generates a thumbnail and stores it in another S3 bucket.

    📌 **Example:**
    ```
    S3 Upload -> Lambda Trigger -> Thumbnail Generation -> S3 Storage
    ```

*   Alternatively, S3 can trigger **SQS (Simple Queue Service)** or **SNS (Simple Notification Service)** for more complex workflows.

    📝 **Note:** S3 event notifications offer flexibility in designing event-driven architectures.

### Technologies Used

*   **Amazon S3:** Storage for static content and images.
*   **Amazon CloudFront:** Global CDN for content distribution and caching.
*   **Amazon API Gateway:** Serverless API endpoint.
*   **AWS Lambda:** Serverless compute for API logic, email sending, and thumbnail generation.
*   **Amazon DynamoDB:** NoSQL database for user data and blog content.
*   **DAX (DynamoDB Accelerator):** In-memory cache for DynamoDB.
*   **Amazon SES (Simple Email Service):** Email sending service.
*   **SQS (Simple Queue Service):** Message queuing service.
*   **SNS (Simple Notification Service):** Pub/Sub messaging service.

### Key Takeaways

*   This architecture is fully serverless and scales globally.
*   CloudFront and S3 are used for efficient static content delivery.
*   API Gateway and Lambda provide a serverless REST API.
*   DynamoDB Streams and Lambda enable event-driven workflows like sending welcome emails.
*   S3 triggers allow for automated image processing.

This comprehensive approach demonstrates how to build a scalable and cost-effective serverless website using various AWS services.

---

## 3. Microservices Architecture

Let's discuss microservices, an interesting alternative to serverless architectures.

We aim to transition to a microservice architecture where multiple services interact, often using REST APIs.

Each microservice can have a unique architecture, offering flexibility in design and implementation.

The benefits of using a microservice architecture include:

*   Leaner development lifecycle for each service. 🚀
*   Independent scalability of each service. 📈
*   Dedicated code repository for each service. 🗄️

Let's consider an example setup:

*   Users interact with the first microservice over HTTPS.
*   An Elastic Load Balancer distributes traffic to ECS, which interacts with DynamoDB.
*   This setup is just one possible choice.

📝 **Note:** ECS is used for running Docker containers on AWS.

![Microservices Architecture - Example](/doc/img/MicroservicesArchitecture-Example.png)

The first microservice might have a DNS name like `service1.example.com`. A DNS query to Route 53 retrieves an alias record, enabling interaction with the service.

Now, let's introduce a second microservice:

*   This service uses a serverless architecture.
*   Instead of DynamoDB, it uses ElastiCache.
*   This is just to illustrate different possibilities. ElastiCache can be a backend for Lambda.

The second microservice (`service2`) might interact with the first microservice. A Lambda function calls the Elastic Load Balancer of the first service to retrieve information needed for its response.

Finally, consider a third microservice:

*   It uses an ELB with Amazon EC2 Auto Scaling and an Amazon RDS database (a more traditional architecture).
*   The EC2 instance needs to call the second microservice before making a decision.
*   The URL for this service is `service3.example.com`.

The key takeaway is the freedom to design each microservice according to specific needs.

There are two main patterns for microservice communication:

1.  **Synchronous Pattern:**

    *   Involves explicit calls to other microservices.
    *   API Gateway and Load Balancers are commonly used for HTTPS calls.
2.  **Asynchronous Pattern:**

    *   Uses services like SQS, Kinesis, SNS, Lambda triggers, or S3.
    *   A message is placed in a queue (e.g., SQS) without expecting an immediate response.
    *   Other services react to the message.

Challenges associated with microservices include:

*   Overhead in creating new microservices. 🚧
*   Potential issues in optimizing server density and utilization. 📉
*   Complexity in managing multiple versions of each microservice. 😵‍💫
*   Proliferation of client-side code for integrating with many separate services. 💻

Many of these challenges can be mitigated by using serverless patterns. API Gateway and Lambda scale automatically, and you pay only for usage. API cloning and environment reproduction are simplified in API Gateway. Client SDKs can be generated through Swagger integration for the API Gateway.

Ultimately, microservices represent a design choice. They solve certain problems but also introduce new ones.

Microservices offer a flexible approach to building complex applications, but careful planning and consideration of the associated challenges are essential.

---

## 4. Software Updates Offloading

We're going to explore a solution for offloading software updates in an application running on EC2.

The problem: An application running on EC2 distributes software updates. When a new update is released, many computers request the patch, which is hosted on the EC2 instances. This mass distribution over the network is costly. The goal is to optimize cost and CPU utilization without re-architecting the application.

Let's examine the current application state:

*   A classic ELB + ASG setup.
*   Application running in multi-AZ.
*   M5 instances distribute the software updates.
*   Software updates are stored in Amazon EFS.

The solution: 💡 **Tip:** Introduce CloudFront to cache the software update files at the edge.

![Software Updates Offloading - Solution](/doc/img/SoftwareUpdatesOffloading-Solution.png)

Why CloudFront?

*   No changes to the existing architecture are required.
*   CloudFront caches static software update files at the edge.
*   CloudFront is serverless and scales automatically.
*   This reduces the need for the ASG to scale, leading to significant savings in:
    *   EC2 costs
    *   Network costs
    *   EFS costs
*   Improved availability.

In essence, CloudFront acts as a caching layer for static content, reducing the load on the origin servers (EC2 instances).

📌 **Example:**

1.  A user requests a software update.
2.  CloudFront checks its cache for the requested file.
3.  If the file is in the cache (cache hit), CloudFront serves it directly to the user.
4.  If the file is not in the cache (cache miss), CloudFront retrieves it from the origin (EFS via EC2), serves it to the user, and caches it for future requests.

CloudFront is an easy way to make an existing application more scalable and cheaper if it serves mostly static content by using caching at the edges. Sometimes the best solutions are the easiest ones.

---

## 5. Q & A

### ❓ Question 5

You have configured a **Lambda function** to run each time an item is added to a **DynamoDB table** using **DynamoDB Streams**.

The function is meant to insert messages into an **SQS queue** for further processing.

Each time the Lambda function runs, it is able to **read from DynamoDB Streams**, but it **fails to insert messages into the SQS queue**.

**What is the problem?**

* Lambda can’t be used to insert messages into the SQS queue, use an EC2 instance instead
* The Lambda Execution IAM Role is missing permissions
* The Lambda security group must allow outbound access to SQS
* The SQS security group must be edited to allow AWS Lambda

<details>

<summary>Explanation</summary>

In AWS, a Lambda function executes with the permissions defined in its **IAM Execution Role**.

* The role needs explicit permissions to access AWS resources.
* In this case, the Lambda has permission to read DynamoDB Streams but **lacks `sqs:SendMessage` permission** to push data to the SQS queue.

📌 **Correct fix:**
Attach an IAM policy to the Lambda execution role with permissions like:

```json
{
  "Effect": "Allow",
  "Action": "sqs:SendMessage",
  "Resource": "arn:aws:sqs:region:account-id:queue-name"
}
```

⚠️ **Why not the other options?**

* **EC2 instead of Lambda** → Incorrect. Lambda is perfectly capable of sending messages to SQS.
* **Lambda security group outbound** → Not relevant. SQS is a managed AWS service accessible over the internet and doesn't rely on Lambda's SG outbound rules.
* **SQS security group changes** → SQS doesn't use security groups. Security groups apply to EC2/EFS/RDS, not managed services like SQS.

✅ Answer: **The Lambda Execution IAM Role is missing permissions**

✅ **Takeaway:** Always ensure your Lambda execution role has the **least-privilege IAM permissions** required to interact with resources like SQS, DynamoDB, or SNS.

</details>

---