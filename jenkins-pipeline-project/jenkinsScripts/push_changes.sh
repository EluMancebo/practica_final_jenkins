#!/bin/bash
git config --global user.name "EluMancebo"
git config --global user.email "emango0298@gmail.com"

cd jenkins-pipeline-project
git add jenkins-pipeline-project/README.md


git commit -m "Pipeline ejecutada por $EXECUTOR, el motivo es: $MOTIVO"


git push origin ci_jenkins


if [ $? -eq 0 ]; then
  echo "Push: success"
  exit 0
else
  echo "Push: failed"
  exit 1
fi
