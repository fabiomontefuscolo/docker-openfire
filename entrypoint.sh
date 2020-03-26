#!/bin/sh
set -x

cp -au                                   \
    ${OPENFIRE_HOME}/plugins-required/.  \
    ${OPENFIRE_HOME}/plugins/

exec "$@"
