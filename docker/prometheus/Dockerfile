FROM prom/prometheus:v2.8.0
# https://hub.docker.com/r/prom/prometheus/tags/

LABEL maintainer="haidv@tomochain.com"

COPY conf /etc/prometheus/

ENTRYPOINT [ "/etc/prometheus/docker-entrypoint.sh" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus" ]
