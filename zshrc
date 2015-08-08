# PATHS
# Enter any necessary PATH alteration here

# Antigen - plugin manager
source ~/prj/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES

	# SO
	archlinux
	systemd

	# Dev
	emacs
	git
	github
	gitignore
	pip
	#lein

	
	command-not-found
	screen

	# Syntax highlighting bundle
	zsh-users/zsh-syntax-highlighting

EOBUNDLES

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

# Shows a fortune
fortune -a
