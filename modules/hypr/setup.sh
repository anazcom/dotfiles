require DOTFILES_ROOT_DIR
require DOTFILES_CONTAINER_SETUP
require DOTFILES_OS
require DOTFILES_OS_DISTRO

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/hypr/content"

if  [[ "$DOTFILES_CONTAINER_SETUP" == "true" ]] || \
    [[ $DOTFILES_OS != "Linux" ]] || \
    [[ $DOTFILES_OS_DISTRO != "arch" ]]; then
    warning "Skipping hyprland setup. Not running Linux/Arch."
    return 0
fi

if ! command -v hyprctl >/dev/null 2>&1; then
    warning "Hyprland is not installed. Skipping setup."
    return 0
fi

if [ -d "$DOTFILES_CONFIG_DIR/hypr" ]; then 
    rm -rf "$DOTFILES_CONFIG_DIR/hypr"
fi

mkdir -p "$DOTFILES_CONFIG_DIR/hypr"
ln -s "$CONTENT_DIR" "$DOTFILES_CONFIG_DIR/hypr"
success "Hyprland setup completed."