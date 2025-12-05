require DOTFILES_ROOT_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/git/content"

if ! command -v git >/dev/null 2>&1; then
    warning "Git is not installed. Skipping setup."
    return 0
fi

if [ -d "$HOME/.config/git" ]; then
    rm -rf "$HOME/.config/git"
fi

ln -s "$CONTENT_DIR" "$HOME/.config/git"
success "Git setup completed."