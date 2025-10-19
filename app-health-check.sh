#!/bin/bash

# URL of the application to check
URL="https://wisecow.local"

# Send a request and get the HTTP status code
STATUS_CODE=$(curl -k -o /dev/null -s -w "%{http_code}" "$URL")


# Check if status code is 2xx
if [[ $STATUS_CODE =~ ^2 ]]; then
  echo "Application is UP. Status code: $STATUS_CODE"
  exit 0
else
  echo "Application is DOWN or unreachable. Status code: $STATUS_CODE"
  exit 1
fi

