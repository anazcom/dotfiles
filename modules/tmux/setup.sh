require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/tmux/content"

for pkg in "tmux tmux-sessionizer fzf"; do
    if ! command -v "${pkg%% *}" >/dev/null 2>&1; then
        warning "$pkg is not installed. Skipping tmux setup."
        return 0
    fi
done

rm -rf "$HOME/.tmux.conf"
rm -rf "$DOTFILES_BIN_DIR/tmux-sessionizer"

ln -s "$CONTENT_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$CONTENT_DIR/tmux-sessionizer" "$DOTFILES_BIN_DIR/tmux-sessionizer"

success "Tmux setup completed."
