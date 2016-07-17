#!/usr/local/bin/bash
printf -v ARGS "%q " "$@"
exec ssh notmuch notmuch ${ARGS}

