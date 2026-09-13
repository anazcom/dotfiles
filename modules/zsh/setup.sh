require DOTFILES_ROOT_DIR
require DOTFILES_CONFIG_DIR

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/zsh/content"

if ! command -v zsh >/dev/null 2>&1; then
    warning "zsh is not installed in the system"
    return 0
fi

default_shell="$(getent passwd "$USER" | cut -d: -f7)"

if ! [[ "$default_shell" == */zsh ]]; then
    warning "zsh is not the default shell in the system, skipping"
    return 0
fi

rm -rf "$HOME/.config/zsh" && ln -s "$CONTENT_DIR/zsh" "$HOME/.config/zsh"
rm -rf "$HOME/.zshrc" && ln -s "$CONTENT_DIR/.zshrc"  "$HOME/.zshrc"

success "Zsh setup completed"

