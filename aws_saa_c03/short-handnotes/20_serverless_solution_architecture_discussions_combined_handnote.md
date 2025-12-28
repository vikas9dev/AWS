# Serverless Solution Architecture - Handnote 📝

## 📱 MYTODOLIST - MOBILE APPLICATION

### Requirements
- **REST API**: HTTPS endpoints
- **Serverless**: No server management
- **User access**: Direct S3 folder access
- **Authentication**: Managed serverless service
- **Database**: High read throughput

### Architecture

#### API Layer
- **API Gateway**: REST HTTPS endpoints
- **Lambda**: Serverless compute
- **DynamoDB**: Serverless NoSQL database

#### Authentication
- **Cognito**: User authentication
- **Temporary credentials**: For S3 access
- ✅ **Security**: Never store AWS credentials on mobile

#### S3 Access Pattern
1. Mobile client authenticates with Cognito
2. Cognito generates temporary credentials
3. Credentials returned to mobile client
4. Client uses credentials for S3 access

### Optimization: High Read Throughput
- **DAX**: DynamoDB Accelerator (caching layer)
- **API Gateway caching**: For static responses
- **Architecture**: Mobile → API Gateway → Lambda → DAX → DynamoDB

---

## 📝 MYBLOG.COM - SERVERLESS WEBSITE

### Requirements
- **Global scale**: Serve worldwide
- **Read-heavy**: Infrequent blog posts
- **Static + Dynamic**: Mostly static, small REST API
- **Cost optimization**: Caching
- **Welcome emails**: New subscriber notifications
- **Thumbnail generation**: Serverless image processing

### Architecture Components

#### Static Content Delivery
- **S3**: Store static files (HTML, CSS, images)
- **CloudFront**: Global CDN, cache at edge
- **Origin Access Control (OAC)**: Secure S3 access
- **Bucket Policy**: Only allow CloudFront access

#### Dynamic REST API
- **API Gateway**: REST HTTPS endpoint
- **Lambda**: Serverless compute
- **DynamoDB**: NoSQL database
- **DAX**: Optional caching layer
- **Global Tables**: Reduce latency globally

#### Welcome Email Flow
1. **DynamoDB Streams**: Trigger on new user
2. **Lambda**: Process stream event
3. **SES**: Send welcome email
4. **IAM Role**: Lambda permissions for SES

#### Thumbnail Generation
1. **S3 Upload**: Client uploads image
2. **S3 Event**: Triggers Lambda
3. **Lambda**: Generates thumbnail
4. **S3 Storage**: Store thumbnail in separate bucket
- **Alternative**: S3 → SQS/SNS → Lambda

---

## 🔄 MICROSERVICES ARCHITECTURE

### Concept
- **Multiple services**: Each with unique architecture
- **REST APIs**: Services communicate via APIs
- **Independent**: Each service can scale independently

### Benefits
- ✅ **Lean development**: Separate lifecycle per service
- ✅ **Independent scaling**: Scale each service separately
- ✅ **Separate repos**: Dedicated code repository per service

### Example Setup
- **Service 1**: Route 53 → ELB → ECS → DynamoDB
- **Service 2**: Different architecture
- **DNS**: Each service has own DNS name (e.g., `service1.example.com`)

---

## 📦 SOFTWARE UPDATES OFFLOADING

### Use Case
- **Mobile apps**: Need to download updates
- **Large files**: Updates can be GBs
- **Global users**: Worldwide distribution

### Architecture
- **S3**: Store update files
- **CloudFront**: Distribute globally
- **Benefits**:
  - ✅ Low latency (edge locations)
  - ✅ High bandwidth
  - ✅ Cost-effective
  - ✅ Offload from application servers

---

## ⚠️ CRITICAL EXAM POINTS

1. **API Gateway**: REST HTTPS endpoints, serverless
2. **Lambda**: Serverless compute, scales automatically
3. **DynamoDB**: Serverless NoSQL, high throughput
4. **Cognito**: Authentication, generates temporary credentials
5. **S3 + CloudFront**: Static content delivery globally
6. **OAC**: Secure S3 access via CloudFront
7. **DynamoDB Streams**: Event-driven workflows
8. **S3 Events**: Trigger Lambda on upload
9. **DAX**: DynamoDB caching layer
10. **Global Tables**: Reduce latency globally
11. **Microservices**: Independent services, REST APIs
12. **CloudFront**: Offload software updates

---

## 📋 QUICK REFERENCE

### Serverless API Pattern
```
Client → API Gateway → Lambda → DynamoDB
```

### Static Website Pattern
```
Client → CloudFront → S3
```

### Event-Driven Pattern
```
DynamoDB Streams → Lambda → SES
S3 Event → Lambda → Process
```

### Caching Strategy
- **DAX**: DynamoDB reads (sub-ms)
- **API Gateway**: Static API responses
- **CloudFront**: Static content globally

### Authentication Pattern
```
Mobile → Cognito → Temporary Credentials → S3/DynamoDB
```

---

*Last Updated: Based on AWS SAA-C03 Exam Guide*

