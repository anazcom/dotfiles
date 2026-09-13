#!/bin/bash

require DOTFILES_ROOT_DIR
require DOTFILES_SHELL  
require HOME

CONTENT_DIR="$DOTFILES_ROOT_DIR/modules/bash/content"

default_shell="$(getent passwd "$USER" | cut -d: -f7)"

if ! [[ "$default_shell" == */bash ]]; then
    warning "bash is not the default shell in the system, skipping"
    return 0
fi

bash_files=(".bashrc" ".bash_profile" ".bash_env" ".bash_containers")
for name in ${bash_files[@]};
do
	rm -f "$HOME/$name"
	ln -s "$CONTENT_DIR/$name" "$HOME/$name"
done

success "Bash setup completed."
