# AWS S3 Complete Guide - Handnote 📝
*(Combined from S3 Intro, Advanced & Security)*

## 🪣 S3 BASICS

### Buckets & Objects
- **Bucket**: Top-level directory (globally unique name)
- **Object**: Files stored in buckets
- **Key**: Full path to file (e.g., `my-folder/file.txt`)
- **Prefix**: Folder path (e.g., `my-folder/`)
- **Object Name**: File name (e.g., `file.txt`)

### Bucket Naming
- ✅ **Globally unique** across all AWS accounts & regions
- ✅ **Region-specific** (buckets exist in specific regions)
- ✅ **3-63 characters**, lowercase, numbers, hyphens only
- ❌ No uppercase, underscores, IP addresses

### Object Properties
- **Max size**: **5 TB** per object
- **>5 GB**: Must use **multi-part upload**
- **Metadata**: Key-value pairs
- **Tags**: Up to 10 Unicode key-value pairs
- **Version ID**: Present if versioning enabled

---

## 🔒 S3 SECURITY

### Security Methods
1. **IAM Policies**: User-based permissions
2. **Bucket Policies**: Bucket-wide rules (most common) ✅
3. **Object ACLs**: Fine-grained (can be disabled)
4. **Bucket ACLs**: Less common (can be disabled)

### Bucket Policy Structure
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::bucket-name/*"
  }]
}
```

### Block Public Access
- ⚠️ **Overrides bucket policies** - even if policy allows public, Block Public Access will prevent it
- ✅ Enable if bucket should never be public

---

## 🔐 S3 ENCRYPTION

### Server-Side Encryption (SSE)

#### SSE-S3 (Default)
- ✅ **Enabled by default** for new buckets (since Jan 5, 2023)
- ✅ AWS-managed keys (AES-256)
- ✅ Header: `x-amz-server-side-encryption: AES256`
- ✅ **FREE**

#### SSE-KMS
- ✅ Customer-managed keys via KMS
- ✅ **Audit key usage** via CloudTrail
- ✅ Header: `x-amz-server-side-encryption: aws:kms`
- ⚠️ **KMS API quotas** (5500-30000 req/s) - may throttle
- ✅ **Bucket Key** reduces KMS API calls (enabled by default)
- 💰 **Cost**: KMS key charges apply

#### SSE-C
- ✅ Customer-provided keys (managed outside AWS)
- ✅ **Must use HTTPS**
- ✅ Key passed in headers for each request
- ⚠️ **Only via CLI/SDK** (not console)

### Client-Side Encryption
- ✅ Encrypt before uploading to S3
- ✅ Decrypt after downloading
- ✅ Client manages keys entirely

### Encryption in Transit
- ✅ **HTTPS** recommended (encrypted)
- ✅ **HTTP** not encrypted
- ✅ **Force HTTPS** with bucket policy:
```json
{
  "Effect": "Deny",
  "Condition": {
    "Bool": {"aws:SecureTransport": "false"}
  }
}
```

### Default Encryption vs Bucket Policies
- **Default Encryption**: Auto-encrypts new objects
- **Bucket Policy**: Can **enforce** specific encryption (evaluated first)

---

## 🌐 STATIC WEBSITE HOSTING

### Requirements
1. S3 bucket
2. Files (HTML, images, etc.)
3. Enable static website hosting
4. **Public read access** (bucket policy)

### Website URLs
- `s3-website-region.amazonaws.com` OR
- `s3-website.region.amazonaws.com`

---

## 📦 VERSIONING

### Features
- ✅ **Best practice** - enable on all buckets
- ✅ Protects against unintended deletes
- ✅ Allows rollback to previous versions
- ✅ **Delete marker** added when object "deleted" (not permanent)
- ✅ Files uploaded before versioning have `null` version ID

### Important Notes
- ⚠️ **Suspending versioning does NOT delete versions**
- ⚠️ **Permanent delete** (by version ID) is NOT replicated
- ⚠️ Only **delete markers** are replicated

---

## 🔄 S3 REPLICATION

### Types
- **CRR (Cross-Region Replication)**: Different regions
- **SRR (Same-Region Replication)**: Same region

### Requirements
- ✅ **Versioning must be enabled** on both buckets
- ✅ IAM permissions for S3 service
- ✅ Can be different AWS accounts

### Important Notes
- ⚠️ Only **new objects** replicated after enabling
- ⚠️ Use **S3 Batch Replication** for existing objects
- ⚠️ **Delete markers** can be replicated (optional)
- ⚠️ **Permanent deletes** (by version ID) are NOT replicated
- ⚠️ **No chaining**: A→B→C does NOT mean A→C

---

## 💾 S3 STORAGE CLASSES

### Durability vs Availability
- **Durability**: **99.999999999% (11 nines)** - same for all classes
- **Availability**: Varies by storage class

### Storage Classes

| Class | Availability | Use Case | Min Duration |
|-------|-------------|----------|--------------|
| **S3 Standard** | 99.99% | Frequently accessed | - |
| **S3 Standard-IA** | 99.9% | Infrequent access | - |
| **S3 One Zone-IA** | 99.5% | Secondary backups | - |
| **S3 Glacier Instant Retrieval** | - | Archive, ms retrieval | 90 days |
| **S3 Glacier Flexible Retrieval** | - | Archive, flexible | 90 days |
| **S3 Glacier Deep Archive** | - | Long-term archive | 180 days |
| **S3 Intelligent-Tiering** | 99.99% | Auto-optimization | - |

### Glacier Retrieval Options
- **Expedited**: 1-5 minutes ($$$)
- **Standard**: 3-5 hours (Flexible) / 12 hours (Deep Archive)
- **Bulk**: 5-12 hours (Flexible) / 48 hours (Deep Archive) - FREE

### S3 Intelligent-Tiering Tiers
- **Frequent Access** (default)
- **Infrequent Access** (30 days)
- **Archive Instant Access** (90 days)
- **Archive Access** (90-700+ days, optional)
- **Deep Archive Access** (180-700+ days, optional)

---

## 🔄 LIFECYCLE RULES

### Purpose
- **Automate** object transitions between storage classes
- **Delete** objects after specified time

### Rule Actions
1. **Transition Actions**: Move objects between storage classes
2. **Expiration Actions**: Delete objects after time period

### Rule Scope
- Entire buckets
- Specific prefixes (e.g., `mp3/*`)
- Specific object tags

### Lifecycle Rule Examples
- **Current versions**: Transition to Standard-IA after 30 days, Glacier after 90 days
- **Non-current versions**: Move to Glacier after 90 days
- **Expire current versions**: Delete after 700 days
- **Delete non-current versions**: Permanently delete after 700 days
- **Incomplete multipart uploads**: Delete after 7 days

### S3 Analytics
- ✅ Provides **recommendations** for transition times
- ✅ Works with **Standard** and **Standard-IA** only
- ✅ Generates **CSV report** (updated daily)
- ✅ Takes **24-48 hours** to start seeing data

---

## 📨 S3 EVENT NOTIFICATIONS

### Event Types
- **ObjectCreated**: Put, Copy, Post
- **ObjectRemoved**: Delete
- **ObjectRestored**: Restore from Glacier
- **Replication**: Replication events
- **Lifecycle**: Lifecycle transitions

### Destinations
- **SNS Topic**
- **SQS Queue**
- **Lambda Function**
- **EventBridge** (all events sent here automatically)

### IAM Permissions
- ✅ **Resource policies** on destination (SNS, SQS, Lambda)
- ✅ S3 needs permission to send to destination

### EventBridge Integration
- ✅ **All S3 events** sent to EventBridge automatically
- ✅ **Advanced filtering** (metadata, size, name)
- ✅ **Multiple destinations** simultaneously
- ✅ **Event archiving & replay**

---

## ⚡ S3 PERFORMANCE

### Baseline Performance
- **Latency**: 100-200ms for first byte
- **Request Limits** (per prefix):
  - **3,500 PUT/COPY/POST/DELETE** per second
  - **5,500 GET/HEAD** per second
- ✅ **No limit** on number of prefixes

### Performance Optimization

#### Multi-Part Upload
- ✅ **Recommended** for files >100 MB
- ✅ **Required** for files >5 GB
- ✅ Uploads parts in **parallel**
- ✅ Faster transfers

#### S3 Transfer Acceleration
- ✅ **50-500% faster** transfers
- ✅ Uses **CloudFront edge locations**
- ✅ **$0.04-$0.08/GB** additional cost
- ✅ Compatible with multi-part upload

#### S3 Byte Range Fetches
- ✅ **Parallel GET requests** for byte ranges
- ✅ Faster downloads
- ✅ Better resilience (retry failed ranges)
- ✅ Retrieve only portion of file (e.g., headers)

---

## 🔧 S3 BATCH OPERATIONS

### Purpose
- **Bulk operations** on existing objects
- **Single request** to process many objects

### Use Cases
- Modify object metadata/properties
- Copy objects between buckets
- Encrypt unencrypted objects
- Modify ACLs or tags
- Restore objects from Glacier
- Invoke Lambda for custom actions

### How It Works
1. **S3 Inventory** → List of objects
2. **Athena** → Query and filter list
3. **S3 Batch Operations** → Process filtered list

### Benefits
- ✅ **Retry management**
- ✅ **Progress tracking**
- ✅ **Completion notifications**
- ✅ **Report generation**

---

## 📊 S3 STORAGE LENS

### Purpose
- **Analyze & optimize** storage across AWS Organization
- **30-day metrics** (free) or **15 months** (advanced)

### Aggregation Levels
- Organization
- Accounts
- Regions
- Buckets
- Prefixes

### Metrics
- **Summary**: Storage bytes, object counts
- **Cost Optimization**: Non-current versions, incomplete uploads
- **Data Protection**: Versioning, MFA delete enabled
- **Access Management**: Object ownership
- **Event Metrics**: Event notifications configured
- **Performance**: Transfer Acceleration enabled
- **Activity**: Requests (GET, PUT), bytes downloaded
- **HTTP Status Codes**: 200 OK, 403 Forbidden, etc.

### Free vs Advanced
- **Free**: ~28 metrics, 14-day retention
- **Advanced**: Activity metrics, 15-month retention, CloudWatch publishing, prefix aggregation

---

## 🌐 CORS (Cross-Origin Resource Sharing)

### Purpose
- Allow **cross-origin requests** from web browsers
- **Origin** = Scheme + Host + Port

### CORS Configuration
```json
[{
  "AllowedHeaders": ["Authorization"],
  "AllowedMethods": ["GET", "PUT"],
  "AllowedOrigins": ["https://www.example.com"],
  "ExposeHeaders": [],
  "MaxAgeSeconds": 3000
}]
```

### Use Cases
- Web app on one domain accessing S3 bucket on another
- Static website hosting with cross-origin assets

---

## 🔐 MFA DELETE

### Purpose
- **Extra protection** against accidental/malicious deletions
- Requires **MFA code** for:
  - Permanently deleting object versions
  - Suspending versioning

### Requirements
- ✅ **Versioning must be enabled**
- ✅ **Only root account** can enable/disable
- ⚠️ **CLI only** (not available in console)

### Commands
```bash
# Enable MFA Delete
aws s3api put-bucket-versioning \
  --bucket my-bucket \
  --versioning-configuration Status=Enabled,MFADelete=Enabled \
  --mfa "arn:aws:iam::ACCOUNT:mfa/root-account-mfa-device MFA-CODE"
```

---

## 📝 S3 ACCESS LOGS

### Purpose
- **Audit all access attempts** to S3 buckets
- Logs **authorized & denied** requests

### Requirements
- ✅ **Target bucket** must be in **same region**
- ⚠️ **Never use same bucket** as logging target (creates loop!)

### Log Format
- Specific format (see AWS docs)
- Analyze with **Athena**

---

## 🔗 S3 PRE-SIGNED URLs

### Purpose
- **Temporary access** to private objects
- **Inherits permissions** of URL generator

### Expiration
- **Console**: Up to 12 hours (1 min - 12 hours)
- **CLI**: Up to 7 days (default 3600 seconds)

### Use Cases
- Allow logged-in users to download premium content
- Temporary upload access to specific location
- Share private files temporarily

### CLI Example
```bash
aws s3 presign s3://my-bucket/my-object --expires-in 3600
```

---

## 🔒 S3 OBJECT LOCK

### Purpose
- **WORM (Write Once Read Many)** model
- **Prevent overwrites/deletions** for compliance

### Requirements
- ✅ **Versioning must be enabled**
- ✅ Applied at **object level** (not bucket level)

### Retention Modes

#### Compliance Mode
- ⚠️ **Strictest** - no one can override (not even root)
- ⚠️ Retention period **cannot be shortened**
- ✅ For **regulatory compliance**

#### Governance Mode
- ✅ **More flexible** - admins with `s3:BypassGovernanceRetention` can override
- ✅ For **internal governance**

### Legal Hold
- ✅ **Indefinite protection** (independent of retention)
- ✅ Can be **placed/removed** by users with `s3:PutObjectLegalHold`
- ✅ For **legal proceedings**

### Glacier Vault Lock
- ✅ **WORM model** for Glacier vaults
- ✅ **Vault Lock Policy** - cannot be changed once locked
- ✅ **Compliance & legal** requirements

---

## 🎯 S3 ACCESS POINTS

### Purpose
- **Simplify security management** for large buckets
- **Dedicated access points** for specific data subsets

### How It Works
1. Create **access point** (e.g., "finance", "sales")
2. Define **access point policy** (grants access to specific prefixes)
3. Users access via **access point DNS name**

### Benefits
- ✅ Simplified bucket policies
- ✅ Scalable access management
- ✅ **VPC origin** support (private access via VPC endpoint)

### VPC Access Points
- ✅ **Private access** through VPC endpoint
- ✅ **No internet** required
- ✅ **Three security layers**: VPC endpoint policy, access point policy, bucket policy

---

## ⚙️ S3 OBJECT LAMBDA

### Purpose
- **Transform objects** on-the-fly via Lambda
- **No need to duplicate** buckets for different versions

### How It Works
1. Create **S3 Access Point**
2. Connect to **Lambda function**
3. Create **S3 Object Lambda Access Point**
4. Application accesses via Object Lambda access point
5. Lambda retrieves, transforms, returns object

### Use Cases
- **Redact PII** for analytics
- **Convert formats** (XML to JSON)
- **Watermark images** (user-specific)
- **Enrich data** (add customer loyalty info)

---

## 💰 S3 REQUESTER PAYS

### Purpose
- **Requester pays** for data download costs
- **Bucket owner** pays for storage

### Requirements
- ✅ **Requester must be authenticated** (AWS account)
- ✅ Useful for **sharing large datasets**

---

## ⚠️ CRITICAL EXAM POINTS

1. **Bucket names are globally unique** (only thing in AWS)
2. **Buckets are region-specific** (not global service)
3. **Versioning is best practice** - protects against deletes
4. **Replication requires versioning** on both buckets
5. **Only new objects replicated** after enabling (use Batch for existing)
6. **Delete markers replicated** (optional), **permanent deletes NOT**
7. **No replication chaining** - A→B→C doesn't mean A→C
8. **SSE-S3 is default** (enabled automatically for new buckets)
9. **SSE-KMS** - KMS API quotas may throttle high-throughput
10. **SSE-C** - Must use HTTPS, CLI/SDK only
11. **CORS** - Required for cross-origin browser requests
12. **MFA Delete** - Root account only, CLI only
13. **Object Lock** - Requires versioning, Compliance mode strictest
14. **Access Logs** - Same region, never use same bucket
15. **Pre-signed URLs** - Inherit generator's permissions
16. **Multi-part upload** - Required for >5 GB, recommended for >100 MB
17. **Byte Range Fetches** - Parallel GET requests for performance
18. **Storage Lens** - Free (14 days) vs Advanced (15 months)

---

## 📋 QUICK REFERENCE

### Making Bucket Public
1. Disable Block Public Access
2. Create bucket policy allowing `s3:GetObject` for `*`

### Enabling Versioning
1. Go to Properties → Bucket Versioning
2. Enable versioning
3. ⚠️ Cannot be disabled (only suspended)

### Setting Up Replication
1. Enable versioning on source & destination
2. Create replication rule
3. Configure IAM role
4. Choose replication options

### Static Website Hosting
1. Enable in Properties
2. Set index document
3. Configure bucket policy for public read
4. Upload files

### Lifecycle Rules
1. Go to Management → Lifecycle rules
2. Define transitions & expiration
3. Apply to all objects, prefix, or tags

### Encryption Enforcement
- **Default Encryption**: Auto-encrypts (SSE-S3 default)
- **Bucket Policy**: Enforces specific encryption type

---

*Last Updated: Based on AWS SAA-C03 Exam Guide*

