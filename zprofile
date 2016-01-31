## Setting PATH

# don't add anything to $path if it's there already
typeset -U path

# asciidoc xml support
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

# Python
export PYTHONPATH=/usr/local/bin

# Go
export GOPATH=$HOME/prj/go

## Added by cpan
#PATH="/home/rubens/perl5/bin${PATH+:}${PATH}"; export PATH;
#PERL5LIB="/home/rubens/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/rubens/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/rubens/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/rubens/perl5"; export PERL_MM_OPT;

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
