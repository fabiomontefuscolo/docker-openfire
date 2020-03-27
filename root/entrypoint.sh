#!/bin/sh
rsync -a --ignore-existing      \
    /opt/openfire/base-plugins/ \
    /opt/openfire/plugins/

rsync -a --ignore-existing   \
    /opt/openfire/base-conf/ \
    /opt/openfire/conf

exec "$@"
