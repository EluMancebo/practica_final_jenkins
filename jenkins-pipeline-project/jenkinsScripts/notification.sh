#!/bin/bash


curl -X POST \
  https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
  -d chat_id=$CHAT_ID \
  -d text="S'ha executat la pipeline de jenkins amb els següents resultats:
  - Linter_stage: $LINTER_RESULT
  - Test_stage: $TEST_RESULT
  - Update_readme_stage: $README_UPDATE_RESULT
  - Deploy_to_Vercel_stage: $DEPLOY_RESULT"


if [ $? -eq 0 ]; then
  echo "Notificació: success"
  exit 0
else
  echo "Notificació: failed"
  exit 1
fi
