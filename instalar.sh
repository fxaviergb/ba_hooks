#!/bin/sh

#

# Nombre y URL del repositorio de hooks
CLONE_URL="https://github.com/fxaviergb/baustro_hooks.git"


# Definir rutas de instalación
INSTALL_DIR_ROOT="$HOME/.baustro"
INSTALL_DIR_HOOKS="${INSTALL_DIR_ROOT}/hooks"

# Archivo de lista negra
BLACK_LIST_FILE="${INSTALL_DIR_ROOT}/lista-negra.txt"


is_up_to_date_with_origin() {
	# Commit ID de origin
	sha_origin=`git ls-remote "$CLONE_URL" | head -1 | cut -d '	' -f1`
	
	# Commit ID de local
	cd "${INSTALL_DIR_ROOT}"
	sha_local=`git log | head -1 | cut -d ' ' -f2`
	
	# Verification
	if [ "$sha_origin" = "$sha_local" ]
	then
		return 0
	else
		return 1
	fi
}


do_update() {
	if ! is_up_to_date_with_origin
	then
		echo "Actualizando estándares del Banco del Austro..."
		cd "${INSTALL_DIR_ROOT}"
		git reset origin/master --hard
		git pull
	fi
}


do_install() {
	echo "Instalando estándares del Banco del Austro..."
	git clone "$CLONE_URL" "$INSTALL_DIR_ROOT"
}


set_git_configs() {
	git config --global core.hooksPath "${INSTALL_DIR_HOOKS}"
	git config --global baustro.installDirRoot "${INSTALL_DIR_ROOT}"
	git config --global baustro.installDirHooks "${INSTALL_DIR_HOOKS}"
	git config --global baustro.blackListFile "${BLACK_LIST_FILE}"
}


execute() {
	# Instalar o actualizar el repositorio de instalación
	if [ -d "${INSTALL_DIR_ROOT}" ]
	then
		do_update
	else
		do_install
	fi
	# Configurar las variables global de git
	set_git_configs
}


# FUNCION PRINCIPAL
execute



