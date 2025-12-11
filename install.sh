#!/bin/bash

DOTFILES_SHELL=${DOTFILES_SHELL:-"/bin/bash"}
################################################
DOTFILES_ROOT_DIR=$(dirname "$(realpath "$0")")
DOTFILES_ENABLED_DIR="$DOTFILES_ROOT_DIR/enabled.d"
DOTFILES_MODULES_DIR="$DOTFILES_ROOT_DIR/modules"
DOTFILES_CONFIG_DIR="$HOME/.config"
DOTFILES_BIN_DIR="$HOME/.local/bin"
DOTFILES_OPT_DIR="$HOME/.local/opt"
DOTFILES_OS="$(uname -s)"
if [ "$DOTFILES_OS" = "Darwin" ]; then
	DOTFILES_OS_DISTRO="macos"
else
	DOTFILES_OS_DISTRO="$(grep '^ID=' /etc/os-release | cut -d= -f2)"
fi

mkdir -p $DOTFILES_CONFIG_DIR
mkdir -p $DOTFILES_BIN_DIR
mkdir -p $DOTFILES_OPT_DIR

source "$DOTFILES_ROOT_DIR/lib/common.sh"

if [ ! -d "$DOTFILES_MODULES_DIR" ]; then
	error "Modules directory not found at $DOTFILES_MODULES_DIR"
	exit 1
fi

for enabled_file in $(ls "$DOTFILES_ENABLED_DIR" | sort); do
	echo $enabled_file
	# Extract module name after first dash
	module_name="${enabled_file#*-}"
	setup_script="$DOTFILES_MODULES_DIR/$module_name/setup.sh"
	if [ -f "$setup_script" ]; then
		info "Executing setup for module: $module_name"
		source "$setup_script"
	else
		error "No setup.sh found for module: $module_name"
		exit 1
	fi
done
