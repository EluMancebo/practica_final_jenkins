#!/bin/bash


git config --global user.name "EluM"
git config --global user.email "emango0298@gmail.com"


cd jenkins-pipeline-project


if git show-ref --verify --quiet refs/heads/ci_jenkins; then
    git checkout ci_jenkins
else
    git checkout -b ci_jenkins origin/ci_jenkins
fi


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
