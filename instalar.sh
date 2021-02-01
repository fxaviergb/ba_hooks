#!/bin/sh

# Nombre y URL del repositorio de hooks
REPO_NAME="baustro"
CLONE_URL="https://github.com/fxaviergb/${REPO_NAME}.git"

# Definir rutas de instalación
INSTALL_DIR_ROOT="$HOME/.${REPO_NAME}"
INSTALL_DIR_HOOKS="${INSTALL_DIR_ROOT}/hooks"

# Eliminar instalación previa si existe
if [ -d "${INSTALL_DIR_ROOT}" ]
then
	rm -rf "${INSTALL_DIR_ROOT}"
fi

# Clonar el repositorio en la ruta de intalación
git clone "$CLONE_URL" "$INSTALL_DIR_ROOT"

# Configurar la variable global de hooks
git config --global core.hooksPath "${INSTALL_DIR_HOOKS}"