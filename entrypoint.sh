#!/bin/bash

cp -an /opt/openfire/plugins-folder/. /opt/openfire/plugins/
exec "$@"

