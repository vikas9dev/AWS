# AWS Containers (ECS, EKS, Fargate) - Handnote 📝

## 🐳 AWS ECS (Elastic Container Service)

### What is ECS?
- **Container orchestration** service
- **Run Docker containers** on AWS
- **Fully managed** service
- **No infrastructure** to manage

### ECS Components
- **Clusters**: Group of EC2 instances or Fargate
- **Task Definitions**: Blueprint for containers
- **Tasks**: Running instances of task definitions
- **Services**: Maintain desired number of tasks
- **Container Instances**: EC2 instances running containers

---

## ⚙️ ECS LAUNCH TYPES

### EC2 Launch Type
- **Launch containers** on EC2 instances you manage
- **Full control** over instances
- **Responsible for** scaling, patching, security
- ✅ **Use case**: Need instance-level control

### Fargate Launch Type
- **Serverless** container platform
- **No EC2 instances** to manage
- **Pay per task** (CPU & memory)
- ✅ **Use case**: Simple, serverless containers

### External Launch Type
- **Run containers** on on-premises servers
- **ECS Anywhere**
- ✅ **Use case**: Hybrid deployments

---

## 📋 ECS TASK DEFINITIONS

### Components
- **Container definitions**: Image, CPU, memory, ports
- **Task role**: IAM role for tasks
- **Task execution role**: IAM role for ECS agent
- **Network mode**: Bridge, host, awsvpc, none
- **Volumes**: EFS, EBS, bind mounts

### Task Sizing
- **CPU**: 256 CPU units = 0.25 vCPU
- **Memory**: Specified in MB
- **Fargate**: CPU & memory combinations (see AWS docs)

---

## 🔄 ECS SERVICES

### Purpose
- **Maintain desired** number of tasks
- **Automatic replacement** of failed tasks
- **Load balancing** integration
- **Auto Scaling** support

### Service Types
- **Replica**: Maintain desired count
- **Daemon**: One task per instance

### Service Features
- ✅ **Health checks**: Container & load balancer
- ✅ **Deployment configurations**: Rolling, blue/green
- ✅ **Service discovery**: Automatic DNS registration

---

## 🔗 ECS INTEGRATIONS

### Application Load Balancer
- **Target type**: IP (for awsvpc network mode)
- **Target type**: Instance (for bridge/host mode)
- ✅ **Dynamic port mapping**

### CloudWatch
- **Container logs** → CloudWatch Logs
- **Metrics** → CloudWatch Metrics
- ✅ **Automatic** integration

### Auto Scaling
- **Target tracking**: Based on CPU/memory
- **Step scaling**: Based on CloudWatch alarms
- ✅ **Automatic scaling** of tasks

---

## 🚀 AWS FARGATE

### What is Fargate?
- **Serverless compute engine** for containers that eliminates the need to manage EC2 instances
- **Pay only for resources** you use, with automatic scaling and no infrastructure management

### Features
- ✅ **Serverless** containers
- ✅ **No EC2** instances to manage
- ✅ **Automatic scaling**
- ✅ **Pay per task**

### Pricing
- **vCPU**: $0.04048 per vCPU-hour
- **Memory**: $0.004445 per GB-hour
- **Free tier**: None

### Use Cases
- ✅ **Simple container** workloads
- ✅ **No infrastructure** management needed
- ✅ **Cost-effective** for variable workloads

---

## ☸️ AWS EKS (Elastic Kubernetes Service)

### What is EKS?
- **Managed Kubernetes** service
- **Kubernetes control plane** managed by AWS
- **Run Kubernetes** applications on AWS

### EKS Components
- **EKS Cluster**: Managed Kubernetes control plane
- **Worker Nodes**: EC2 instances or Fargate
- **Node Groups**: Groups of worker nodes
- **Pods**: Smallest deployable units

### EKS Features
- ✅ **Kubernetes API** server
- ✅ **etcd** database (managed)
- ✅ **Integration** with AWS services
- ✅ **IAM** integration

---

## 🔐 EKS SECURITY

### IAM Integration
- **IAM roles** for service accounts (IRSA)
- **Pod identity** via IAM roles
- ✅ **Fine-grained** permissions

### Network Security
- **Security Groups**: Control pod-to-pod traffic
- **Network Policies**: Kubernetes network policies
- **VPC**: Pods run in VPC

---

## 🐳 AMAZON ECR (Elastic Container Registry)

### What is ECR?
- **Docker container registry**
- **Store & manage** container images
- **Private** registry

### Features
- ✅ **Image scanning**: Vulnerability scanning
- ✅ **Lifecycle policies**: Auto-delete old images
- ✅ **Image replication**: Cross-region replication
- ✅ **Encryption**: At rest & in transit

### Pricing
- **Storage**: $0.10 per GB/month
- **Data transfer**: Standard AWS data transfer pricing

---

## ⚠️ CRITICAL EXAM POINTS

1. **ECS**: Fully managed container orchestration
2. **Fargate**: Serverless containers (no EC2 management)
3. **EC2 Launch Type**: Full control, manage instances yourself
4. **Task Definition**: Blueprint for containers
5. **ECS Service**: Maintains desired task count
6. **ALB Integration**: Dynamic port mapping for containers
7. **EKS**: Managed Kubernetes service
8. **ECR**: Private Docker container registry
9. **Fargate pricing**: Pay per vCPU-hour & GB-hour
10. **Service discovery**: Automatic DNS registration

---

## 📋 QUICK REFERENCE

### Choosing Launch Type
- **Fargate**: Simple, serverless, no infrastructure
- **EC2**: Need instance control, cost optimization
- **EKS**: Kubernetes workloads, multi-cloud

### ECS vs EKS
- **ECS**: AWS-native, simpler
- **EKS**: Kubernetes, portable, complex

---

*Last Updated: Based on AWS SAA-C03 Exam Guide*

