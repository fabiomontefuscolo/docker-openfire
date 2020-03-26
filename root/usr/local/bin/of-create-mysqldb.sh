#!/bin/sh
set -eu

db_host="${OF_DB_HOST:-db}"
db_name="${OF_DB_NAME:-openfire}"
db_user="${OF_DB_USER:-ofuser}"
db_pass="${OF_DB_PASS:-ofpass}"

/usr/bin/mysql -v   \
    -h "${db_host}" \
    -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${db_name}\`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON \`${db_name}\`.*
    TO '${db_user}'@'%'
    IDENTIFIED BY '${db_pass}';
FLUSH PRIVILEGES;
EOF

cat <<EOF
mysql://${db_user}:${db_pass}@${db_host}/${db_name}
EOF