#!/bin/bash

XDG_CONFIG_HOME="$HOME/.config"
XDG_BIN_HOME="$HOME/.local/bin"
XDG_OPT_HOME="$HOME/.local/opt"
SCRIPT_ROOT_DIR=$(dirname "$(realpath "$0")")

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_BIN_HOME
mkdir -p $XDG_OPT_HOME

echo "Executing script"

ln -s "$SCRIPT_ROOT_DIR/.bashrc" "$HOME/.bashrc" 
ln -s "$SCRIPT_ROOT_DIR/.vimrc" "$HOME/.vimrc" 

ln -s "$SCRIPT_ROOT_DIR/tmux" "$XDG_CONFIG_HOME" 
ln -s "$SCRIPT_ROOT_DIR/git" "$XDG_CONFIG_HOME" 
ln -s "$SCRIPT_ROOT_DIR/hypr" "$XDG_CONFIG_HOME" 
ln -s "$SCRIPT_ROOT_DIR/ghostty" "$XDG_CONFIG_HOME" 
ln -s "$SCRIPT_ROOT_DIR/waybar" "$XDG_CONFIG_HOME" 

ln -s "$SCRIPT_ROOT_DIR/code/settings.json" "$XDG_CONFIG_HOME/Code/User/settings.json" 
ln -s "$SCRIPT_ROOT_DIR/code/keybindings.json" "$XDG_CONFIG_HOME/Code/User/keybindings.json" 
