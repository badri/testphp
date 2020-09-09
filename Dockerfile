FROM bitnami/php-fpm:7.4-prod AS php

RUN useradd -u 1001 -r -g 0 -d /app -s /bin/bash -c "Default Application User" default \
    && mkdir -p /app \
    && chown -R 1001:0 /app && chmod -R g+rwX /app

USER 1001

WORKDIR /app

ADD . ./

FROM bitnami/nginx:1.19 AS nginx


COPY --from=php /app /

ADD nginx.conf /opt/bitnami/nginx/conf
ADD drupal.conf /opt/bitnami/nginx/conf/server_blocks
