install:
	stow --ignore '.git/|.gitignore|Makefile' --target ~ .

.PHONY: install
