#!/bin/bash

XDG_CONFIG_HOME="$HOME/.config"
XDG_BIN_HOME="$HOME/.local/bin"
SCRIPT_ROOT_DIR=$(dirname "$(realpath "$0")")

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_BIN_HOME

echo "Executing script"
mv "$SCRIPT_ROOT_DIR/tmux" "$XDG_CONFIG_HOME/tmux" 
mv "$SCRIPT_ROOT_DIR/git" "$XDG_CONFIG_HOME/git" 
mv "$SCRIPT_ROOT_DIR/.bashrc" "$HOME/.bashrc" 