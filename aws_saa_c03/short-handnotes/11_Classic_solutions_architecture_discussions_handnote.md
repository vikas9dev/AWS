# Classic Solutions Architecture - Handnote 📝

## 🏗️ SOLUTION ARCHITECTURE CONCEPTS

### Goal
- **Integrate technologies**: Understand how services work together
- **Iterative approach**: Build from simple to complex
- **Exam focus**: Critical area for SAA exam

### Key Services Integration
- EC2, ELB, ASG, EBS, EFS, RDS, Elastic Beanstalk

---

## ⏰ WHATISTHETIME.COM - ARCHITECTURE EVOLUTION

### Stage 1: Simple Setup
- **Single T2.micro** EC2 instance
- **Elastic IP**: Consistent IP address
- **Use Case**: Proof of Concept (PoC)

### Stage 2: Vertical Scaling
- **Upgrade**: T2.micro → M5.large
- **Downtime**: Stop → Change type → Start
- **Elastic IP**: Maintains same public IP
- ⚠️ **Problem**: Downtime during scaling

### Stage 3: Horizontal Scaling (Attempt 1)
- **Multiple M5.large** instances
- **Multiple Elastic IPs**: One per instance
- ⚠️ **Problem**: Unmanageable, limit of 5 Elastic IPs
- ⚠️ **Problem**: Users need to know all IPs

### Stage 4: Horizontal Scaling with Route 53
- **Remove Elastic IPs**: From EC2 instances
- **Route 53 A record**: Points to instance IPs
- **TTL**: 1 hour
- ⚠️ **Problem**: Up to 1 hour downtime when removing instance

### Stage 5: Load Balancer
- **Private EC2 instances**: No public IPs
- **Public ELB**: Distributes traffic
- **Health checks**: Only healthy instances receive traffic
- **Security Groups**: Restrict EC2 to ELB only
- **Route 53 Alias**: Points to ELB
- ✅ **Benefit**: No downtime during updates

### Stage 6: Auto Scaling Group
- **ASG manages instances**: Automatic scaling
- **Single AZ**: Initially
- ✅ **Benefit**: Automatic instance management

### Stage 7: Multi-AZ Deployment
- **ELB**: Spans multiple AZs
- **ASG**: Launches instances across AZs
- ✅ **Benefit**: High availability, resilience

### Stage 8: Cost Optimization
- **Reserved Instances**: For minimum capacity
- **On-Demand/Spot**: For additional capacity
- ✅ **Benefit**: Significant cost savings

---

## 🛒 MYCLOTHES.COM - STATEFUL APPLICATION

### Problem: Lost Shopping Carts
- **Architecture**: Route 53 → Multi-AZ ELB → ASG (3 AZs)
- **Issue**: User adds item, next request goes to different instance
- **Result**: Shopping cart lost

### Solution 1: ELB Stickiness (Session Affinity)
- **Sticky sessions**: User always routed to same instance
- ⚠️ **Problem**: Cart lost if instance terminated
- **Use Case**: Temporary solution

### Solution 2: User Cookies
- **Store cart in browser**: Cookie-based
- ✅ **Stateless**: EC2 instances don't store state
- ⚠️ **Limitations**:
  - Heavy HTTP requests (large cart)
  - Security risks (cookies can be altered)
  - Size limit (<4KB)

### Solution 3: Server Sessions with ElastiCache
- **Session ID in cookie**: Small identifier
- **Cart in ElastiCache**: Retrieved by session ID
- ✅ **Benefits**:
  - Sub-millisecond performance
  - Secure (ElastiCache is source of truth)
  - No size limitations
- **Alternative**: DynamoDB for sessions

### Storing User Data
- **RDS**: User accounts, orders, product catalog
- **ElastiCache**: Shopping cart sessions
- **Architecture**: Stateless web tier + stateful data tier

---

## 📝 MYWORDPRESS.COM - SCALABLE WORDPRESS

### Requirements
- **WordPress**: Content management system
- **Scalability**: Handle traffic spikes
- **Shared storage**: Multiple instances need same files

### Architecture Components

#### Web Tier
- **EC2 instances**: Run WordPress
- **Auto Scaling Group**: Scale based on demand
- **Load Balancer**: Distribute traffic

#### Storage Tier
- **EFS**: Shared file system for WordPress files
- **RDS**: MySQL database for WordPress data
- ✅ **Benefit**: All instances access same files

#### Key Points
- **EFS**: Mounted on all EC2 instances
- **RDS**: Centralized database
- **Stateless instances**: Can scale horizontally
- **Shared storage**: EFS provides consistency

---

## 🚀 ELASTIC BEANSTALK

### What is Elastic Beanstalk?
- **Platform as a Service (PaaS)**: Deploy applications quickly
- **Managed service**: Handles infrastructure
- **Supports**: Java, .NET, PHP, Node.js, Python, Ruby, Go, Docker

### Benefits
- ✅ **Quick deployment**: Minutes instead of hours
- ✅ **Infrastructure management**: AWS handles it
- ✅ **Scaling**: Automatic
- ✅ **Monitoring**: Built-in CloudWatch integration
- ✅ **Updates**: Zero-downtime deployments

### Components
- **Application**: Collection of environments
- **Environment**: Running version of application
- **Application Version**: Deployable code
- **Environment Configuration**: Settings for environment

### Service Role vs Instance Profile
- **Service Role**: For Elastic Beanstalk service (manages resources)
- **Instance Profile**: For EC2 instances (application permissions)
- **Both needed**: Different purposes

---

## ⚠️ CRITICAL EXAM POINTS

1. **Elastic IP**: Limit of 5, prefer DNS/Load Balancer
2. **Route 53 TTL**: High TTL = longer downtime during changes
3. **Load Balancer**: Eliminates downtime, health checks
4. **Auto Scaling**: Automatic instance management
5. **Multi-AZ**: High availability, resilience
6. **Stickiness**: Temporary solution, not ideal for HA
7. **ElastiCache**: Best for session storage (sub-ms performance)
8. **EFS**: Shared storage for multiple instances
9. **Stateless design**: Enables horizontal scaling
10. **Elastic Beanstalk**: PaaS, quick deployment, managed infrastructure

---

## 📋 QUICK REFERENCE

### Architecture Patterns
- **Stateless web tier**: Use ElastiCache/DynamoDB for sessions
- **Shared storage**: EFS for files, RDS for database
- **High availability**: Multi-AZ deployment
- **Cost optimization**: Reserved Instances for baseline

### Scaling Strategies
- **Vertical**: Upgrade instance type (downtime)
- **Horizontal**: Add more instances (no downtime with ELB)
- **Auto Scaling**: Automatic based on metrics

### State Management
- **Stickiness**: Route to same instance (not HA)
- **Cookies**: Store in browser (size limit, security)
- **ElastiCache**: Best for sessions (recommended)
- **DynamoDB**: Alternative for sessions

---

*Last Updated: Based on AWS SAA-C03 Exam Guide*

