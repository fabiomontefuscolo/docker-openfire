#!/bin/sh
db_host="${OF_DB_HOST:-db}"
db_name="${OF_DB_NAME:-openfire}"
db_user="${OF_DB_USER:-ofuser}"
db_pass="${OF_DB_PASS:-ofpass}"
db_root_pass="${MYSQL_ROOT_PASSWORD}"

load_sql=""
xml_template=""

while getopts 'h:n:u:p:r:l:x:' arg;
do
    case $arg in
        h) db_host="$OPTARG" ;;
        n) db_name="$OPTARG" ;;
        u) db_user="$OPTARG" ;;
        p) db_pass="$OPTARG" ;;
        r) db_root_pass="$OPTARG" ;;
        l) load_sql="$OPTARG" ;;
        x) xml_template="$OPTARG" ;;
    esac
done

if [ -n "${db_root_pass}" ];
then
    /usr/bin/mysql -v              \
        -uroot                     \
        -p"${db_root_pass}"        \
        -h "${db_host}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${db_name}\`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON \`${db_name}\`.*
    TO '${db_user}'@'%'
    IDENTIFIED BY '${db_pass}';
FLUSH PRIVILEGES;
EOF
fi

if [ -n "${load_sql}" ] && [ -f "${load_sql}" ];
then
    /usr/bin/mysql -v   \
        -u"${db_user}"  \
        -p"${db_pass}"  \
        -h "${db_host}" \
        "${db_name}"    \
        < "${load_sql}"
fi

if [ -n "${xml_template}" ] && [ -f "${xml_template}" ];
then
    envsubst < "${xml_template}" \
        | tee /opt/openfire/conf/openfire.xml
fi