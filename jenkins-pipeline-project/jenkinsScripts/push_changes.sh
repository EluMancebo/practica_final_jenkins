#!/bin/bash

# Configurar identidad de usuario
git config --global user.name "EluM"
git config --global user.email "emango0298@gmail.com"

# Cambiar al directorio raíz del proyecto
if [ ! -d "jenkins-pipeline-project" ]; then
    echo "Error: No se encontró el directorio del proyecto"
    exit 1
fi
cd jenkins-pipeline-project

# Confirmar automáticamente cambios locales antes de cambiar de rama
if ! git diff --quiet; then
    echo "Hay cambios locales sin confirmar. Confirmándolos..."
    git add .
    git commit -m "Cambios locales automáticos antes de cambiar de rama"
fi

# Verificar si la rama ci_jenkins existe localmente y cambiar a ella
if git show-ref --verify --quiet refs/heads/ci_jenkins; then
    git checkout ci_jenkins
else
    git checkout -b ci_jenkins origin/ci_jenkins
fi

# Actualizar la rama local con el remoto
echo "Actualizando rama local con el remoto..."
git pull origin ci_jenkins --rebase || {
    echo "Error al hacer pull de la rama remota"
    exit 1
}

# Verificar si hay cambios pendientes en el directorio de trabajo
if ! git diff-index --quiet HEAD; then
    echo "Añadiendo y confirmando cambios locales..."
    git add .
    git commit -m "Pipeline ejecutada por ${EXECUTOR}, el motivo es: ${MOTIVO}"
else
    echo "Nada que confirmar. El directorio de trabajo está limpio."
fi

# Configurar la URL remota con credenciales (asegurarse de que estén definidas)
if [ -z "${GIT_USERNAME}" ] || [ -z "${GIT_PASSWORD}" ]; then
    echo "Error: Las credenciales GIT_USERNAME o GIT_PASSWORD no están definidas."
    exit 1
fi
git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/EluMancebo/practica_final_jenkins.git

# Intentar hacer push al remoto
echo "Haciendo push al remoto..."
git push origin ci_jenkins || {
    echo "Push fallido. Intentando resolver conflictos..."
    git pull origin ci_jenkins --rebase
    git push origin ci_jenkins || {
        echo "Push fallido después de intentar resolver conflictos."
        exit 1
    }
}

echo "Push realizado con éxito"
exit 0
