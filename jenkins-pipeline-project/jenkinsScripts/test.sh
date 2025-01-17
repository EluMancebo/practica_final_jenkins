#!/bin/bash

npm run test -- --ci --silent

if [ $? -eq 0 ]; then
  echo "Test: success"
  exit 0
else
  echo "Test: failed"
  exit 1
fi
