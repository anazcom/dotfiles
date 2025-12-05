require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/vim/content"

if ! command -v vim >/dev/null 2>&1; then
    warning "Vim is not installed. Skipping setup."
    return 0
fi

if [ -d "$HOME/.vimrc" ]; then 
    rm -rf "$HOME/.vimrc"
fi

ln -s "$CONTENT_DIR/.vimrc" "$HOME/.vimrc"
success "Vim setup completed."