#!/bin/bash

npx eslint .

if [ $? -eq 0 ]; then
  echo "Linter: success"
  exit 0
else
  echo "Linter: failed"
  exit 1
fi
