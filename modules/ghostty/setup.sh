require DOTFILES_ROOT_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/ghostty/content"

if [ ! $DOTFILES_CONTAINER_SETUP == "true" ]; then
    warning "Skipping ghostty. Container does not require it!!"
    exit 0
fi

if ! command -v ghostty >/dev/null 2>&1; then
    warning "Ghostty is not installed. Skipping setup."
    exit 0
fi

if [ -d "$HOME/.config/ghostty" ]; then 
    rm -rf "$HOME/.config/ghostty"
fi

ln -s "$CONTENT_DIR" "$HOME/.config/ghostty"
success "Ghostty setup completed."