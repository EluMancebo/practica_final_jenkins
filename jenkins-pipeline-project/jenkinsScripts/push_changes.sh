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

# Añadir todos los cambios restantes
git add .

# Crear un commit con las variables de entorno
git commit -m "Pipeline ejecutada por $EXECUTOR, el motivo es: $MOTIVO" || echo "Nada que confirmar"

# Realizar el push al remoto con credenciales HTTPS
echo "Haciendo push al remoto..."
git push origin ci_jenkins || {
    echo "Error al hacer push. Intentando resolver..."
    git pull origin ci_jenkins --rebase
    git push origin ci_jenkins || {
        echo "Push fallido después de intentar resolver conflictos."
        exit 1
    }
}

# Verificar el resultado del push
if [ $? -eq 0 ]; then
    echo "Push: success"
    exit 0
else
    echo "Push: failed"
    exit 1
fi
