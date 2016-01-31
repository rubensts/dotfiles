## Setting PATH

# don't add anything to $path if it's there already
typeset -U path

# asciidoc xml support
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

# Python
export PYTHONPATH=/usr/local/bin

# Go
export GOPATH=$HOME/prj/go

path=(
    /usr/local/bin
    /usr/local/sbin
    $HOME/.cask/bin
    # 2ndQuadrant-asciidoc path
    /usr/local/Cellar/gnu-getopt/1.1.6/bin
    $path
    $GOPATH/bin
)

## Shows a fortune
fortune
echo
