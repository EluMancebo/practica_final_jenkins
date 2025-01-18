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
git commit -m "Actualización automática del README.md con resultados de pruebas"

# Configurar la URL remota con credenciales (asegurarse de que estén definidas)
if [ -z "${GIT_USERNAME}" ] || [ -z "${GIT_PASSWORD}" ]; then
    echo "Error: Las credenciales GIT_USERNAME o GIT_PASSWORD no están definidas."
    exit 1
fi

# Configurar la URL remota con token
git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/EluMancebo/practica_final_jenkins.git

# Verificar el estado actual de la rama
echo "Actualizando la rama local..."
git fetch origin ci_jenkins || {
    echo "Error al hacer fetch del remoto."
    exit 1
}
git rebase origin/ci_jenkins || {
    echo "Error al hacer rebase con la rama remota."
    exit 1
}

# Intentar hacer push al remoto
echo "Haciendo push al remoto..."
git push origin ci_jenkins || {
    echo "Error al hacer push al remoto."
    exit 1
}

echo "Push realizado con éxito."
exit 0
