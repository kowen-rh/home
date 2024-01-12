install:
	stow --no-folding --ignore '.git/|.gitignore|Makefile' --target ~ .

.PHONY: install
