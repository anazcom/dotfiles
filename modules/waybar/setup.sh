require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR
require DOTFILES_OS
require DOTFILES_OS_DISTRO

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/waybar/content"

if [[ $DOTFILES_OS != "Linux" && $DOTFILES_OS_DISTRO != "arch" ]]; then
    warning "Skipping hyprland setup. Not running Linux/Arch."
    return 0
fi

if ! command -v waybar >/dev/null 2>&1; then
    warning "Waybar is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/waybar" ]; then 
    rm -rf "$DOTFILES_CONFIG_DIR/waybar"
fi

mkdir -p "$DOTFILES_CONFIG_DIR/waybar"
ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/waybar"
success "Waybar setup completed."