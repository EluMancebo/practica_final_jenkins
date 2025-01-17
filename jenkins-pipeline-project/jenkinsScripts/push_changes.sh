#!/bin/bash


git add README.md


git commit -m "Pipeline ejecutada por $EXECUTOR, el motivo es: $MOTIVO"


git push origin ci_jenkins


if [ $? -eq 0 ]; then
  echo "Push: success"
  exit 0
else
  echo "Push: failed"
  exit 1
fi
