require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/vicinae/content"

if ! command -v vicinae >/dev/null 2>&1; then
    warning "Vicinae is not installed. Skipping setup."
    return 0
fi

rm -rf "$DOTFILES_CONFIG_DIR/vicinae"
ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/vicinae"

success "Vicinae setup completed."
