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

bash_files=(".bashrc" ".bash_profile" ".bash_env" ".bash_containers")
for name in ${bash_files[@]};
do
	rm -f "$HOME/$name"
	ln -s "$CONTENT_DIR/$name" "$HOME/$name"
done

success "Bash setup completed."
