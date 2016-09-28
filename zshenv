## Setting PATH

# asciidoc xml support
#export XML_CATALOG_FILES=/usr/local/etc/xml/catalog
export XML_CATALOG_FILES=/etc/xml/catalog

# Python - pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/prj/document-publisher:$PATH"
eval "$(pyenv init -)"

# Python - virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/prj
source /usr/local/bin/virtualenvwrapper.sh

# Keychain
eval `keychain --eval --quiet --agents ssh,gpg id_rsa 6BB1CF3B`
