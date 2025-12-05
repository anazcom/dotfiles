require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR
require DOTFILES_CONTAINER_SETUP

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/ghostty/content"

if [ ! $DOTFILES_CONTAINER_SETUP == "true" ]; then
    warning "Skipping ghostty. Container does not require it!!"
    return 0
fi

if ! command -v ghostty >/dev/null 2>&1; then
    warning "Ghostty is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/ghostty" ]; then 
    rm -rf "$DOTFILES_CONFIG_DIR/ghostty"
fi

ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/ghostty"
success "Ghostty setup completed."