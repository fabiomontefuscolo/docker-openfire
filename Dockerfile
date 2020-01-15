FROM alpine
MAINTAINER Fabio Montefuscolo <fabio.montefuscolo@gmail.com>

ENV OPENFIRE_HOME=/opt/openfire
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
EXPOSE 5222 5223 5229 5262 5263 5269 5275 5276 7070 7443 7777 9090 9091

ARG OPENFIRE_PACKAGE=https://github.com/igniterealtime/Openfire/releases/download/v4.5.0/openfire_4_5_0.tar.gz

ADD log4j2.xml ${OPENFIRE_HOME}/conf/log4j2.xml
RUN apk update && apk add openjdk11-jre-headless sudo                \
    && wget -O /root/openfire.tar.gz "${OPENFIRE_PACKAGE}"           \
    && tar -C /opt -zxvf /root/openfire.tar.gz                       \
    && rm /root/openfire.tar.gz /var/cache/apk/*                     \
    && adduser -h ${OPENFIRE_HOME} -H -D -u 1000 openfire            \
    && chown -R openfire: ${OPENFIRE_HOME}

CMD /usr/bin/sudo -u openfire                                        \
    /usr/bin/java                                                    \
        -server                                                      \
        -Dlog4j.configurationFile=${OPENFIRE_HOME}/conf/log4j2.xml   \
        -DopenfireHome=${OPENFIRE_HOME}                              \
        -Dopenfire.lib.dir=${OPENFIRE_HOME}/lib                      \
        -classpath ${OPENFIRE_HOME}/lib/startup.jar                  \
        -jar ${OPENFIRE_HOME}/lib/startup.jar
