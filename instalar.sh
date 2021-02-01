#!/bin/sh

##

# Nombre y URL del repositorio de hooks
CLONE_URL="https://github.com/fxaviergb/baustro_hooks.git"

# Definir rutas de instalación
INSTALL_DIR_ROOT="$HOME/.baustro"
INSTALL_DIR_HOOKS="${INSTALL_DIR_ROOT}/hooks"

# Crear o actualizar el repositorio de instalación
if [ -d "${INSTALL_DIR_ROOT}" ]
then
	cd "${INSTALL_DIR_ROOT}"
	git reset origin/master --hard
	git pull
else
	git clone "$CLONE_URL" "$INSTALL_DIR_ROOT"
fi


# Configurar la variable global de hooks
git config --global core.hooksPath "${INSTALL_DIR_HOOKS}"
