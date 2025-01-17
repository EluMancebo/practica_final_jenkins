#!/bin/bash

npm run build

if [ $? -eq 0 ]; then
  echo "Build: success"
  exit 0
else
  echo "Build: failed"
  exit 1
fi
