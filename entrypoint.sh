#!/bin/sh
set -x

cp -au                                   \
    ${OPENFIRE_HOME}/plugins-required/.  \
    ${OPENFIRE_HOME}/plugins/

if [ -n "${NO_WIZARD}" ] && ! grep -q '<setup>true</setup>' /opt/openfire/conf/openfire.xml;
then
    cat > /opt/openfire/conf/openfire.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<jive>
  <adminConsole>
  <port>9090</port>
  <securePort>-1</securePort>
  </adminConsole>
  <locale>en</locale>
EOF

    if [ -n "${MYSQL_DATABASE}" ] && [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ];
    then
        cat >> /opt/openfire/conf/openfire.xml <<EOF
  <connectionProvider>
    <className>org.jivesoftware.database.DefaultConnectionProvider</className>
  </connectionProvider>
  <database>
    <defaultProvider>
      <driver>com.mysql.cj.jdbc.Driver</driver>
      <serverURL>jdbc:mysql://${MYSQL_USER:-db}:3306/${MYSQL_DATABASE}?rewriteBatchedStatements=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8&amp;serverTimezone=UTC</serverURL>
      <username>${MYSQL_USER}</username>
      <password>${MYSQL_PASSWORD}</password>
      <testSQL>select 1</testSQL>
      <testBeforeUse>false</testBeforeUse>
      <testAfterUse>false</testAfterUse>
      <testTimeout>500</testTimeout>
      <timeBetweenEvictionRuns>30000</timeBetweenEvictionRuns>
      <minIdleTime>900000</minIdleTime>
      <maxWaitTime>500</maxWaitTime>
      <minConnections>5</minConnections>
      <maxConnections>25</maxConnections>
      <connectionTimeout>1.0</connectionTimeout>
    </defaultProvider>
  </database>
EOF
    fi

    if [ -n "${of_fqdn}" ];
    then
        cat >> /opt/openfire/conf/openfire.xml <<EOF
  <fqdn>${of_fqdn}</fqdn>"
  <setup>${of_setup:-true}</setup>"
EOF
    fi

    if [ -n "${of_xmpp_domain}" ];
    then
        cat >> /opt/openfire/conf/openfire.xml <<EOF
  <xmpp><domain>${of_xmpp_domain}</domain></xmpp>
EOF
    fi

    echo "</jive>" >> /opt/openfire/conf/openfire.xml
fi

exec "$@"
