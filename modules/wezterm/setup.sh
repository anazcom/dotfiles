require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/wezterm/content"

if ! command -v wezterm >/dev/null 2>&1; then
    warning "Wezterm is not installed. Skipping setup."
    return 0
fi

rm -rf "$HOME/.wezterm.lua"
ln -s "$CONTENT_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
success "Wezterm setup completed."
