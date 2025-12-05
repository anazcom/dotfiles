#!/bin/bash

require DOTFILES_ROOT_DIR
require DOTFILES_SHELL  
require HOME

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/bash/content"

if [ "$DOTFILES_SHELL" != "/bin/bash" ]; then
    warning "Skipping bash setup because DOTFILES_SHELL is not set to /bin/bash"
    return 0
fi

if [ "$SHELL" != "/bin/bash" ]; then
    info "Changing default shell to /bin/bash"
    sudo chsh -s /bin/bash "$USER"
fi

if [ -f "$HOME/.bash_profile" ]; then 
    rm -rf "$HOME/.bash_profile"
fi

if [ -f "$HOME/.bashrc" ]; then 
    rm -rf "$HOME/.bashrc"
fi

ln -s "$CONTENT_DIR/.bash_profile" "$HOME/.bash_profile" 
ln -s "$CONTENT_DIR/.bashrc" "$HOME/.bashrc" 

success "Bash setup completed."