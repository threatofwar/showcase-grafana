FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    curl \
    apt-transport-https \
    gnupg2 \
    lsb-release && \
    curl https://packages.grafana.com/gpg.key | tee /etc/apt/trusted.gpg.d/grafana.asc && \
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/grafana.asc] https://packages.grafana.com/oss/deb stable main" | tee /etc/apt/sources.list.d/grafana.list && \
    apt-get update && \
    apt-get install -y grafana=11.4.0 adduser libfontconfig1 musl

RUN mkdir -p /var/lib/grafana /var/log/grafana /etc/grafana

RUN chown -R grafana:grafana /var/lib/grafana /var/log/grafana /etc/grafana

ENV GF_PATHS_CONFIG=/etc/grafana/grafana.ini
ENV GF_PATHS_DATA=/var/lib/grafana
ENV GF_PATHS_LOGS=/var/log/grafana
ENV GF_PATHS_PLUGINS=/var/lib/grafana/plugins
ENV GF_PATHS_HOME=/usr/share/grafana

USER grafana

WORKDIR /usr/share/grafana

EXPOSE 3000

CMD ["grafana-server", "web"]
