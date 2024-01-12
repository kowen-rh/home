install:
	stow --no-folding --ignore '.git/|Makefile' --target ~ .

.PHONY: install
