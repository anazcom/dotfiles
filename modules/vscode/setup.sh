require DOTFILES_ROOT_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/vscode/content"

if ! command -v code >/dev/null 2>&1; then
    warning "VSCode is not installed. Skipping setup."
    return 0
fi

case "$DOTFILES_OS" in
    "Linux")
        CODE_SETTINGS_DIR="$HOME/.config/Code/User"
        ;;
    "Darwin")
        CODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
        ;;
    *)
        warning "Unsupported OS for VSCode setup. Skipping."
        return 0    
        ;;
esac

if [ -f "$CODE_SETTINGS_DIR/settings.json" ]; then 
    rm -rf "$CODE_SETTINGS_DIR/settings.json"
fi

if [ -f "$CODE_SETTINGS_DIR/keybindings.json" ]; then 
    rm -rf "$CODE_SETTINGS_DIR/keybindings.json"
fi

ln -s "$CONTENT_DIR/settings.json" "$CODE_SETTINGS_DIR/settings.json"
ln -s "$CONTENT_DIR/keybindings.json" "$CODE_SETTINGS_DIR/keybindings.json"
success "VSCode setup completed."