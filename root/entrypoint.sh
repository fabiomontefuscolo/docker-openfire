#!/bin/sh
rsync -a --ignore-existing      \
    /opt/openfire/base-plugins/ \
    /opt/openfire/plugins/

rsync -a --ignore-existing   \
    /opt/openfire/base-conf/ \
    /opt/openfire/conf

ofs="${IFS}"
IFS='
'
if [ -d "/entrypoint.d/" ];
then
    for extra in $(find /entrypoint.d/ -type f -name '*.sh');
    do
        . "$extra";
    done
    unset extra
fi
IFS="${ofs}"
unset ofs

exec "$@"
