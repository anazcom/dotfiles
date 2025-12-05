require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/tmux/content"

if ! command -v tmux >/dev/null 2>&1; then
    warning "Tmux is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/tmux" ]; then 
    rm -rf "$DOTFILES_CONFIG_DIR/tmux"
fi

if [ -f "$DOTFILES_BIN_DIR/tmux-sessionizer" ]; then 
    rm -rf "$DOTFILES_BIN_DIR/tmux-sessionizer"
fi

mkdir -p "$DOTFILES_CONFIG_DIR/tmux"
ln -s "$CONTENT_DIR/.tmux.conf" "$DOTFILES_CONFIG_DIR/tmux/.tmux.conf"
ln -s "$CONTENT_DIR/tmux-sessionizer" "$DOTFILES_BIN_DIR/tmux-sessionizer"
success "Tmux setup completed."