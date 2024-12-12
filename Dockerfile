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
    apt-get install -y grafana=11.4.0

RUN useradd -ms /bin/bash grafana

RUN chown -R grafana:grafana /var/lib/grafana /var/log/grafana /etc/grafana

ENV GF_PATHS_CONFIG=/etc/grafana/grafana.ini
ENV GF_PATHS_DATA=/var/lib/grafana
ENV GF_PATHS_LOGS=/var/log/grafana
ENV GF_PATHS_PLUGINS=/var/lib/grafana/plugins

USER grafana

EXPOSE 3000

CMD ["grafana-server", "web"]
