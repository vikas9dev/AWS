#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
# updated script to make it work with Amazon Linux 2023
CHECK_IMDSV1_ENABLED=$(curl -s -o /dev/null -w "%{http_code}" http://169.254.169.254/latest/meta-data/)
if [[ "$CHECK_IMDSV1_ENABLED" -eq 200 ]]
then
    EC2_AVAIL_ZONE="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)"
else
    EC2_AVAIL_ZONE="$(TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") && curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)"
fi
echo "<h1>Hello world from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1>" > /var/www/html/index.html