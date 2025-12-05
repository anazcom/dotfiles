require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/git/content"

if ! command -v git >/dev/null 2>&1; then
    warning "Git is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/git" ]; then
    rm -rf "$DOTFILES_CONFIG_DIR/git"
fi

ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/git"
success "Git setup completed."