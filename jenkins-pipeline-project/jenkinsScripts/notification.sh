#!/bin/bash

# Cambiar al directorio del proyecto
cd jenkins-pipeline-project || {
    echo "Error: No se encontró el directorio del proyecto"
    exit 1
}

# Validar que las variables necesarias están definidas
if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$CHAT_ID" ]]; then
    echo "Error: Las credenciales de Telegram no están definidas."
    exit 1
fi

# Exportar variables para garantizar su disponibilidad
export LINTER_RESULT
export TEST_RESULT
export BUILD_RESULT
export README_UPDATE_RESULT
export DEPLOY_RESULT

# Enviar notificación a Telegram
curl -s -X POST \
    "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${CHAT_ID}" \
    -d "text=S'ha executat la pipeline de Jenkins amb els següents resultats:
    - Linter_stage: $LINTER_RESULT
    - Test_stage: $TEST_RESULT
    - Build_stage: $BUILD_RESULT
    - Update_readme_stage: $README_UPDATE_RESULT
    - Deploy_to_Vercel_stage: $DEPLOY_RESULT" > /dev/null

if [[ $? -eq 0 ]]; then
    echo "Notificació: success"
    exit 0
else
    echo "Notificació: failed"
    exit 1
fi
