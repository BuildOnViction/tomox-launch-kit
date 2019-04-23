FROM grafana/grafana:5.3.4
# https://hub.docker.com/r/grafana/grafana/tags/
LABEL maintainer="haidv@tomochain.com"

COPY datasources /etc/grafana/provisioning/datasources/
COPY dashboards.yml /etc/grafana/provisioning/dashboards/
COPY dashboards /etc/grafana/dashboards/

ENV GF_PATHS_PROVISIONING=/etc/grafana/provisioning/
