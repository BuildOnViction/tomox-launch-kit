FROM prom/alertmanager:v0.16.0

LABEL maintainer="haidv@tomochain.com"

COPY conf /etc/alertmanager/

ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "-config.file=/etc/alertmanager/config.yml", \
             "-storage.path=/alertmanager" ]