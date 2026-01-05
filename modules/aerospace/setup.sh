#!/bin/bash

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/aerospace/content"

if ! [[ $DOTFILES_OS = "Darwin" ]]; then
    warning "Skipping aerospace setup: not running macOS."
    return 0
fi

if ! command -v aerospace >/dev/null 2>&1; then
    warning "Aerospace is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/aerospace" ]; then 
    rm -rf "$DOTFILES_CONFIG_DIR/aerospace"
fi

rm -rf "$HOME/.aerospace.toml"
ln -s "$CONTENT_DIR/.aerospace.toml" "$HOME/.aerospace.toml"

success "Aerospace setup completed."