# DynamoDB

## **Question 1**

**A company currently has an Augmented Reality (AR) mobile game that has a serverless backend. It is using a DynamoDB table which was launched using the AWS CLI to store all the user data and information gathered from the players and a Lambda function to pull the data from DynamoDB. The game is being used by millions of users each day to read and store data.**

How would you design the application to improve its overall performance and make it more scalable while keeping the costs low? (Select TWO)

**Options:**

* Configure CloudFront with DynamoDB as the origin; cache frequently accessed data on the client device using ElastiCache.
* Use API Gateway in conjunction with Lambda and turn on the caching on frequently accessed data and enable DynamoDB global replication.
* Use AWS IAM Identity Center to authenticate users and have them directly access DynamoDB using single sign-on. Manually set the provisioned read and write capacity to a higher RCU and WCU.
* Enable DynamoDB Accelerator (DAX) and ensure that Auto Scaling is enabled and increase the maximum provisioned read and write capacity.
* Since Auto Scaling is enabled by default, the provisioned read and write capacity will adjust automatically. Also enable DynamoDB Accelerator (DAX) to improve the performance from milliseconds to microseconds.

<details>

<summary><strong>Answer & Explanation</strong> 📝</summary>

🟢 **Amazon DynamoDB Accelerator (DAX)** is a **fully managed**, **highly available**, **in-memory cache** for DynamoDB that delivers up to a **10x performance improvement** – from **milliseconds to microseconds** – even at **millions of requests per second**.
DAX does all the heavy lifting required to add **in-memory acceleration** to your DynamoDB tables, without requiring developers to manage **cache invalidation**, **data population**, or **cluster management.**

🟢 **Amazon API Gateway** lets you create an **API** that acts as a **"front door"** for applications to access **data**, **business logic**, or **functionality** from your back-end services, such as code running on **AWS Lambda**.

Amazon API Gateway handles all the tasks involved in accepting and processing up to **hundreds of thousands of concurrent API calls**, including:

* **Traffic management**
* **Authorization and access control**
* **Monitoring**
* **API version management**

📌 **Amazon API Gateway** has **no minimum fees** or **startup costs.**

🟢 **AWS Lambda** scales your functions **automatically** on your behalf.
Every time an **event notification** is received for your function, **AWS Lambda** quickly locates **free capacity** within its compute fleet and runs your code.

Since your code is **stateless**, AWS Lambda can start as many copies of your function as needed **without lengthy deployment or configuration delays.**

✅ **The correct answers are the options that say:**

🟢 – **Enable DynamoDB Accelerator (DAX)** and ensure that **Auto Scaling** is enabled and increase the **maximum provisioned read and write capacity.**

🟢 – **Use API Gateway** in conjunction with **Lambda** and turn on the **caching on frequently accessed data**, and **enable DynamoDB global replication.**

<img src="https://media.tutorialsdojo.com/ddb_as_set_read_1.png"
     alt="DynamoDB Auto Scaling and DAX diagram"
     width="600" />

🔴 **The option that says:**
*Configure CloudFront with DynamoDB as the origin; cache frequently accessed data on the client device using ElastiCache*
is **incorrect** ❌ because although **CloudFront** delivers content faster to users using **edge locations**, you **cannot integrate DynamoDB with CloudFront** as these two are **incompatible.**

🔴 **The option that says:**
*Use AWS IAM Identity Center to authenticate users and have them directly access DynamoDB using single sign-on. Manually set the provisioned read and write capacity to a higher RCU and WCU*
is **incorrect** ❌ because **AWS IAM Identity Center** only helps to **centrally manage access** to multiple AWS accounts and apps — it does **not** improve **scalability or performance**.

Moreover, **manually setting high RCU/WCU** is **costly**, as this capacity runs **continuously**, even when traffic is low or stable.

🔴 **The option that says:**
*Since Auto Scaling is enabled by default, the provisioned read and write capacity will adjust automatically. Also enable DynamoDB Accelerator (DAX) to improve the performance from milliseconds to microseconds*
is **incorrect** ❌ because **Auto Scaling is not enabled by default** in a **DynamoDB table** created using the **AWS CLI**.

</details>

---
