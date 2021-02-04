ARG MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}

ARG MYSQL_GENERAL_LOG=false
RUN if [ ${MYSQL_GENERAL_LOG} = true ]; then \
        echo 'general_log = 1' >> /etc/mysql/conf.d/docker.cnf \
    ; else \
        echo 'general_log = 0' >> /etc/mysql/conf.d/docker.cnf \
    ; fi && \
    echo 'general_log_file = /var/log/mysql/mysql.log' >> /etc/mysql/conf.d/docker.cnf 


RUN echo 'max_allowed_packet = 128MB' >> /etc/mysql/conf.d/docker.cnf
