require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/ghostty/content"

if ! command -v ghostty >/dev/null 2>&1; then
    warning "Ghostty is not installed. Skipping setup."
    return 0
fi

rm -rf "$DOTFILES_CONFIG_DIR/ghostty"
ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/ghostty"

success "Ghostty setup completed."