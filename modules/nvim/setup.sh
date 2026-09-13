require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/nvim/content"

if ! command -v nvim >/dev/null 2>&1; then
    warning "Nvim is not installed. Skipping setup."
    return 0
fi

rm -rf "$DOTFILES_CONFIG_DIR/nvim"
ln -s "$CONTENT_DIR/nvim" "$DOTFILES_CONFIG_DIR/nvim"

success "Nvim setup completed."
