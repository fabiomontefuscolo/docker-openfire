FROM alpine
MAINTAINER Fabio Montefuscolo <fabio.montefuscolo@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV OPENFIRE_HOME=/opt/openfire
EXPOSE 5222 5223 5229 5262 5263 5269 5275 5276 7070 7443 7777 9090 9091

ARG OPENFIRE_PACKAGE=https://github.com/igniterealtime/Openfire/releases/download/v4.5.1/openfire_4_5_1.tar.gz

RUN apk update && apk add                                  \
        gettext                                            \
        mysql-client                                       \
        openjdk11-jre-headless                             \
        rsync                                              \
        sudo                                               \
    && wget -O /tmp/openfire.tar.gz "${OPENFIRE_PACKAGE}"  \
    && tar -C /opt -zxvf /tmp/openfire.tar.gz              \
    && mv /opt/openfire/conf    /opt/openfire/base-conf    \
    && mv /opt/openfire/plugins /opt/openfire/base-plugins \
    && mkdir /opt/openfire/conf                            \
    && mkdir /opt/openfire/plugins                         \
    && mkdir /opt/openfire/embedded-db/                    \
    && rm -Rf /tmp/openfire.tar.gz /var/cache/apk/*        \
    && adduser -h /opt/openfire -H -D -u 1000 openfire

COPY root/ /
RUN chown -R openfire:openfire /opt/openfire

VOLUME ["/opt/openfire/plugins/", "/opt/openfire/conf/", "/opt/openfire/embedded-db/"]

ENTRYPOINT ["/entrypoint.sh"]
CMD /usr/bin/sudo -u openfire                                     \
    /usr/bin/java                                                 \
        -server                                                   \
        -Dlog4j.configurationFile=/opt/openfire/conf/log4j2.xml   \
        -DopenfireHome=/opt/openfire                              \
        -Dopenfire.lib.dir=/opt/openfire/lib                      \
        -classpath /opt/openfire/lib/startup.jar                  \
        -jar /opt/openfire/lib/startup.jar
