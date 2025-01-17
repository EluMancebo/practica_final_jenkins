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

# Añadir todos los cambios restantes al área de staging
git add .

# Crear un commit con las variables de entorno
git commit -m "Pipeline ejecutada por $EXECUTOR, el motivo es: $MOTIVO"

# Verificar si se usan credenciales para HTTPS o SSH
if git remote -v | grep -q "https://"; then
    # Configurar la URL remota con credenciales HTTPS si es necesario
    git remote set-url origin https://<TOKEN>@github.com/EluMancebo/practica_final_jenkins.git
fi

# Realizar el push al remoto
git push origin ci_jenkins

# Verificar el resultado del push
if [ $? -eq 0 ]; then
    echo "Push: success"
    exit 0
else
    echo "Push: failed"
    exit 1
fi
