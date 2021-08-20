ARG MYSQL_VERSION=5.7
FROM mysql:${MYSQL_VERSION}
# FROM mysql/mysql-server:${MYSQL_VERSION}

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV CONFIG_FILE=/etc/mysql/conf.d/docker.cnf

RUN echo 'max_allowed_packet = 1G' >> ${CONFIG_FILE}

ARG MYSQL_GENERAL_LOG=false
RUN if [ ${MYSQL_GENERAL_LOG} = true ]; then \
    echo 'general_log = 1' >> ${CONFIG_FILE} \
    && echo 'general_log_file = /var/log/mysql/general.log' >> ${CONFIG_FILE} \
; fi
