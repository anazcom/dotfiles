require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR
require DOTFILES_BIN_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/scripts/content"

for pkg in "devcontainer docker"; do
    if ! command -v "${pkg%% *}" >/dev/null 2>&1; then
        warning "$pkg is not installed. Skipping tmux setup."
        return 0
    fi
done

rm -rf "$DOTFILES_BIN_DIR/devc"

ln -s "$CONTENT_DIR/devc" "$DOTFILES_BIN_DIR/devc"

success "Devc setup completed."
