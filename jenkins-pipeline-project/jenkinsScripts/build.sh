#!/bin/bash
cd jenkins-pipeline-project || exit 1
npm run build

if [ $? -eq 0 ]; then
  echo "Build: success"
  exit 0
else
  echo "Build: failed"
  exit 1
fi
