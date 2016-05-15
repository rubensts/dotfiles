## PATHS
# Enter any necessary PATH alteration here

export TERM="xterm-256color"
alias ssh2q='ssh -F ~/prj/remote-dba/ssh_config'
alias scp2q='scp -F ~/prj/remote-dba/ssh_config'
alias pipup="sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U"
alias pipold="sudo pip list --outdated"
alias conkeror='firefox --app ~/git/conkeror/application.ini'
alias ls='ls --group-directories-first --color=always'
alias x='startx'

# Persistent rehash
# source: https://wiki.archlinux.org/index.php/zsh
zstyle ':completion:*' rehash true

# rbenv PATH config
#export RBENV_ROOT="${HOME}/.rbenv"
#if [ -d "${RBENV_ROOT}" ]; then
#  export PATH="${RBENV_ROOT}/bin:${PATH}"
#  eval "$(rbenv init -)"
#fi

## Antigen - plugin manager
source ~/git/antigen/antigen.zsh

## Load the oh-my-zsh's library.
antigen use oh-my-zsh

## Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES

        #archlinux
        #systemd
        emacs
        git
        github
        gitignore
        pip
        #lein
        command-not-found
        screen
        zsh-users/zsh-syntax-highlighting
        zsh-users/zsh-autosuggestions

EOBUNDLES

## Config the bullettrain theme
BULLETTRAIN_DIR_EXTENDED=2
BULLETTRAIN_RUBY_PREFIX="♦"
BULLETTRAIN_VIRTUALENV_PREFIX="🐍"

BULLETTRAIN_PROMPT_ORDER=(
    time
    dir
    virtualenv
    ruby
    go
    git
)

# The context segment shows user@host on the shell.
# The line below sets it to only display when is not the Default user.
export DEFAULT_USER=rubens

## Apply the theme
#antigen theme bhilburn/powerlevel9k powerlevel9k
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

## Tell antigen that you're done.
antigen apply

# Keychain
eval $(keychain --eval --quiet id_rsa 6BB1CF3B --agents ssh,gpg)

## Shows a fortune
fortune
echo
