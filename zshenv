## Setting PATH

# asciidoc xml support
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

# Python - pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/prj/document-publisher:$PATH"
eval "$(pyenv init -)"

