#!/bin/bash

ENV_FILE="./buckets.env"

# In buckets.env
# BUCKETS=("my-bucket-1" "my-bucket-2" "my-bucket-3")

# Check if the env file exists
if [[ ! -f "$ENV_FILE" ]]; then
  echo "[ERROR] Environment file '$ENV_FILE' not found."
  exit 1
fi

# Load the file
# shellcheck disable=SC1090
source "$ENV_FILE"

# Ensure BUCKETS is defined as array even if not set
BUCKETS=("${BUCKETS[@]:-}")

# Check if BUCKETS is empty
if [[ ${#BUCKETS[@]} -eq 0 ]]; then
  echo "[ERROR] No buckets defined in '$ENV_FILE'."
  exit 1
fi

# Process each bucket
for bucket in "${BUCKETS[@]}"; do
  echo "Processing bucket: $bucket"

  if ! aws s3api head-bucket --bucket "$bucket" 2>/dev/null; then
    echo "[SKIP] Bucket does not exist or access denied: $bucket"
    continue
  fi

  versioning=$(aws s3api get-bucket-versioning --bucket "$bucket" --query 'Status' --output text 2>/dev/null)

  if [[ "$versioning" == "Enabled" ]]; then
    echo "  -> Deleting all versions in $bucket"
    aws s3api list-object-versions --bucket "$bucket" --output json \
      | jq -r '.Versions[]?, .DeleteMarkers[]? | [.Key, .VersionId] | @tsv' \
      | while IFS=$'\t' read -r key version; do
          aws s3api delete-object --bucket "$bucket" --key "$key" --version-id "$version"
        done
  else
    echo "  -> Deleting all objects in $bucket"
    aws s3 rm "s3://$bucket" --recursive
  fi

  echo "  -> Deleting bucket $bucket"
  aws s3api delete-bucket --bucket "$bucket"

  echo "[DONE] $bucket deleted"
  echo
done

# Before Running:
# Ensure jq is installed (for JSON parsing): `sudo apt install jq` or `brew install jq