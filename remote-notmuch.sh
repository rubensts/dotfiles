#!/bin/bash
printf -v ARGS "%q " "$@"
exec ssh chez-notmuch notmuch ${ARGS}

#!/bin/bash
#printf -v ARGS "%q " "$@"
#exec ssh your_server addrlookup ${ARGS}
