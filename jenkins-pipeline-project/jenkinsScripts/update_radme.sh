#!/bin/bash
cd jenkins-pipeline-project
if [ "$TEST_RESULT" == "success" ]; then
  BADGE="https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg"
else
  BADGE="https://img.shields.io/badge/test-failure-red"
fi


echo -e "\n## RESULTADO DE LOS ÚLTIMOS TESTS\n![Badge]($BADGE)" >> README.md


if [ $? -eq 0 ]; then
  echo "Update_readme: success"
  exit 0
else
  echo "Update_readme: failed"
  exit 1
fi
