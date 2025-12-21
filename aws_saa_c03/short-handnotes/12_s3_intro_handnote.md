# AWS S3 Introduction - Handnote 📝

## 🪣 S3 BASICS

### Buckets & Objects
- **Bucket**: Top-level directory (like a folder)
- **Object**: Files stored in buckets
- **Key**: Full path to file (e.g., `my-folder/file.txt`)
- **Prefix**: Folder path (e.g., `my-folder/`)
- **Object Name**: File name (e.g., `file.txt`)

### Bucket Naming
- ✅ **Globally unique** across all AWS accounts & regions
- ✅ **Region-specific** (buckets exist in specific regions)
- ✅ **3-63 characters**
- ✅ **Lowercase letters, numbers, hyphens only**
- ❌ No uppercase, no underscores
- ❌ Cannot be IP address
- ❌ Cannot start with `xn--`
- ❌ Cannot end with `-s3alias`

### Object Properties
- **Max size**: **5 TB** per object
- **>5 GB**: Must use **multi-part upload**
- **Metadata**: Key-value pairs (system/user-defined)
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

### Access Patterns
- **Public Access**: Use **Bucket Policy**
- **User Access**: Use **IAM Permissions**
- **EC2 Access**: Use **IAM Roles** (not IAM users)
- **Cross-Account**: Use **Bucket Policy**

### Block Public Access
- ⚠️ **Overrides bucket policies** - even if policy allows public, Block Public Access will prevent it
- ✅ Enable if bucket should never be public
- ✅ Can be set at account level

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

### Setup
1. Enable static website hosting in Properties
2. Set index document (e.g., `index.html`)
3. Configure bucket policy for public read
4. Upload files

---

## 📦 VERSIONING

### Features
- ✅ **Best practice** - enable on all buckets
- ✅ Protects against unintended deletes
- ✅ Allows rollback to previous versions
- ✅ **Delete marker** added when object "deleted" (not permanent)
- ✅ Files uploaded before versioning have `null` version ID

### How It Works
1. Enable versioning at bucket level
2. Each upload creates new version
3. "Delete" adds delete marker (original still exists)
4. Remove delete marker to restore

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

### Use Cases
- **CRR**: Compliance, lower latency, cross-account
- **SRR**: Log aggregation, prod/test replication

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

| Class | Availability | Use Case | Notes |
|-------|-------------|----------|-------|
| **S3 Standard** | 99.99% | Frequently accessed | Default, low latency, high throughput |
| **S3 Standard-IA** | 99.9% | Infrequent access | Lower cost, retrieval fees |
| **S3 One Zone-IA** | 99.5% | Secondary backups | Single AZ, 20% cheaper than Standard-IA |
| **S3 Glacier Instant Retrieval** | - | Archive, ms retrieval | Min 90 days, accessed quarterly |
| **S3 Glacier Flexible Retrieval** | - | Archive, flexible retrieval | Min 90 days, 3-5 hours (standard), 5-12 hours (bulk) |
| **S3 Glacier Deep Archive** | - | Long-term archive | Min 180 days, 12 hours (standard), 48 hours (bulk) |
| **S3 Intelligent-Tiering** | 99.99% | Auto-optimization | Small monitoring fee, no retrieval charges |

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

## ⚠️ CRITICAL EXAM POINTS

1. **Bucket names are globally unique** (only thing in AWS)
2. **Buckets are region-specific** (not global service)
3. **Versioning is best practice** - protects against deletes
4. **Replication requires versioning** on both buckets
5. **Only new objects replicated** after enabling (use Batch for existing)
6. **Delete markers replicated** (optional), **permanent deletes NOT**
7. **No replication chaining** - A→B→C doesn't mean A→C
8. **S3 Standard is default** storage class
9. **Durability is 11 nines** for all classes
10. **Bucket policies** are most common security method

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
4. Choose replication options (delete markers, etc.)

### Static Website Hosting
1. Enable in Properties
2. Set index document
3. Configure bucket policy for public read
4. Upload files

---

*Last Updated: Based on AWS SAA-C03 Exam Guide*

