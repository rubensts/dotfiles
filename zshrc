## PATHS
# Enter any necessary PATH alteration here

## Antigen - plugin manager
source ~/prj/dotfiles/antigen/antigen.zsh

## Load the oh-my-zsh's library.
antigen use oh-my-zsh

## Bundles from the default repo (robbyrussell's oh-my-zsh).
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

  # Productivity	
	command-not-found
	screen

	# Syntax highlighting bundle
	zsh-users/zsh-syntax-highlighting

EOBUNDLES

## Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)

# The context segment (listed above) shows user@host on the shell.
# The line below sets it to only display when is not the Default user.
export DEFAULT_USER=rubens

# Limit dir segmente (listed above) to show only the last two folders
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# Output time, date, and a symbol from the "Awesome Powerline Font" set
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868}"


## Tell antigen that you're done.
antigen apply

## Shows a fortune
fortune -a
