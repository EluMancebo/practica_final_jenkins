#!/bin/bash

# Configurar identidad de usuario para Git
git config --global user.name "EluM"
git config --global user.email "emango0298@gmail.com"

# Cambiar al directorio raíz del proyecto
cd jenkins-pipeline-project || {
    echo "Error: No se encontró el directorio del proyecto"
    exit 1
}

# Verificar si hay cambios en README.md
if git diff --quiet README.md; then
    echo "No hay cambios en README.md para confirmar."
    exit 0
fi

# Añadir y confirmar cambios en README.md
git add README.md
if git commit -m "Pipeline ejecutada por $1. Motivo: $2"; then
    echo "Commit creado con éxito."
else
    echo "No hay cambios para confirmar."
    exit 0
fi

# Configurar la URL remota con credenciales
git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/EluMancebo/practica_final_jenkins.git

# Asegurar que el árbol de trabajo esté sincronizado con el remoto
echo "Actualizando la rama local..."
git fetch origin ci_jenkins || {
    echo "Error al hacer fetch del remoto."
    exit 1
}
git rebase origin/ci_jenkins || {
    echo "Error al hacer rebase con la rama remota."
    exit 1
}

# Hacer push al remoto
echo "Haciendo push al remoto..."
if git push origin ci_jenkins; then
    echo "Push realizado con éxito."
else
    echo "Error al hacer push al remoto."
    exit 1
fi
