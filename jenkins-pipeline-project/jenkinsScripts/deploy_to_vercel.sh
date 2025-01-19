#!/bin/bash
cd jenkins-pipeline-project || exit 1
if ! command -v vercel &> /dev/null; then
  npm install -g vercel
fi

vercel --prod --token $VERCEL_TOKEN

if [ $? -eq 0 ]; then
  echo "Deploy: success"
  exit 0
else
  echo "Deploy: failed"
  exit 1
fi
